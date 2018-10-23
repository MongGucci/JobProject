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
}
