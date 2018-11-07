package job.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

import job.dao.loginDao;

@Controller
public class PwchangeController {
	@Autowired
	loginDao logindao;

	@GetMapping("/pwchange.do")
	public String pwchangeHandle(WebRequest wr, ModelMap map) {
		/* String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION); */
		String cpass = (String) wr.getAttribute("password", wr.SCOPE_SESSION);
		/* map.put("id", id); */
		System.out.println("기존 비밀번호 : " + cpass);
		return "job.pwchange";
	}

	@PostMapping("/pwchange.do")
	public String pwchangePostHandle(WebRequest wr, ModelMap map) {

		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION); // 로그인한 아이디
		String cpass = (String) wr.getAttribute("password", wr.SCOPE_SESSION); // 로그인한 비밀번호
		String opass = (String) wr.getParameter("pass"); // 기존 비밀번호
		String newpass = (String) wr.getParameter("newpass"); // 새로운 비밀번호

		System.out.println("새로운 비밀번호 : " + newpass);

		Map data = new HashMap<>();
		data.put("id", id);
		data.put("password", newpass);

		if (cpass.equals(opass)) {
			int a = logindao.pwchange(data);
			System.out.println(data);
			return "redirect:/index.do";
		} else {
			map.put("err", "on");
			return "job.pwchange";
		}

	}
}
