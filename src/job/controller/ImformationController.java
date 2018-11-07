package job.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.models.EssayRepository;
import job.models.PickedhireRepository;
import job.models.ReviewRepository;
import job.models.ShareEssayRepository;



@Controller
public class ImformationController {
	
	@Autowired
	PickedhireRepository pr;
	
	@Autowired
	ReviewRepository rr;
	
	@Autowired
	EssayRepository er;
	
	@Autowired
	ShareEssayRepository ser;
	
	@GetMapping("/infor.do")
	public String inforHandle(WebRequest wr) {
		
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		
		Map map = new HashMap<>();
		map.put("id", id);
		
		List<Map> r = pr.getPick(id);
		wr.setAttribute("r", r, wr.SCOPE_REQUEST);
		
		List<Map> p = rr.getReview(id);
		wr.setAttribute("p", p, wr.SCOPE_REQUEST);

		List<Map> j = er.getMyJaso(id);
		wr.setAttribute("j", j, wr.SCOPE_REQUEST);
		
		List<Map> g = ser.getMyRe(id);
		wr.setAttribute("g", g, wr.SCOPE_REQUEST);
		
		return "job.infor";
		
		
		
	}
	
	@PostMapping("/infor.do")
	public String inforPostHandle() {
		return "redirect:/change/index.do";
	}
}
