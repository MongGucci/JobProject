package job.controller;

import java.io.File;
import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import job.models.EssayRepository;
import job.models.ShareEssayRepository;

@Controller
@RequestMapping("/essayBoard")
public class ShareEssayController {
	@Autowired
	ServletContext sc;
	@Autowired
	EssayRepository essay;

	@Autowired
	ShareEssayRepository shareEssay;

	@Autowired
	Gson gson;

	@GetMapping("/shareEssay.do")
	public String shareEssayGetHandle(WebRequest web) {
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd.HH:mm");

		List<Map> list = essay.getJobCate();
		System.out.println(list);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		List<Map> essaylist = essay.getMyEssay("yyj");
		for (int i = 0; i < essaylist.size(); i++) {
			Map map = essaylist.get(i);
			Date date = (Date) map.get("LASTDATE");
			map.put("LASTDATE", fmt.format(date));

		}

		web.setAttribute("essaylist", essaylist, web.SCOPE_REQUEST);

		return "essayBoard.shareEssay";
	}

	@PostMapping("/shareEssay.do")
	public String shareEssayPostHandle(@RequestParam(required = false) MultipartFile attach, @RequestParam Map map,
			WebRequest web) throws IllegalStateException, IOException {
		System.out.println("공유 게시판");
		// String userId = (String)web.getAttribute("userId", web.SCOPE_SESSION);
		map.put("id", "yyj");
		
			if (!attach.isEmpty()) {
				String real = sc.getRealPath("/");
				String filename = attach.getOriginalFilename();
				long now = System.currentTimeMillis();
				String nowfolder = String.valueOf(now);

				String path = real + "storage/share/" + nowfolder; // 저장 경로
				String clientpath = "/storage/share/" + nowfolder + "/" + filename; // dao에 저장

				File dest = new File(path);
				if (!dest.exists()) {
					dest.mkdirs();
				}
				File dst = new File(dest, filename);

				attach.transferTo(dst);
				map.put("path", clientpath);
			} else {
				map.put("path", "");
			}
		
		System.out.println(map);
		shareEssay.setShareEssay(map);

		return "redirect:/essayBoard/shareEssay.do";
	}

	@PostMapping(path = "/essayAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String essayAjaxHandle(@RequestParam String jasono) {
		System.out.println("jasono: " + jasono);

		Map myEssay = essay.getDetailEssay(jasono);
		System.out.println(myEssay);
		return gson.toJson(myEssay);

	}
	
	//========================================================================================================
	
	
	@GetMapping("/shareEssayList.do")
	public String shareEssayListGetHandle(WebRequest web) {
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd.HH:mm");
		List<Map> essays = shareEssay.getShareEssay();
		
		
		for (int i = 0; i < essays.size(); i++) {
			Map map = essays.get(i);
			Date date = (Date) map.get("WRITEDATE");
			map.put("WRITEDATE", fmt.format(date));

		}
		
		web.setAttribute("essays", essays, web.SCOPE_REQUEST);
		return "essayBoard.shareEssayList";
	}
	
	@GetMapping("/essayBoardDetail.do")
	public String essayBoardDetailGetHandle(WebRequest web) {
		String no = web.getParameter("no");
		Map map = shareEssay.getShareDetail(no);
		for (int i = 1; i < 5; i++) {
			if (map.get("A" + i) != null) {
				String a = (String) map.get("A" + i);
				a = a.replace("\r\n", "<br>");
				map.put("A" + i, a);
			}
			if (map.get("Q" + i) != null) {
				String q = (String) map.get("Q" + i);
				q = q.replace("\r\n", "<br>");
				map.put("Q" + i, q);
			}
		}
		String FILE = ((String)map.get("PATH")).substring(((String)map.get("PATH")).lastIndexOf("/")+1);
		map.put("FILE", FILE);
		web.setAttribute("essay", map, web.SCOPE_REQUEST);
		return "essayBoard.shareEssayDetail";
	}
}
