package job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JoinController {

	@GetMapping("/join.do")
	public String joinHandle() {
		return "join";
	}
}