package job.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.dao.loginDao;
import job.models.ChatlogRepository;
import job.models.CompanyRepository;
import job.models.HireRepository;

@Controller
public class LoginController {
	Map<String, HttpSession> sessions;
	
	public LoginController() {
		sessions = new HashMap<>();
	}
	
	@Autowired
	loginDao logindao;
	@Autowired
	HireRepository hrepo;
	@Autowired
	ChatlogRepository crepo;
	@Autowired
	CompanyRepository comrepo;
	
	@Autowired
	ServletContext sc;
	@Autowired
	Gson gson;

	
	@GetMapping("/login.do")
	public String loginGetHandle() {

		return "/login/login";
	}
	
	@PostMapping("/login.do")
	public String loginPostHandle(WebRequest wr, ModelMap map) {
		String id = (String)wr.getParameter("id");
		String pass = (String)wr.getParameter("pass");
		
		Map data = new HashMap<>();
		data.put("id", id);
		data.put("password", pass);
		
		Map log = logindao.loginck(data);
	
		if(log != null) {
			wr.setAttribute("userId", id, wr.SCOPE_SESSION);
			wr.setAttribute("password", pass, wr.SCOPE_SESSION);
			
			
			Map user = logindao.userck(id);
			wr.setAttribute("user", user, wr.SCOPE_SESSION);
			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("nick", (String)user.get("NICK"), wr.SCOPE_SESSION);
			System.out.println("유저 정보 : " + user);
			
			
			//----3일남은공고, 오늘제출해야하는 공고 띄울 고야 세션에 올리자! ----//
			
			List<Map> three = hrepo.getDeadline3(id);
			System.out.println("3일 : "+three);
			List<Map> today = hrepo.getToday(id);
			System.out.println("today: "+today);
			
			
			wr.setAttribute("three", three,  wr.SCOPE_SESSION);
			wr.setAttribute("today", today,  wr.SCOPE_SESSION);

			//------전체채팅 자동입장되었고, 채팅로그 가져오시오 ! -----//
			String nick= logindao.getnick(id);
			crepo.updateSome(nick); 
			List<Map> chathistory = crepo.getChatLog();	
			wr.setAttribute("chathistory", chathistory, WebRequest.SCOPE_SESSION);
			String st = chathistory.toString();
			//gson.fromJson(st,List.class);
			//wr.setAttribute("chathistory", chathistory, WebRequest.SCOPE_SESSION);
			System.out.println("chat history : "+chathistory);
			
			List<Map> chatrooms = comrepo.getChatRooms(id);
			wr.setAttribute("chatrooms", chatrooms, WebRequest.SCOPE_SESSION);
			return "job.index";
		} else {
			map.put("err", "on");
			return "/login/login";
		}
	}
	
	@RequestMapping("/logout.do")
	public String logoutHandle(WebRequest wr, HttpSession session) {
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		sessions.remove(id);
		session.invalidate();
		System.out.println("로그아웃 완료");
		return "redirect:/index.do";
	}
}
