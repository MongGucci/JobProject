package job.controller;

import java.io.File;
import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import job.models.AlertService;
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
	
	@Autowired
	AlertService alert;

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

	// ========================================================================================================

	@GetMapping("/shareEssayList.do")
	public String shareEssayListGetHandle(WebRequest web,@RequestParam String array) {
		List<Map> essays = null;
		if(array.equals("popular")) {
			
			essays = shareEssay.getShareEssayPopular();
		}else {
			essays = shareEssay.getShareEssay();
			
		}
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd.HH:mm");
		

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
		int ino = Integer.parseInt(no);
		shareEssay.addInquire(ino);
		
		Integer jasono = Integer.parseInt(no); 
		Map map = shareEssay.getShareDetail(no);
		List<Map> reply = shareEssay.getReply(jasono);
		if(web.getAttribute("userId", web.SCOPE_SESSION) != null) {

		Map likeMap = new HashMap<>();
		likeMap.put("jasono", no);
		likeMap.put("id", web.getAttribute("userId", web.SCOPE_SESSION));
		Map like = shareEssay.myLike(likeMap);
		web.setAttribute("like", like, web.SCOPE_REQUEST);
		}
		
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
		if (map.get("PATH") != null) {
			String FILE = ((String) map.get("PATH")).substring(((String) map.get("PATH")).lastIndexOf("/") + 1);
			map.put("FILE", FILE);
		}
		System.out.println( "essay : " + map);
		
		web.setAttribute("essay", map, web.SCOPE_REQUEST);
		web.setAttribute("reply", reply, web.SCOPE_REQUEST);
		return "essayBoard.shareEssayDetail";
	}

	@PostMapping(path = "/essayLikeAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String essayLikeAjaxHandle(@RequestParam Integer no, WebRequest web) {

		Map like = new HashMap<>();

		String id = (String) web.getAttribute("userId", web.SCOPE_SESSION);
		Map map = new HashMap<>();
		map.put("id", id);
		map.put("no", no);
		System.out.println(map);

		try {
			int r = shareEssay.setLike(map);
			if (r != -1) {
				int a = shareEssay.addLike(no);
				like.put("like", true);

			}

		} catch (Exception e) {
			like.put("like", false);
		}

		return gson.toJson(like);

	}
	
	
	//===========================================================================
	//181028 
	@GetMapping("/reply.do")
	public String replyGetHandle(@RequestParam Map map) {
		System.out.println(map);
		int no = Integer.parseInt((String) map.get("no"));
		int r = shareEssay.updateReply(no);
		return "redirect:/essayBoard/essayBoardDetail.do?no="+map.get("jasono");
		
	}
	
	
	@PostMapping("/reply.do")
	public String replyPostHandle(@RequestParam Map map,WebRequest web) {
		
		
		String id = (String) web.getAttribute("userId", web.SCOPE_SESSION);
		map.put("writer", id);
		map.put("parent", "");
		map.put("flag", "T");
		map.put("verify", "N");
		
		String replyid = (String)map.get("replyid");
		Map msg = new HashMap<>();
		msg.put("mode", "reply");

		msg.put("msg", map.get("replyid")+"님이 올린 자소서에 댓글이 올라왔습니다.");
		msg.put("link", map.get("jasono"));
		
		alert.sendOne(msg, replyid);
		
		
		
		int r = shareEssay.setReply(map);
		System.out.println(map.get("jasono"));
		
		//web.setAttribute("no", map.get("jasono"), web.SCOPE_REQUEST);
		return "redirect:/essayBoard/essayBoardDetail.do?no="+map.get("jasono");
		
	}
	
	@PostMapping("/replyComment.do")
	
	public String replyCommentPostHandle(@RequestParam Map map,WebRequest web) {
		System.out.println(map);
		String id = (String) web.getAttribute("userId", web.SCOPE_SESSION);
		map.put("writer", id);
		map.put("flag", "T");
		map.put("verify", "N");
		
		String replyid = (String)map.get("replyid");
		Map msg = new HashMap<>();
		msg.put("mode", "reply");

		msg.put("msg", map.get("replyid")+"님의 댓글에 답글이 올라왔습니다.");
		msg.put("link", map.get("jasono"));
		alert.sendOne(msg, replyid);
		
		
		int r = shareEssay.setReply(map);
		return "redirect:/essayBoard/essayBoardDetail.do?no="+map.get("jasono");
		
		
		
	}
	
	@GetMapping("/shareEssayDelete.do")
	public String  shareEssayDeleteHandle(@RequestParam String no) {
		int jasono = Integer.parseInt(no);
		int r = shareEssay.deletePicked(jasono);
		int t = shareEssay.deleteShareEssay(jasono);
		
		return "redirect:/essayBoard/shareEssayList.do";
	}
	
	
	
	
	
	
	
	
	
}
