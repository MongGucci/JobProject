package job.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class mail {

	@Autowired
	JavaMailSender sender;
	
	@RequestMapping("/mail.do")
	public void sendTest() {
		SimpleMailMessage msg = new SimpleMailMessage();
		sender.createMimeMessage();
		msg.setSubject("메일테스"); // 메일제목
		String txt = "인증키 ☞ ";	//인증키 
		txt += UUID.randomUUID().toString().split("-")[0];	// 인증키
		msg.setText(txt);// 내용 보내는거
		msg.setTo("hkdlye@naver.com");//받는 사람 이메일  
		msg.setFrom("AA@aaa.com");
		
		
		try {
			sender.send(msg);
			System.out.println("성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("tlfvo");
		}
	}
}
