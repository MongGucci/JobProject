package job.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	public String loginPostHandle(WebRequest wr, ModelMap map, HttpServletResponse response,
			HttpServletRequest request) {
		String id = (String) wr.getParameter("id");
		String pass = (String) wr.getParameter("pass");
		String day = (String) wr.getParameter("remember");
		System.out.println("day? " + day);
		Map data = new HashMap<>();
		data.put("id", id);
		data.put("password", pass);

		Map log = logindao.loginck(data);

		if (log != null) {
			wr.setAttribute("userId", id, wr.SCOPE_SESSION);
			wr.setAttribute("password", pass, wr.SCOPE_SESSION);

			Map user = logindao.userck(id);
			wr.setAttribute("user", user, wr.SCOPE_SESSION);
			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("nick", (String) user.get("NICK"), wr.SCOPE_SESSION);
			System.out.println("유저 정보 : " + user);

			// ----3일남은공고, 오늘제출해야하는 공고 띄울 고야 세션에 올리자! ----//

			List<Map> three = hrepo.getDeadline3(id);
			System.out.println("3일 : " + three);
			List<Map> today = hrepo.getToday(id);
			System.out.println("today: " + today);

			wr.setAttribute("three", three, wr.SCOPE_SESSION);
			wr.setAttribute("today", today, wr.SCOPE_SESSION);

			List<Map> chatrooms = comrepo.getChatRooms(id);
			wr.setAttribute("chatrooms", chatrooms, WebRequest.SCOPE_SESSION);

			// ------------------------------------------------------------------
			// 쿠키 생성하기
			Cookie setCookie = new Cookie("logined", id); // 쿠키 생성
			if (day != null) {
				setCookie.setMaxAge(60 * 60 * 24 * 7); // 기간을 일주일로 지정
			} else {
				setCookie.setMaxAge(60 * 60 * 12); // 기간을 6시간으로 지정???이상해 기간이 60*60*12로하면 일주일잡히는데?
			}

			response.addCookie(setCookie);
			
			if (wr.getAttribute("target",wr.SCOPE_SESSION) != null) {
				return "redirect:"+(String) wr.getAttribute("target",wr.SCOPE_SESSION);
			} else {
				return "redirect:/infor.do";
			}

			
		} else {
			map.put("err", "on");
			return "/login/login";
		}
	}

	@RequestMapping("/logout.do")
	public String logoutHandle(WebRequest wr, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		// 쿠키얻어서 login쿠키만 날리기
		Cookie[] getCookie = request.getCookies();
		if (getCookie != null) {
			for (int i = 0; i < getCookie.length; i++) {
				Cookie c = getCookie[i];
				if (c.getName().equals("logined")) {
					c.setMaxAge(0);// 유효시간을 0으로 설정
					response.addCookie(c); // 응답 헤더에 추가해서 없어지도록 함
				}

			}
		}

		sessions.remove(id);
		session.invalidate();

		System.out.println("로그아웃 완료");

		return "redirect:/index.do";
	}
}
