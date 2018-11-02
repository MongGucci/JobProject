package job.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.AlertService;
import job.models.HireRepository;
import job.models.PickedhireRepository;
import job.models.RecruitRepository;
import job.models.ReviewRepository;

@Controller
@RequestMapping("/enterchat")
public class EnterChatController {

	@Autowired
	Gson gson;
	@Autowired
	RecruitRepository rrepo;
	@Autowired
	HireRepository hrepo;
	@Autowired
	PickedhireRepository phrepo;
	@Autowired
	ReviewRepository rvrepo;
	@Autowired
	AlertService alert;
	
	

	@PostMapping(path="/enterallchatajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String selectAjaxHandle(@RequestParam String big) {
		List<Map> small = rrepo.getAllSmallLocation(big);
		return gson.toJson(small);
	}
	
	@PostMapping(path = "/recruitjjimAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String recruitjjimAjaxHandle(@RequestParam Integer hino, WebRequest wr) {
		Map jjim = new HashMap<>();
		
		String id = (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map map = new HashMap<>();
		map.put("id", id);
		map.put("hino", hino);
		System.out.println(map);
		
		int r = phrepo.pickHire(map);
		
		return gson.toJson(jjim);
	}
	
	@PostMapping(path="/pickhireajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String pickhireAjaxHandle(@RequestParam Map map) {
		int r = phrepo.pickHire(map);
		if(r==1) {
			return gson.toJson(true);
		}else {
			return gson.toJson(false);
		}
	}
	
	
	
}
