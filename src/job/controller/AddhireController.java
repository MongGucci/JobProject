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
import javax.xml.bind.attachment.AttachmentMarshaller;

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

import job.dao.addhireDao;
import job.models.JobcateRepository;
import job.models.PickedhireRepository;

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

	@Autowired
	JavaMailSender sender;

	@Autowired
	PickedhireRepository phrepo;

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
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File dst = new File(dir, fileName);
		path.transferTo(dst);

		System.out.println(dst);
		String clientpath = "/storage/hire/" + fileName; // dao에 저장
		System.out.println("사진 경로 : " + clientpath);

		param.put("path", clientpath);
		System.out.println("다 나와 : " + param);
		int a = addhire.addhire(param);

		return "job.index";

	}


	
	@RequestMapping("/mail.do")
	@ResponseBody
	public String sendMail(@RequestParam Map param, WebRequest wr) {
		String receiver = (String) phrepo.ckemail();
		MimeMessage msg = sender.createMimeMessage();
		String txt = "찜한 기업의 공고가 올라 왔습니다";
		List<Map> confirm = phrepo.myjjim(param);
		System.out.println(receiver);
		
		txt += confirm;
		
		wr.setAttribute("confirm", confirm, WebRequest.SCOPE_SESSION);

		try {
			msg.setSubject("기업 공고");
			msg.setSubject("찜한 기업 공고 입니다.", "UTF-8");
			msg.setContent(txt, "text/plain;charset=UTF-8");
			msg.setFrom(new InternetAddress("jobgo@mockingu.com"));
			msg.setRecipient(RecipientType.TO, new InternetAddress(receiver));
			sender.send(msg);
			System.out.println("성공");
			return "true";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("실패");
			return "false";
		}

	}
 
	@RequestMapping("/mailauth.do")
	@ResponseBody
	
	public String emailauthHandle(@RequestParam Map param, WebRequest wr) {
		String confrim = (String)wr.getAttribute("txt", WebRequest.SCOPE_SESSION);
		String rst;
		
		return "true";
	}
	
	// 요거는 회사가 등록되어있는지 아닌지
	@GetMapping(path = "/coajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String conameAjaxHandle(@RequestParam String coname) {
		Map con = addhire.getconame(coname);
		System.out.println("나와 : " + con);
		Map c = new HashMap<>();
		if (con == null) {
			c.put("no", "on");
			System.out.println("등록되지 않은 기업");
		} else {
			c.put("no", "off");
		}
		return gson.toJson(c);
	}
}
