package job.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.dao.searchDao;

@Controller
public class SearchController {
	@Autowired
	searchDao searchdao;

	@GetMapping("/search.do")
	public String searchGetHandle() {
		return "/search/search";
	}

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
	
	@RequestMapping("/schdetail.do")
	public String detailHandle(WebRequest wr) {
		int cono = Integer.parseInt(wr.getParameter("cono"));
		Map dt = searchdao.searchcom(cono);
		wr.setAttribute("dt", dt, wr.SCOPE_SESSION);
		return "job.schdetail.index";
	}
}
