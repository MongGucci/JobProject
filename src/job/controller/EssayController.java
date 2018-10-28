package job.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.models.EssayRepository;

@Controller
@RequestMapping("/essay")
public class EssayController {
	@Autowired
	EssayRepository essay;

	@GetMapping("/essayWrite.do")
	public String writeGetHandle(WebRequest web) {
		List<Map>list= essay.getJobCate();
		System.out.println(list);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		return "essay.essayWrite";
	}
	
	
	
	@PostMapping("/essayWrite.do")
	public String writePostHandle(@RequestParam Map map) {
		
		
		String jasono = UUID.randomUUID().toString().split("-")[0];
		map.put("jasono", jasono);
		map.put("id", "yyj"); //나중 되면 session에 저장된 아이디로 바뀜
		
		System.out.println(map);
		int r = essay.setMyEssay(map);
		
		return "essay.essayWrite";
	}
	//====================================================================
	//내 자소서 리스트 가져오기
	
	@GetMapping("/myEssay.do")
	public String myEssayGetHandle(WebRequest web) {
		//String userId = (String)web.getAttribute("userId", web.SCOPE_SESSION);
		List<Map> myEssay = essay.getMyEssay("yyj");//session userId
		System.out.println(myEssay);
		
		web.setAttribute("myEssay", myEssay, web.SCOPE_REQUEST);
		
		return "essay.myEssay";
	}
	
	
	//==================================================================
	//내 자소서 수정
	
	@GetMapping("/essayChange.do")
	public String essayChangeGetHandle(WebRequest web) {
		String no = web.getParameter("no");
		Map myEssay = essay.getDetailEssay(no);
		List<Map>list= essay.getJobCate();
		System.out.println(myEssay);
		
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		web.setAttribute("no", no, web.SCOPE_SESSION);
		web.setAttribute("myEssay", myEssay, web.SCOPE_REQUEST);
		return "essay.essayChange";
	}
	@PostMapping("/essayChange.do")
	public String essayChangePostHandle(@RequestParam Map map,WebRequest web) {
		
		
		
		
		
		int r = essay.updateEssay(map);
		System.out.println(r);
		if(r != -1) {
			web.removeAttribute("no", web.SCOPE_SESSION);
		}
		return "redirect:/essay/myEssay.do";
	}
	
	@GetMapping("/myEssayDetail.do")
	public String myEssayDetailGetHandle(WebRequest web) {
		String no = web.getParameter("no");
		Map myEssay = essay.getDetailEssay(no);
		for (int i = 1; i < 5; i++) {
			if (myEssay.get("A" + i) != null) {
				String a = (String) myEssay.get("A" + i);
				a = a.replace("\r\n", "<br>");
				myEssay.put("A" + i, a);
			}
			if (myEssay.get("Q" + i) != null) {
				String q = (String) myEssay.get("Q" + i);
				q = q.replace("\r\n", "<br>");
				myEssay.put("Q" + i, q);
			}
		}
		web.setAttribute("essay", myEssay, web.SCOPE_REQUEST);
		return "essay.myEssayDetail";
	}
}
