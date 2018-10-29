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

@Controller
@RequestMapping("/search")
public class SearchController {
	@Autowired
	searchDao searchdao;
	
/*	@Autowired
	HireRepository hrepo;*/
	
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
		int cono = Integer.parseInt(wr.getParameter("cono"));
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map dt = searchdao.searchcom(cono);

		wr.setAttribute("dt", dt, wr.SCOPE_SESSION);
		wr.setAttribute("cono", cono, wr.SCOPE_SESSION);

	/*	List<Map> hiring = hrepo.getHirebyCono(cono);
		map.put("hiring", hiring);*/

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
	   @RequestMapping("/schbtn.do")
	   public String schbtn(WebRequest wr, ModelMap map) {
	      String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
	      
	      Map sd = new HashMap<>();
	      sd.put("id", id);
	      sd.put("cono", wr.getAttribute("cono", wr.SCOPE_SESSION));
	      
	      System.out.println("확인 : " + sd);
	      if(id == null) {   
	         return "/login/login";
	      }else {
	         List<Map> jd = searchdao.ckbtn(sd);
	         System.out.println("찍어보자 : " + jd);
	         if(jd.size() == 0) {
	            int c = searchdao.schbtn(sd);
	            map.put("ok", "on");
	            return "job.schdetail.index";
	         }else {
	            map.put("btn", "ya");
	            return "job.schdetail.index";
	      }
	   }
	   }
}
