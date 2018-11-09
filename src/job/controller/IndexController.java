package job.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.dao.loginDao;
import job.models.ChatlogRepository;
import job.models.CompanyRepository;
import job.models.HireRepository;
import job.models.SoarRepository;

@Controller

public class IndexController {

	@Autowired
	SoarRepository soar;
	@Autowired
	loginDao logindao;
	@Autowired
	HireRepository hrepo;
	@Autowired
	ChatlogRepository crepo;
	@Autowired
	CompanyRepository comrepo;

	@Autowired
	Gson gson;

	@GetMapping("/index.do")
	public String getHandle(WebRequest wr, HttpServletRequest request) {

		Cookie[] getCookie = request.getCookies();
		if (getCookie != null) {
			for (int i = 0; i < getCookie.length; i++) {
				Cookie c = getCookie[i];
				if (c.getName().equals("logined")) {
					String cookieId = c.getValue();

					Map user = logindao.userck(cookieId);
					wr.setAttribute("userId", cookieId, wr.SCOPE_SESSION);
					wr.setAttribute("password", (String) user.get("PASSWORD"), wr.SCOPE_SESSION);
					wr.setAttribute("user", user, wr.SCOPE_SESSION);
					wr.setAttribute("auth", true, wr.SCOPE_SESSION);
					wr.setAttribute("nick", (String) user.get("NICK"), wr.SCOPE_SESSION);
					System.out.println("유저 정보 : " + user);

					// ----3일남은공고, 오늘제출해야하는 공고 띄울 고야 세션에 올리자! ----//

					List<Map> three = hrepo.getDeadline3(cookieId);
					System.out.println("3일 : " + three);
					List<Map> today = hrepo.getToday(cookieId);
					System.out.println("today: " + today);

					wr.setAttribute("three", three, wr.SCOPE_SESSION);
					wr.setAttribute("today", today, wr.SCOPE_SESSION);

					List<Map> chatrooms = comrepo.getChatRooms(cookieId);
					wr.setAttribute("chatrooms", chatrooms, WebRequest.SCOPE_SESSION);
					return "job.index";
				}
			}
		}

		if (wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
			System.out.println("안녕");
			return "job.index";

		} else {

			wr.getAttribute("id", wr.SCOPE_SESSION);
			String Id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
			System.out.println("사용자 ID : " + Id);
			return "job.index";
		}

	}

	public class Sorter implements Comparator<Map<String, Object>> {

		@Override
		public int compare(Map<String, Object> o1, Map<String, Object> o2) {
			int a = Integer.parseInt(o1.get("cnt").toString());
			int b = Integer.parseInt(o2.get("cnt").toString());

			return b - a;
		}

	}

	@GetMapping(path = "/indexAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String indexAjaxHandle() {
		

		List<Map> list = soar.getAllSoar();
		Sorter sr = new Sorter();
		list.sort((Comparator<? super Map>) sr);

		
		return gson.toJson(list);
	}

}
