package job.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

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
import job.models.CompanyRepository;
import job.models.JobcateRepository;
import job.models.LocationRepository;
import job.models.RecruitRepository;

@Controller
@RequestMapping("/admin")
public class AdminController extends HttpServlet{
	@Autowired
	Gson gson;
	
	@Autowired
	RecruitRepository rrepo;
	
	@Autowired
	CompanyRepository cr;
	
	@Autowired
	JobcateRepository jobcate;
	
	@Autowired
	addhireDao addhire;
	
	@Autowired
	ServletContext ctx;
	
	
	
	@PostMapping(path="/writeajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String selectAjaxHandle(@RequestParam String big) {
		List<Map> small = rrepo.getAllSmallLocation(big);
		return gson.toJson(small);
		
		
	}
	
	@GetMapping("/addcompany.do")
	public String writeGetHandle(Map map) {

		List<Map> big = rrepo.getAllBigLocation();
		map.put("big", big);
		return "/admin/addcompany";
	}
	
	
	
	@PostMapping("/addcompany.do")
	public String wirtePostHandle(WebRequest wr, ModelMap map,
			@RequestParam MultipartFile attach) throws IOException {
		System.out.println("attach = " + attach +" / " + attach.isEmpty());
		String coname = (String)wr.getParameter("coname");
		String industry = (String)wr.getParameter("industry");
		String sales = (String)wr.getParameter("sales");
		String ceo = (String)wr.getParameter("ceo");
		String salary = (String)wr.getParameter("salary");
		String workers = (String)wr.getParameter("workers");
		String lat = (String)wr.getParameter("lat");
		String lng = (String)wr.getParameter("lng");
		String first = (String)wr.getParameter("first");
		String homepage = (String)wr.getParameter("homepage");
		String cotype = (String)wr.getParameter("cotype");
		String big = (String)wr.getParameter("big");
		String small = (String)wr.getParameter("small");
		
		String fileName = attach.getOriginalFilename();
		String name = attach.getName();
		String path = ctx.getRealPath("/storage/logo");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File dst = new File(dir, fileName);
		attach.transferTo(dst);
		System.out.println("사진 : " + dst);
		String clientpath = "/storage/logo/" + fileName; // dao에 저장
		System.out.println(coname +" / "+ industry +" / "+ sales +" / "+ ceo +" / "+ salary +" / "+ lat +" / "
		+ lng +" / "+ first +" / "+ homepage);
		
		Map data = new HashMap<>();
		data.put("coname", coname);
		data.put("industry", industry);
		data.put("sales", sales);
		data.put("ceo", ceo); 
		data.put("salary", salary);
		data.put("workers", workers);
		data.put("lat", lat);
		data.put("lng", lng);
		data.put("first", first);
		data.put("homepage", homepage);
		data.put("cotype", cotype);
		data.put("big", big);
		data.put("small", small);
		data.put("logo", clientpath);
		
		int r = cr.addAll(data);
		
		return "/admin/addcompany";
	}
	
	

	@GetMapping("/addhire.do")
	public String AddhireGetHandle(ModelMap map) {
		map.put("alljob", jobcate.getAll());
		map.put("allshape", addhire.getAll());
		return "/admin/addhire";
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
