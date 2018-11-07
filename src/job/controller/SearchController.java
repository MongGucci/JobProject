package job.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

import job.dao.chartDao;
import job.dao.searchDao;
import job.models.CompanyRepository;
import job.models.HireRepository;
import job.models.ReviewRepository;
import job.models.SoarRepository;

@Controller
@RequestMapping("/search")
public class SearchController {
   @Autowired
   searchDao searchdao;

   @Autowired
   HireRepository hrepo;

   @Autowired
   ReviewRepository rvrepo;
   
   @Autowired
   CompanyRepository crepo;
   
   @Autowired
   chartDao chartdao;
   
   @Autowired
   Gson gson;
   
   @Autowired
   SoarRepository soar;
   
  @Autowired
  HttpSession session;

   @GetMapping("/search.do")
   public String searchGetHandle(Map map) {

     List<Map> company = crepo.getAll();
     map.put("company", company);
      return "job.search";
   }

   // 검색
   @PostMapping("/search.do")
   public String searchPostHandle(WebRequest wr) {
      String coname = (String) wr.getParameter("search");
      wr.setAttribute("coname", coname, wr.SCOPE_SESSION);
      System.out.println(coname);
      List<Map> cks = searchdao.cksearch(coname);
      System.out.println(cks);
      if (coname.equals("") || cks.size() == 0) {
         wr.setAttribute("conames", coname, wr.SCOPE_SESSION);
         return "job.schnull.index";
      } else {
         List<Map> sli = searchdao.schlist(coname);
         System.out.println(sli);
         wr.setAttribute("sli", sli, wr.SCOPE_SESSION);
         return "job.schlist.index";
      }
   }

   // 요게 상세보기
   @RequestMapping("/schdetail.do")
   public String detailHandle(WebRequest wr, Map map) {
     String no = (String)wr.getParameter("cono");
      int cono = Integer.parseInt(no);
     
      
      
      String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
      Map dt = searchdao.searchcom(cono);
      System.out.println("dtdtdtd:" + dt);
      wr.setAttribute("dt", dt, wr.SCOPE_REQUEST);
   
      List<Map> hiring = hrepo.getHirebyCono(cono);
      map.put("hiring", hiring);
      
      Map ch = new HashMap<>();
      ch.put("cono", cono);
      List<Map> chart = chartdao.comchart(ch);
      map.put("chart", chart);
      System.out.println("차트를 뽑아보자 : " +  chart);
      
      if(id == null) {
          return "job.schdetail.index";
       }
      
      if(id!=null) {
         Map mm = new HashMap();
         mm.put("id", id);
         mm.put("cono",cono);
         Map didI = rvrepo.didIWriteReview(mm);
         
         Map comap = new HashMap<>();
         comap.put("id", id);
         comap.put("cono", cono);
         
         List<Map> comjjim = searchdao.ckbtn(comap);
         wr.setAttribute("comjjim", comjjim, wr.SCOPE_REQUEST);
         
         System.out.println("썻냐안썻냐"+didI);
         if(didI!=null) {
            map.put("youwrote", true);
         }
      }
      
      List<Map> reviews = rvrepo.getReviewsByCono(cono);
      map.put("reviews", reviews);
      
      int avg = rvrepo.getAvgStar(cono);
      if(avg==0) {
         map.put("avg", 0);
      }else {
         map.put("avg", avg);
      }
      
      Map sd = new HashMap<>();
      sd.put("id", id);
      sd.put("cono", cono);
      
      //==============================
      String coname = (String) dt.get("CONAME");
      System.out.println("어딘???:" + soar.getCompany(coname));
      Map company = soar.getCompany(coname); 
      List<Map> before = soar.getAllSoar();
      System.out.println(before);
      System.out.println("id:" +session.getId());
      
      if(company == null) {
         Map skyrocket = new HashMap<>();
         List<String> inner = new ArrayList<>();
          skyrocket.put("coname", coname);
          skyrocket.put("cono", cono);
          skyrocket.put("cnt", 1);
          inner.add(session.getId());
          skyrocket.put("inner", inner);
         
         soar.insertCompany(skyrocket);
      }else {
         List in = (List) company.get("inner");
         if(!in.contains(session.getId())) {
            in.add(session.getId());
            int count = (int) company.get("cnt");
             count += 1;
             soar.updateComapny(coname, count,in);
         }
         
      }
      
      List<Map> after = soar.getAllSoar();
      System.out.println(after);
      
      //==============================

      List<Map> jd = searchdao.ckbtn(sd);
      if(jd.size() == 0) {
         int c = searchdao.schbtn(sd);
         return "job.schdetail.index";
      }else {
         map.put("btn", "ya");   
         return "job.schdetail.index";
      }
      
      

   }

