package job.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.AlertService;
import job.models.HireRepository;
import job.models.PickedhireRepository;
import job.models.RecruitRepository;
import job.models.ReviewRepository;
import job.models.SoarRepository;

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
	@Autowired
	AlertService alert;
	@Autowired
	SoarRepository soar;
	
	 @Autowired
	  HttpSession session;
	
	
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
		
		List<Map> dead = hrepo.getDeadLine6();
		System.out.println(dead);
		
		for (int i = 0; i < start.size(); i++) {
			Map m = start.get(i);
			Date date = (Date) m.get("STARTDATE");
			Date dd = (Date)m.get("ENDDATE");
			long endd =dd.getTime();
			m.put("STARTDATE", fmt.format(date));
			m.put("ENDDATE",fmt.format(dd) );
			long gap = endd-System.currentTimeMillis();
			if(gap<0) {
				m.put("MAGAM",true);
			}
			//System.out.println("마감?"+m.get("MAGAM"));
			//System.out.println("startdate:"+fmt.format(date) );
		}
		
		for (int i = 0; i < end.size(); i++) {
			Map m = end.get(i);
			Date date = (Date) m.get("STARTDATE");
			Date dd = (Date) m.get("ENDDATE");
			long endd =dd.getTime();
			m.put("STARTDATE", fmt.format(date));
			m.put("ENDDATE",fmt.format(dd));
			long gap = endd-System.currentTimeMillis();
			if(gap<0) {
				m.put("MAGAM",true);
			}
		}

		for (int i = 0; i < hits.size(); i++) {
			Map m = hits.get(i);
			Date date = (Date) m.get("STARTDATE");
			Date dd = (Date) m.get("ENDDATE");
			long endd =dd.getTime();
			m.put("STARTDATE", fmt.format(date));
			m.put("ENDDATE",fmt.format(dd));
			long gap = endd-System.currentTimeMillis();
			if(gap<0) {
				m.put("MAGAM",true);
			}
		}
		map.put("dead",dead);
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
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		List<Map> results = hrepo.getSearchResults(param);
		map.put("lists",results);
		for (int i = 0; i < results.size(); i++) {
			Map m = results.get(i);
			Date date = (Date) m.get("STARTDATE");
			Date dd = (Date) m.get("ENDDATE");
			long endd =dd.getTime();
			m.put("STARTDATE", fmt.format(date));
			m.put("ENDDATE",fmt.format(dd));
			long gap = endd-System.currentTimeMillis();
			if(gap<0) {
				m.put("MAGAM",true);
			}
		}
		
		map.put("condition",param);
		
		
		return "job.selectdetail";
	}
	
	@GetMapping("/buttonselect.do")
	public String selectButtonGetHandle(@RequestParam Map param, Map map) {
		List<Map> results = hrepo.getSearchResults(param);
		map.put("lists",results);

		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		for (int i = 0; i < results.size(); i++) {
			Map m = results.get(i);
			Date date = (Date) m.get("STARTDATE");
			Date dd = (Date) m.get("ENDDATE");
			long endd =dd.getTime();
			m.put("STARTDATE", fmt.format(date));
			m.put("ENDDATE",fmt.format(dd));
			long gap = endd-System.currentTimeMillis();
			if(gap<0) {
				m.put("MAGAM",true);
			}
		}
		System.out.println(" 이상하네 : "+map);
		map.put("condition",param);
		
		return "job.selectdetail";
	}
	
	@GetMapping("/jobpost.do")
	public String jobpostGetHandle(@RequestParam Map param, Map post,WebRequest wr) {
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		int hino = Integer.parseInt((String)param.get("hino"));
		Map company= hrepo.getHirebyHino(hino);
		System.out.println("company:"  +company);
		
		int cono = ((BigDecimal) company.get("CONO")).intValue();
		Map comp = soar.getCompany(cono); 
	      System.out.println("id:" +session.getId());
	      
	      if(comp == null) {
	    	  Map skyrocket = new HashMap<>();
	    	  List<String> inner = new ArrayList<>();
	          skyrocket.put("cono", cono);
	          skyrocket.put("cnt", 1);
	          inner.add(session.getId());
	          skyrocket.put("inner", inner);
	         
	    	  soar.insertCompany(skyrocket);
	    	  
	      }else {
	    	  List in = (List) comp.get("inner");
	    	  if(!in.contains(session.getId())) {
	    		  in.add(session.getId());
	    		  int count = (int) comp.get("cnt");
	        	  count += 1;
	        	  soar.updateComapny(cono, count,in);
	    	  }
	    	  
	      }
		
		
		Date start = (Date) company.get("STARTDATE");
		Date end = (Date)company.get("ENDDATE");
		company.put("START", fmt.format(start));
		company.put("END", fmt.format(end));
		long gap = end.getTime()-System.currentTimeMillis();
		if(gap<0) {
			company.put("MAGAM",true);
		}
		post.put("list", company);
		
		if(wr.getAttribute("id", wr.SCOPE_SESSION) != null) {
			
			Map jjimap = new HashMap<>();
			jjimap.put("hino", hino);
			jjimap.put("id", wr.getAttribute("userId", wr.SCOPE_SESSION));
			
			Map jjim = phrepo.myjjim(jjimap);
			wr.setAttribute("jjim", jjim, wr.SCOPE_REQUEST);
		}
		
		return "job.jobpost";
	}
	
	@PostMapping(path = "/recruitjjimAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String recruitjjimAjaxHandle(@RequestParam Integer hino, WebRequest wr) {
		Map jjim = new HashMap<>();
		
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map map = new HashMap<>();
		map.put("id", id);
		map.put("hino", hino);
		System.out.println(map);
		
		int r = phrepo.pickHire(map);
		
		return gson.toJson(jjim);
	}
	
//	@GetMapping("/comdetail.do")
//	public String comdetailGetHandle(WebRequest session, Map review) {
//		System.out.println("여기는 어디???");
//		String id =(String)session.getAttribute("userId", session.SCOPE_SESSION);
//		int cono =(int)session.getAttribute("cono",session.SCOPE_SESSION);
//		Map map = new HashMap();
//		map.put("id", id);
//		map.put("cono",cono);
//		System.out.println(soar.getCompany(cono));
//		Map didI = rvrepo.didIWriteReview(map);
//		System.out.println("썻냐안썻냐"+didI);
//		if(didI==null) {
//			session.setAttribute("youwrote", true, session.SCOPE_SESSION);
//		}
//		review.put("review",rvrepo.getReviewsByCono(cono));
//		return "job.schdetail.index";
//	}
	
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
			return "redirect:/search/schdetail.do?cono="+cono;
		}else {
			session.setAttribute("fail", true, session.SCOPE_REQUEST);
			return "redirect:/search/schdetail.do?cono="+cono;
		}
	}
	
	@GetMapping("/newpost.do")
	public void newpostGetHandle(WebRequest wr) {
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map msg = new HashMap<>();
		
		
		msg.put("mode", "newpost");
		msg.put("msg", id+"님이 찜한 기업의 공고가 새로 올라왔습니다.");
		msg.put("link",1113);
		//msg.put("link", 보낸값에서 cono뽑기);
		alert.sendOne(msg, "skdbs0610");
	}
	
	
}
