package job.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.dao.addhireDao;
import job.models.JobcateRepository;

@Controller
@RequestMapping("/hire")
public class AddhireController {
	@Autowired
	JobcateRepository jobcate;
	
	@Autowired
	addhireDao addhire;
	
	
	@GetMapping("/addhire.do")
	public String AddhireGetHandle(ModelMap map) {
		map.put("alljob", jobcate.getAll());
		map.put("allshape", addhire.getAll());
		return "/hire/addhire";
	}
	
	@PostMapping("/addhire.do") 
	public String AddhirePostHandle(WebRequest wr,@RequestParam Map param) {
		System.out.println("다 나와 : " + param);
		int a = addhire.addhire(param);
		
		
		return "";
	}
}
