package job.controller;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.EssayRepository;

@Controller
@RequestMapping("/essay")
public class EssayController {
	@Autowired
	EssayRepository essay;

	@Autowired
	Gson gson;

	@GetMapping("/essayWrite.do")
	public String writeGetHandle(WebRequest web) {
		List<Map> list = essay.getJobCate();
		System.out.println(list);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		return "essay.essayWrite";
	}

	@PostMapping("/essayWrite.do")
	public String writePostHandle(@RequestParam Map map) {

		String jasono = UUID.randomUUID().toString().split("-")[0];
		map.put("jasono", jasono);
		map.put("id", "yyj"); // 나중 되면 session에 저장된 아이디로 바뀜

		System.out.println(map);
		int r = essay.setMyEssay(map);

		return "essay.essayWrite";
	}
	// ====================================================================
	// 내 자소서 리스트 가져오기

	@GetMapping("/myEssay.do")
	public String myEssayGetHandle(WebRequest web) {
		String userId = (String) web.getAttribute("userId", web.SCOPE_SESSION);
		List<Map> myEssay = essay.getMyEssay(userId);// session userId
		System.out.println(myEssay);

		web.setAttribute("myEssay", myEssay, web.SCOPE_REQUEST);

		return "essay.myEssay";
	}

	// ==================================================================
	// 내 자소서 수정

	@GetMapping("/essayChange.do")
	public String essayChangeGetHandle(WebRequest web) {
		String no = web.getParameter("no");
		Map myEssay = essay.getDetailEssay(no);
		List<Map> list = essay.getJobCate();
		System.out.println(myEssay);

		web.setAttribute("list", list, web.SCOPE_REQUEST);
		web.setAttribute("no", no, web.SCOPE_SESSION);
		web.setAttribute("myEssay", myEssay, web.SCOPE_REQUEST);
		return "essay.essayChange";
	}

	@PostMapping("/essayChange.do")
	public String essayChangePostHandle(@RequestParam Map map, WebRequest web) {

		int r = essay.updateEssay(map);
		System.out.println(r);
		if (r != -1) {
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

	@GetMapping("/essay.do")
	public String essayGetHandle(WebRequest web) {
		List<Map> list = essay.getHire();
		List<Map> cate = essay.getJobCate();
		for(int i=0;i<list.size();i++) {
			Map map = list.get(i);
			
			java.sql.Timestamp timeStamp = (Timestamp) map.get("ENDDATE");
	        java.sql.Date date = new java.sql.Date(timeStamp.getTime()); 
	        long end = date.getTime();
	        long current = System.currentTimeMillis();
	        long day = (end-current)/(1000*60*60*24);
	        if(day == 0) {
	        	map.put("DDAY", "D-DAY");
	        }else {
	        	map.put("DDAY", "D-"+day);
	        }
	        System.out.println((end-current)/(1000*60*60*24));
			
		}
		web.setAttribute("cate", cate, web.SCOPE_REQUEST);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		return "essay/essay";
	}

	@PostMapping(path = "/essayPostAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String essayPostAjaxHandle(@RequestParam String hino) {

		System.out.println("hino: " + hino);
		Integer no = Integer.parseInt(hino);
		Map map = essay.getJasoForm(no);
		return gson.toJson(map);

	}

	@PostMapping(path = "/essayMenuAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String essayMenuAjaxHandle(@RequestParam String menu) {

		System.out.println("menu: " + menu);
		List<Map> list = null;
		
		switch (menu) {
		case "hire":

			break;
		case "pass":
			list = essay.getPassJaso();
			break;
		case "myessay":

			break;

		
		}
		

		return gson.toJson(list);

	}
}
