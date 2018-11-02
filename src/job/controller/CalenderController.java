package job.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/calender")
public class CalenderController {

	@RequestMapping("/calender.do")
	public String calenderHandle() {
		return "/calender/calender";
	}
}
