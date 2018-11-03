package job.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
	
	
	@GetMapping("/select.do")
	public String selectGetHandle(Map map,@RequestParam Map param) {
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		
		List<Map> cate= rrepo.getAllCate();
		List<Map> big = rrepo.getAllBigLocation();
		List<Map> cotype= rrepo.getAllCotype();
		List<Map> hireshape=rrepo.getAllHireshape();
		map.put("cate",cate);
		map.put("big",big);
		map.put("cotype",cotype);
		map.put("hireshape",hireshape);
		
		List<Map> Totalstart = hrepo.getAllHiresByStartdate();
		List<Map> Totalend = hrepo.getAllHiresByEnddate();
		List<Map> Totalhits = hrepo.getAllHiresByHits();
		String pg = (String)param.get("page");
		String mode = (String)param.get("mode");
		System.out.println("pg.mode : "+pg+mode);
		int startpage = (Totalstart.size()%10==0) ? (Totalstart.size()/10):(Totalstart.size()/10)+1;
		int endpage = (Totalend.size()%10==0) ? (Totalend.size()/10):(Totalend.size()/10)+1;
		int hitspage= (Totalhits.size()%10==0) ? (Totalhits.size()/10):(Totalhits.size()/10)+1;
		map.put("startpage",startpage);
		map.put("endpage",endpage);
		map.put("hitspage",hitspage);
		
		if (pg!=null) {
			
			int page = Integer.parseInt(pg);
			Map m = new HashMap<>();
			m.put("s", ((page-1)*10)+1);
			m.put("e", page*10);
			Map o = new HashMap<>();
			o.put("s",1);
			o.put("e", 10);
			
			if(mode.equals("start")) {
				List<Map> start = hrepo.getStartByPage(m);
				List<Map> hits = hrepo.getHitsByPage(o);
				List<Map> end = hrepo.getEndByPage(o);
				System.out.println("페이지눌러들갈때 값 start "+start);
				System.out.println("페이지눌러들갈때 값 hits "+hits);
				System.out.println("페이지눌러들갈때 값 end "+end);
				map.put("start",start);
				map.put("hits",hits);
				map.put("end",end);
			}else if(mode.equals("hits")) {
				List<Map> start = hrepo.getStartByPage(m);
				List<Map> hits = hrepo.getHitsByPage(o);
				List<Map> end = hrepo.getEndByPage(m);
				map.put("start",start);
				map.put("hits",hits);
				map.put("end",end);
			}else if(mode.equals("end")) {
				List<Map> start = hrepo.getStartByPage(o);
				List<Map> hits = hrepo.getHitsByPage(o);
				List<Map> end = hrepo.getEndByPage(m);
				map.put("start",start);
				map.put("hits",hits);
				map.put("end",end);
			}else {
				
			}
	
		}else {
			Map m = new HashMap<>();
			m.put("s", 1);
			m.put("e", 10);
			
			
				List<Map> start = hrepo.getStartByPage(m);
				map.put("start",start);
		
				List<Map> hits = hrepo.getHitsByPage(m);
				map.put("hits",hits);
			
				List<Map> end = hrepo.getEndByPage(m);
				map.put("end",end);
	
		}
		/*	
		Map map = new HashMap<>();
		
		List<Map> list;
		if(param != null) {
			int page = Integer.parseInt(param);
			System.out.println(page);
			
			int start = (10 * (page-1))+1;
			int end = 10*page;
			map.put("start", start);
			map.put("end", end);
			list = dao.boardList(map);
			
		}else {
			map.put("start", 1);
			map.put("end", 10);
			list = dao.boardList(map);
		}
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		web.setAttribute("listcnt", listcnt, web.SCOPE_REQUEST);
		return "user.board";
		*/ 
		
		List<Map> dead = hrepo.getDeadLine6();
		System.out.println(dead);
		map.put("dead",dead);
		
	
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
	   public String jobpostGetHandle(@RequestParam Map param, Map post,WebRequest wr, ModelMap map) {
	      SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
	      String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
	      int hino = Integer.parseInt((String)param.get("hino"));
	      Map company= hrepo.getHirebyHino(hino);
	      Date start = (Date) company.get("STARTDATE");
	      Date end = (Date)company.get("ENDDATE");
	      company.put("START", fmt.format(start));
	      company.put("END", fmt.format(end));
	      long gap = end.getTime()-System.currentTimeMillis();
	      if(gap<0) {
	         company.put("MAGAM",true);
	      }
	      post.put("list", company);
	      
	       if(id == null) {
	            return "job.jobpost";
	         }
	       
	      
	      
	      Map sd = new HashMap<>();
	       sd.put("id", id);
	       sd.put("hino", hino);
	       
	       List<Map> cd = phrepo.myjjim(sd);
	       if(cd.size() == 0) {
	          int c = phrepo.pickHire(sd);
	          return "job.jobpost";
	       } else {
	          map.put("jjim", "on");
	          return "job.jobpost";
	       }
	       
	   }

	
	   @GetMapping("/jjim.do")
	      public String schbtn(WebRequest wr, ModelMap map) {
	         String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
	         String hino = wr.getParameter("hino");
	         System.out.println("hino:"+ hino);
	         
	         if (id == null) {
	            return "/login/login";
	         } else {
	            return "redirect:/recruit/jobpost.do?hino="+ hino;
	            
	         }
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
