package job.controller;

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

import job.dao.searchDao;
import job.models.HireRepository;
import job.models.ReviewRepository;

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
   Gson gson;

   @GetMapping("/search.do")
   public String searchGetHandle() {
      return "/search/search";
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
      
      if(id!=null) {
			Map mm = new HashMap();
			mm.put("id", id);
			mm.put("cono",cono);
			Map didI = rvrepo.didIWriteReview(mm);
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
      return "job.schdetail.index";
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

   // 요게 관심 기업 버튼 클릭
   @GetMapping("/schbtn.do")
   public String schbtn(WebRequest wr, ModelMap map) {
      String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
      String no = wr.getParameter("no");
      System.out.println("no:"+ no);
      Map sd = new HashMap<>();
      sd.put("id", id);

      sd.put("cono", no);

      System.out.println("확인 : " + sd);
      if (id == null) {
         return "/login/login";
      } else {
         List<Map> jd = searchdao.ckbtn(sd);
         System.out.println("찍어보자 : " + jd);
         if (jd.size() == 0) {
            int c = searchdao.schbtn(sd);
            map.put("ok", "on");
            return "redirect:/search/schdetail.do?cono="+no;
         } else {
            map.put("btn", "ya");
            return "redirect:/search/schdetail.do?cono="+no;
         }
      }
   }
}