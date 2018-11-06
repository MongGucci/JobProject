package job.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.dao.loginDao;
import job.models.ChatlogRepository;
import job.models.CompanyRepository;

@Controller
@RequestMapping("/chat")
public class EnterChatController {
	@Autowired
	loginDao logindao;
	@Autowired
	ChatlogRepository crepo;
	@Autowired
	CompanyRepository comrepo;
	
	@GetMapping("/allchat.do")
	public String allchatHandle(Map map,WebRequest wr) {
		
		if(wr.getAttribute("auth", wr.SCOPE_SESSION)!=null) {
			Map user = (Map)wr.getAttribute("user", wr.SCOPE_SESSION);
			String nick= (String) user.get("NICK");
			List<Map> chathistory = crepo.getAllChatLog();	
			System.out.println("엔터챗컨트롤러 chathistory: "+chathistory);
			map.put("chatlog",chathistory);
			return "job.allchat";
		}else {
			return "/login/login";
		}
	}
	
	

	@GetMapping("/cochat.do")
	public String cochatHandle(@RequestParam Map param, Map map,WebRequest wr) {
		if(wr.getAttribute("auth", wr.SCOPE_SESSION)!=null) {
			String cono = (String)param.get("cono");
			String coname = comrepo.getConameByCono(Integer.parseInt(cono));
			System.out.println("cono :" +cono);
			List<Map> chathistory = crepo.getChatLogbyCono(cono);
			map.put("chatlog",chathistory);
			map.put("coname", coname);
			map.put("cono",cono );
			System.out.println("cono엔터챗컨트롤러 chathistory: "+chathistory);
		
		return "job.cochat";
		}else {
			return "/login/login";
		}
	}
}

