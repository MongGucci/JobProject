package job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

@Controller
public class LoginController {
	@RequestMapping("/login.do")
	public String loginHandle(WebRequest wr) {
		
		return "login";
	}
}
