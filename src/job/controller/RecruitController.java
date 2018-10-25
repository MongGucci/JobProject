package job.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.RecruitRepository;

@Controller
@RequestMapping("/recruit")
public class RecruitController {

	/*
	@Autowired
	CompanyRepository crepo;
	*/
	@Autowired
	Gson gson;
	
	@Autowired
	RecruitRepository rrepo;
	
	@GetMapping("/select.do")
	public String selectGetHandle(WebRequest req) {
		/*List<Map> all = crepo.getAll();
		System.out.println("recruitController의 all : "+all);
		req.setAttribute("all", all, req.SCOPE_REQUEST);*/
		
		List<Map> cate= rrepo.getAllCate();
		List<Map> big = rrepo.getAllBigLocation();
		List<Map> cotype= rrepo.getAllCotype();
		List<Map> hireshape=rrepo.getAllHireshape();
		req.setAttribute("cate",cate, req.SCOPE_REQUEST);
		req.setAttribute("big",big, req.SCOPE_REQUEST);
		req.setAttribute("cotype",cotype, req.SCOPE_REQUEST);
		req.setAttribute("hireshape",hireshape, req.SCOPE_REQUEST);
		
		System.out.println("cate :" +cate);
		System.out.println("big :" +big);
		System.out.println("cotype :" +cotype);
		System.out.println("hireshape :" +hireshape);
		
		return "job.select";
	}
	
	@PostMapping(path="/selectajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String selectAjaxHandle(@RequestParam String big) {
		System.out.println("big: "+big);
		List<Map> small = rrepo.getAllSmallLocation(big);
		System.out.println("samll = " + small);
		
		return gson.toJson(small);
	}
	
	@PostMapping("/select.do")
	public String selectPostHandle(@RequestParam Map map, WebRequest web) {
		
		
		return "job.selectdetail";//경로정확히확인하기
	}
	
	
	
	@GetMapping("/jobpost.do")
	public String jobpostGetHandle() {
		
		
		return "job.jobpost";
	}
	
	@GetMapping("/comdetail.do")
	public String comdetailGetHandle() {

		return "job.comdetail";
	}
	
}
