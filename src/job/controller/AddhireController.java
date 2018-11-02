package job.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.xml.bind.attachment.AttachmentMarshaller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import job.dao.addhireDao;
import job.models.JobcateRepository;

@Controller
@RequestMapping("/hire")
public class AddhireController {
	@Autowired
	Gson gson;
	 
	@Autowired
	JobcateRepository jobcate;
	
	@Autowired
	addhireDao addhire;
	
	@Autowired
	ServletContext ctx;
	
	@GetMapping("/addhire.do")
	public String AddhireGetHandle(ModelMap map) {
		map.put("alljob", jobcate.getAll());
		map.put("allshape", addhire.getAll());
		return "/hire/addhire";
	}
	
	@PostMapping("/addhire.do") 
	public String AddhirePostHandle(@RequestParam Map param, @RequestParam MultipartFile path) throws IOException {
		
		String fileName = path.getOriginalFilename();
		System.out.println("사진 제목 : " + fileName);
		String pat = ctx.getRealPath("/storage/hire");
		File dir = new File(pat);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File dst = new File(dir,fileName);
		path.transferTo(dst);
		
		String clientpath = "/storage/hire/" + fileName; // dao에 저장
		System.out.println("사진 경로 : " + clientpath);
		
		param.put("path", clientpath);
		System.out.println("다 나와 : " + param);
		int a = addhire.addhire(param);
		
		return "job.index";
		
	}
	
	// 요거는 회사가 등록되어있는지 아닌지
	@GetMapping(path = "/coajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String conameAjaxHandle(@RequestParam String coname) {
		Map con = addhire.getconame(coname);
		System.out.println("나와 : " + con);
		Map c = new HashMap<>();
		if(con == null) {
			c.put("no", "on");
			System.out.println("등록되지 않은 기업");
		} else {
			c.put("no", "off");
		}
		return gson.toJson(c);
	}
}
