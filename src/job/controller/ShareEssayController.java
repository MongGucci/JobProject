package job.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

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

	@GetMapping("/shareEssay.do")
	public String shareEssayGetHandle(WebRequest web) {
		
		List<Map>list= essay.getJobCate();
		System.out.println(list);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		
		return "essayBoard.shareEssay";
	}

	@PostMapping("/shareEssay.do")
	public String shareEssayPostHandle(@RequestParam MultipartFile attach, @RequestParam Map map, WebRequest web) throws IllegalStateException, IOException {
		System.out.println("공유 게시판");
		//String userId = (String)web.getAttribute("userId", web.SCOPE_SESSION);
		map.put("id", "yyj");
		if (!attach.isEmpty()) {
			String real = sc.getRealPath("/");
			String filename = attach.getOriginalFilename();
			long now = System.currentTimeMillis();
			String nowfolder = String.valueOf(now);
			
			String path = real + "storage/share/"+nowfolder; //저장 경로
			String clientpath = "/storage/share/"+nowfolder+"/"+ filename; //dao에 저장
			
			
			
			File dest = new File(path);
			if (!dest.exists()) {
				dest.mkdirs();
			}
			File dst = new File(dest,filename);
			
			attach.transferTo(dst);
			map.put("path",clientpath);
		}else {
			map.put("path","");
		}
		System.out.println(map);
		shareEssay.setShareJaso(map);
		
		return "essayBoard.shareEssay";
	}

}