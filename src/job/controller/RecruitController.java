package job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recruit")
public class RecruitController {

	@GetMapping("/select.do")
	public String selectGetHandle() {
		
		
		return "job.select";
	}
	
	@GetMapping("/selectdetail.do")
	public String selectdetailGetHandle() {
		
		
		return "job.selectdetail";
	}
	
	@GetMapping("/jobpost.do")
	public String jobpostGetHandle() {
		
		
		return "job.jobpost";
	}
	
	@GetMapping("/comdetail.do")
	public String comdetailGetHandle() {

		return "job.comdetail";
	}
	
}
