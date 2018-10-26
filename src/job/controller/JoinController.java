package job.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException.Gone;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.JobcateRepository;
import job.models.JoinRepository;

@Controller
@RequestMapping("/join")
public class JoinController extends HttpServlet {
	
	@Autowired
	Gson gson;
	
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
	/*@PostMapping(path="/selectajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String selectAjaxHandle(@RequestParam String big) {
		System.out.println("big: "+big);
		List<Map> small = rrepo.getAllSmallLocation(big);
		System.out.println("samll = " + small);
		
		return gson.toJson(small);
	}
	*/
	
	@GetMapping( path="/joinajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String joinAjaxHandle(@RequestParam String id) {
		boolean isExit = false;
		if(id.equals(id)) {
			isExit = true;
		}
		Map map = new HashMap<>();
		map.put("isExit", id);
		return gson.toJson(id);
		
		
		
		
		/*	System.out.println("id :" + id);
		Map cid = jr.getById(id);
		System.out.println("cid :" + cid);
		System.out.println(cid);
		if( id != null ) {
		Map map =new HashMap<>();
		
		System.out.println(id + "사용중인 아이디");
	}else {
		
		System.out.println(id + "사용가능한 아이디");
	}
		return gson.toJson(cid); 
		*/
	}
}