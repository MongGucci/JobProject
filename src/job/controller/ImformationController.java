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
import job.models.JoinRepository;
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
	
	@Autowired
	JoinRepository jo;
	
	@GetMapping("/infor.do")
	public String inforHandle(WebRequest wr) {

		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);

		Map map = new HashMap<>();
		map.put("id", id);
		
		// 내가 찜한 채용 공고
		List<Map> r = pr.getPick(id);
		wr.setAttribute("r", r, wr.SCOPE_REQUEST);
		
		// 내가 쓴 후기
		List<Map> p = rr.getReview(id);
		wr.setAttribute("p", p, wr.SCOPE_REQUEST);
		
		// 내가 쓴 자소서
		List<Map> j = er.getMyJaso(id);
		wr.setAttribute("j", j, wr.SCOPE_REQUEST);
		
		// 내가 쓴 댓글
		List<Map> g = ser.getMyRe(id);
		wr.setAttribute("g", g, wr.SCOPE_REQUEST);

		// 유저 정보
		Map u = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
	    wr.setAttribute("u", u, wr.SCOPE_REQUEST);
		
	    // 내가 찜한 기업
	    List<Map> c = pr.getCom(id);
	    wr.setAttribute("c", c, wr.SCOPE_REQUEST);
	    
		return "job.infor";

	}

	@PostMapping("/infor.do")
	public String inforPostHandle() {
		return "redirect:/change/index.do";
	}
}
