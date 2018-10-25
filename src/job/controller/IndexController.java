package job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

@Controller
@RequestMapping("/job")
public class IndexController {

	@GetMapping("/index.do")
	public String GetHandle(WebRequest wr) {
		
		if(wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
			return "job.index";
		} else {
			wr.getAttribute("id", wr.SCOPE_SESSION);
			String Id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
			System.out.println("사용자 ID : " + Id);
			return "job.login.index";
		}
		
	}
}
