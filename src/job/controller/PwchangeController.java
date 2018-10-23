package job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PwchangeController {

	@GetMapping("/pwchange.do")
	public String pwchangeHandle() {
		
		return "job.pwchange";
	}
	
}
