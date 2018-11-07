package job.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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

import job.models.CompanyRepository;
import job.models.LocationRepository;
import job.models.PickedhireRepository;
import job.models.RecruitRepository;

@Controller
@RequestMapping("/admin")
public class CompanyController extends HttpServlet{
	@Autowired
	Gson gson;
	@Autowired
	ServletContext sc;
	
	@Autowired
	RecruitRepository rrepo;
	
	@Autowired
	CompanyRepository cr;
	
	@Autowired
	ServletContext ctx;
	
	
	@PostMapping(path="/writeajax.do", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String selectAjaxHandle(@RequestParam String big) {
		List<Map> small = rrepo.getAllSmallLocation(big);
		return gson.toJson(small);
		
		
	}
	
	@GetMapping("/write.do")
	public String writeGetHandle(Map map) {

		List<Map> big = rrepo.getAllBigLocation();
		map.put("big", big);
		return "/admin/write";
	}
	
	
	
	@PostMapping("/write.do")
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
		
		return "/admin/write";
	}
	
}
