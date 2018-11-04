package job.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.SoarRepository;

@Controller

public class IndexController {

	@Autowired
	SoarRepository soar;
	
	@Autowired
	Gson gson;
	
	@GetMapping("/index.do")
	public String getHandle(WebRequest wr) {

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
	public class Sorter  implements Comparator<Map<String,Object>>{

		@Override
		public int compare(Map<String, Object> o1, Map<String, Object> o2) {
			int a = Integer.parseInt(o1.get("cnt").toString());
			int b = Integer.parseInt(o2.get("cnt").toString());
			
			return b-a;
		}
		
	}
	
	

	@GetMapping(path = "/indexAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String indexAjaxHandle() {
		System.out.println("새로고침");

	
		List<Map> list = soar.getAllSoar();
		Sorter sr = new Sorter();
		list.sort((Comparator<? super Map>) sr);
		
		System.out.println(list);
		return gson.toJson(list);
	}
	
	
}
