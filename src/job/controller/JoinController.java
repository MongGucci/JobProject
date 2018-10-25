package job.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.context.request.WebRequest;

import job.models.JobcateRepository;
import job.models.JoinRepository;

@Controller
@RequestMapping("/join")
public class JoinController {
	
	
	@Autowired
	JoinRepository jr;
	
	@Autowired
	JobcateRepository jcr;
	
	@GetMapping("/join.do")
	public String joinGetHandle(ModelMap map) {
		List<Map> cate = jcr.getAll();
		map.put("map", cate);
		System.out.println(cate);
		return "job.join";
	}
	
	@PostMapping("/join.do")
	public String joinPostHandle(WebRequest wr, ModelMap map) {
		
		String id = (String)wr.getParameter("id");
		String pass = (String)wr.getParameter("pass");
		String name = (String)wr.getParameter("name");
		String age = (String)wr.getParameter("age");
		String gender = (String)wr.getParameter("gender");
		String job = (String)wr.getParameter("job");
		String nick = (String)wr.getParameter("nick");
		String mail = (String)wr.getParameter("mail");
		String phone = (String)wr.getParameter("phone");
		
		
		System.out.println(id + pass + name + gender + job + nick + mail + phone);
		
		Map data = new HashMap<>();
		data.put("id", id);
		data.put("password", pass);
		data.put("name", name);
		data.put("age", age);
		data.put("gender", gender);
		data.put("catename", job);
		data.put("nick", nick);
		data.put("email", mail);
		data.put("phone", phone);
		int a = jr.add(data);
				

				
		return "job.index";
	}
	
}