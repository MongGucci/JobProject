package job.controller;

import java.sql.Timestamp;
import java.util.HashMap;
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
import job.models.EssayService;

@Controller
@RequestMapping("/essay")
public class EssayController {
	@Autowired
	EssayRepository essay;

	@Autowired
	Gson gson;
	
	@Autowired
	EssayService essayservice;

	@GetMapping("/essayWrite.do")
	public String writeGetHandle(WebRequest web) {
		List<Map> list = essay.getJobCate();
		System.out.println(list);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		return "essay.essayWrite";
	}

	@PostMapping("/essayWrite.do")
	public String writePostHandle(@RequestParam Map map,WebRequest web) {
		
		String id = (String) web.getAttribute("userId", web.SCOPE_SESSION);
		String jasono = UUID.randomUUID().toString().split("-")[0];
		if(map.get("hino").equals("")) {
			map.put("hino", 0);
		}else {
			int hino = Integer.parseInt( (String) map.get("hino"));
			map.put("hino", hino);
		}
		
		map.put("jasono", jasono);
		map.put("id", id); // 나중 되면 session에 저장된 아이디로 바뀜

		System.out.println(map);
		int r = essay.setMyEssay(map);

		return "redirect:/essay/essay.do";
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
		String page = web.getParameter("page");
		int total = essay.totalHire();
		System.out.println("total:"+total);
		int listcnt = total/10;
		if(total%10 !=0) {
			listcnt++;
		}
		
		List<Map> cate = essay.getJobCate();
		Map pageMap = new HashMap<>();
		
		List<Map> list;
		if(page != null) {
			int param = Integer.parseInt(page);
			System.out.println(page);
			
			int start = (10 * (param-1))+1;
			int end = 10*param;
			pageMap.put("start", start);
			pageMap.put("end", end);
			System.out.println(pageMap);
			list = essay.getHire(pageMap);
			
		}else {
			pageMap.put("start", 1);
			pageMap.put("end", 10);
			System.out.println(pageMap);
			list = essay.getHire(pageMap);
		}
		System.out.println(list);
		
		
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
		web.setAttribute("listcnt", listcnt, web.SCOPE_REQUEST);
		web.setAttribute("page", page, web.SCOPE_REQUEST);
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
				list = essayservice.hireAjax();
			break;
		case "pass":
			list = essay.getPassJaso();
			break;
		case "myessay":

			break;

		
		}
		

		return gson.toJson(list);

	}
	
	@PostMapping(path = "/passJasoAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String passJasoAjaxHandle(@RequestParam String passno) {

		System.out.println("menu: " + passno);
		int no = Integer.parseInt(passno);
		Map map = essay.getPassJasoOne(no);
		
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
		

		return gson.toJson(map);

	}
}
