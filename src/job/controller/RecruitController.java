package job.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import job.models.PickedhireRepository;
import job.models.RecruitRepository;
import job.models.ReviewRepository;

@Controller
@RequestMapping("/recruit")
public class RecruitController {

	@Autowired
	Gson gson;
	@Autowired
	RecruitRepository rrepo;
	@Autowired
	HireRepository hrepo;
	@Autowired
	PickedhireRepository phrepo;
	@Autowired
	ReviewRepository rvrepo;
	
	
	@GetMapping("/select.do")
	public String selectGetHandle(Map map) {
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		
		List<Map> cate= rrepo.getAllCate();
		List<Map> big = rrepo.getAllBigLocation();
		List<Map> cotype= rrepo.getAllCotype();
		List<Map> hireshape=rrepo.getAllHireshape();
		map.put("cate",cate);
		map.put("big",big);
		map.put("cotype",cotype);
		map.put("hireshape",hireshape);
		
		List<Map> start = hrepo.getAllHiresByStartdate();
		List<Map> end = hrepo.getAllHiresByEnddate();
		List<Map> hits = hrepo.getAllHiresByHits();
		
		for (int i = 0; i < start.size(); i++) {
			Map m = start.get(i);
			Date date = (Date) m.get("STARTDATE");
			map.put("startdate", fmt.format(date));
		}
		
		for (int i = 0; i < end.size(); i++) {
			Map m = end.get(i);
			Date date = (Date) m.get("ENDDATE");
			map.put("enddate", fmt.format(date));
		}

		map.put("start",start);
		map.put("end",end);
		map.put("hits",hits);
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
		
		for (int i = 0; i < results.size(); i++) {
			SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
			Date start = (Date)results.get(i).get("STARTDATE");
			Date end = (Date)results.get(i).get("ENDDATE");
			map.put("enddate", fmt.format(end));
			map.put("startdate", fmt.format(start));
		}
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
		System.out.println("param : "+param);
		int hino = Integer.parseInt((String)param.get("hino"));
		System.out.println("hino: "+hino);
		Map company= hrepo.getHirebyHino(hino);
		System.out.println("companybyHino: " +company);
		post.put("list", company);
		System.out.println("list.CONAME/"+company.get("CONAME"));
		return "job.jobpost";
	}
	
	@GetMapping("/comdetail.do")
	public String comdetailGetHandle(WebRequest session, Map review) {
		String id =(String)session.getAttribute("userId", session.SCOPE_SESSION);
		int cono =(int)session.getAttribute("cono",session.SCOPE_SESSION);
		Map map = new HashMap();
		map.put("id", id);
		map.put("cono",cono);
		Map didI = rvrepo.didIWriteReview(map);
		System.out.println("썻냐안썻냐"+didI);
		if(didI==null) {
			session.setAttribute("youwrote", true, session.SCOPE_SESSION);
		}
		review.put("review",rvrepo.getReviewsByCono(cono));
		return "job.schdetail.index";
	}
	
	@PostMapping(path="/pickhireajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String pickhireAjaxHandle(@RequestParam Map map) {
		int r = phrepo.pickHire(map);
		if(r==1) {
			return gson.toJson(true);
		}else {
			return gson.toJson(false);
		}
	}
	
	@PostMapping("/review.do")
	public String writeReviewHandle(WebRequest session,@RequestParam Map param) {
		System.out.println("param :"+param);
		
		String s= (String)param.get("star");
		String good= (String)param.get("good");
		String bad= (String)param.get("bad");
		String id =(String)session.getAttribute("userId", session.SCOPE_SESSION);
		int star=Integer.parseInt(s);
		System.out.println("cono: "+param.get("cono"));
		String no = (String)param.get("cono");
		int cono = Integer.parseInt(no);
		
		//System.out.println(s+"/"+star+"/"+good+"/"+bad+"/"+id+"/"+cono);
		
		Map map = new HashMap();
		map.put("id",id);
		map.put("good",good);
		map.put("bad",bad);
		map.put("star",star);
		map.put("cono", cono);
		int r = rvrepo.writeReview(map);
		System.out.println("r/"+r);
		System.out.println("map : "+map);
		if(r==1) {
			session.setAttribute("sucess", true, session.SCOPE_REQUEST);
			return "redirect:/search/schdetail.do?no="+cono;
		}else {
			session.setAttribute("fail", true, session.SCOPE_REQUEST);
			return "redirect:/search/schdetail.do?no="+cono;
		}
	}
}
