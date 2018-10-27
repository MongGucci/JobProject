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
import org.springframework.web.context.request.WebRequest;

import job.dao.searchDao;
import job.models.ReviewRepository;

@Controller
@RequestMapping("/search")
public class SearchController {
	@Autowired
	searchDao searchdao;
	@Autowired
	ReviewRepository rvrepo;

	@GetMapping("/search.do")
	public String searchGetHandle() {
		return "/search/search";
	}
	// 검색
	@PostMapping("/search.do")
	public String searchPostHandle(WebRequest wr) {
		String coname = (String) wr.getParameter("search");
		System.out.println(coname);

		if (coname.equals("")) {
			return "/search/search";
		} else {
			List<Map> sli = searchdao.schlist(coname);
			System.out.println(sli);
			wr.setAttribute("sli", sli, wr.SCOPE_SESSION);
			return "job.schlist.index";
		}
	}
	// 요게 상세보기
	@RequestMapping("/schdetail.do")
	public String detailHandle(WebRequest wr) {
		int cono = Integer.parseInt(wr.getParameter("cono"));
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map dt = searchdao.searchcom(cono);
		System.out.println("아이디 : " + id + " / " + cono);
		if(id!=null) {
			Map map = new HashMap();
			map.put("id", id);
			map.put("cono",cono);
			Map didI = rvrepo.didIWriteReview(map);
			System.out.println("썻냐안썻냐"+didI);
			if(didI!=null) {
				wr.setAttribute("youwrote", true, wr.SCOPE_SESSION);
			}
		}
		
		wr.setAttribute("dt", dt, wr.SCOPE_SESSION);
		wr.setAttribute("cono", cono, wr.SCOPE_SESSION);
		return "job.schdetail.index";
	}
	// 요게 관심 기업 버튼 클릭
	@RequestMapping("/schbtn.do")
	public String schbtn(WebRequest wr, ModelMap map) {
		wr.getAttribute("cono", wr.SCOPE_SESSION);
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		
		if(id == null) {	
			return "login";
		}else {
			Map sd = new HashMap<>();
			sd.put("id", id);
			sd.put("cono", wr.getAttribute("cono", wr.SCOPE_SESSION));
			
			int c = searchdao.schbtn(sd);
			map.put("ok", "on");
			return "job.schdetail.index";
		}
	}
}