   // 요게 해당하는 기업이름 촤르륵
   @GetMapping(path = "/searchajax.do", produces = "application/json;charset=UTF-8")
   @ResponseBody
   public String searchAjaxHandle(WebRequest wr, @RequestParam String coname) {
      /* String coname = (String)wr.getAttribute("coname", wr.SCOPE_SESSION); */
      List<Map> sch = searchdao.schlist(coname);
         System.out.println("촤르륵 : " + sch);
         for (int i = 0; i < sch.size(); i++) {
            Map e = sch.get(i);
            String e1 = gson.toJson(e);
            System.out.println(e1);
            if (i < sch.size() - 1) {
               String a = ",";
               System.out.println(",");
         }
      }
      return gson.toJson(sch);
   }

   // 요게 관심 기업 버튼 클릭 요거 안됨
   @GetMapping("/schbtn.do")
   public String schbtn(WebRequest wr, ModelMap map) {
      String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
      String no = wr.getParameter("no");
      System.out.println("no:"+ no);
      
      if (id == null) {
         return "/login/login";
      } else {
         return "redirect:/search/schdetail.do?cono="+no;
         
      }
   }
   	// 요게 관심 기업 등록
	@PostMapping(path = "/comjjimAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String comjjimAjaxHandle(@RequestParam Integer cono, WebRequest wr) {
		Map comjjim = new HashMap<>();
		
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map cd = new HashMap<>();
		cd.put("id", id);
		cd.put("cono", cono);
		System.out.println(cd);
		
		try {
			int c = searchdao.schbtn(cd);
			comjjim.put("comjjim", true);
		}catch(Exception e) {
			e.printStackTrace();
			comjjim.put("comjjim", false);
		}
		return gson.toJson(comjjim);
	}
	
   // 요게 통합 검색 
   @PostMapping("/isearch.do")
   public String isearchHandle(WebRequest wr, ModelMap map) {
	   String coname = (String)wr.getParameter("isearch");
	   String title = (String)wr.getParameter("isearch");
	   String big = (String)wr.getParameter("isearch");
	   String small = (String)wr.getParameter("isearch");
	   
	   Map ish = new HashMap<>();
	   ish.put("coname", coname);
	   ish.put("title", title);
	   ish.put("big", big);
	   ish.put("small", small);
	   List<Map> isearck = searchdao.isearch(ish);
	   
	   if(coname.equals("") || title.equals("") || big.equals("") || small.equals("") || isearck.size() == 0) {
		   return "job.index";
	   } else {
		List<Map> isearch = searchdao.isearch(ish);
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		for (int i = 0; i < isearch.size(); i++) {
			Map m = isearch.get(i);
			Date date = (Date) m.get("STARTDATE");
			Date dd = (Date)m.get("ENDDATE");
			long endd =dd.getTime();
			m.put("STARTDATE", fmt.format(date));
			m.put("ENDDATE",fmt.format(dd) );
			long gap = endd-System.currentTimeMillis();
			if(gap<0) {
				m.put("MAGAM",true);
			}
   }
		map.put("isch", isearch);
		return "job.isearchlist";
   }
   }
}