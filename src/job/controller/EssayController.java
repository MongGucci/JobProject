package job.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy.MM.dd.HH:mm");
		Date date = new Date(System.currentTimeMillis());
		
		map.put("id", "yyj");
		map.put("leftdate", fmt.format(date));
		System.out.println(map);
		int r = essay.setMyEssay(map);
		System.out.println(r);
		return "essay.essayWrite";
	}
	
	@GetMapping("/myEssay.do")
	public String myEssayGetHandle(WebRequest web) {
		List<Map> myEssay = essay.getMyEssay("yyj");
		System.out.println(myEssay);
		web.setAttribute("myEssay", myEssay, web.SCOPE_REQUEST);
		return "essay.myEssay";
	}
	
	@GetMapping("/essayChange.do")
	public String essayChangeGetHandle(WebRequest web) {
		String no = web.getParameter("no");
		Map myEssay = essay.getDetailEssay(no);
		web.setAttribute("no", no, web.SCOPE_SESSION);
		web.setAttribute("myEssay", myEssay, web.SCOPE_REQUEST);
		return "essay.essayChange";
	}
	@PostMapping("/essayChange.do")
	public String essayChangePostHandle(@RequestParam Map map,WebRequest web) {
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy.MM.dd.HH:mm");
		Date date = new Date(System.currentTimeMillis());
		
		
		map.put("leftdate", fmt.format(date));
		System.out.println(map);
		String no = (String)web.getAttribute("no", web.SCOPE_SESSION);
		map.put("no", no);
		int r = essay.updateEssay(map);
		System.out.println(r);
		if(r != -1) {
			web.removeAttribute("no", web.SCOPE_SESSION);
		}
		return "redirect:/essay/myEssay.do";
	}
}
