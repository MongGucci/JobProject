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

import job.models.HireRepository;
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
	@Autowired
	HireRepository hrepo;
	
	@GetMapping("/select.do")
	public String selectGetHandle(WebRequest req) {
		
		List<Map> cate= rrepo.getAllCate();
		List<Map> big = rrepo.getAllBigLocation();
		List<Map> cotype= rrepo.getAllCotype();
		List<Map> hireshape=rrepo.getAllHireshape();
		req.setAttribute("cate",cate, req.SCOPE_REQUEST);
		req.setAttribute("big",big, req.SCOPE_REQUEST);
		req.setAttribute("cotype",cotype, req.SCOPE_REQUEST);
		req.setAttribute("hireshape",hireshape, req.SCOPE_REQUEST);
		
		List<Map> start = hrepo.getAllHiresByStartdate();
		List<Map> end = hrepo.getAllHiresByEnddate();
		List<Map> hits = hrepo.getAllHiresByHits();
		req.setAttribute("start",start, req.SCOPE_REQUEST);
		req.setAttribute("end",end, req.SCOPE_REQUEST);
		req.setAttribute("hits",hits, req.SCOPE_REQUEST);
		return "job.select";
	}
	
	@PostMapping(path="/selectajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String selectAjaxHandle(@RequestParam String big) {
		List<Map> small = rrepo.getAllSmallLocation(big);
	
		
		return gson.toJson(small);
	}
	
	@PostMapping("/select.do")
	public String selectPostHandle(@RequestParam Map param, Map map) {
	
		
		List<Map> results = hrepo.getSearchResults(param);
		map.put("lists",results);
		map.put("condition",param);
		return "job.selectdetail";
	}
	
	@GetMapping("/buttonselect.do")
	public String selectButtonGetHandle(@RequestParam Map param, Map map) {
		List<Map> results = hrepo.getSearchResults(param);
		map.put("lists",results);
		//System.out.println("버튼눌러나오는값 :"+results);
		map.put("condition",param);
		return "job.selectdetail";
	}
	
	
	
	@GetMapping("/jobpost.do")
	public String jobpostGetHandle(@RequestParam Map param, Map post) {
		int hino = (Integer)param.get("hino");
		System.out.println("hino: "+hino);
		Map company= hrepo.getHirebyHino(hino);
		System.out.println("companybyHino: " +company);
		post.put("list", company);
		System.out.println("list.CONAME/"+company.get("CONAME"));
		return "job.jobpost";
	}
	
	@GetMapping("/comdetail.do")
	public String comdetailGetHandle() {

		return "job.comdetail";
	}
	
}
