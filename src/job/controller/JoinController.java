package job.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.ha.backend.Sender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException.Gone;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.models.JobcateRepository;
import job.models.JoinRepository;

@Controller
@RequestMapping("/join")
public class JoinController extends HttpServlet {

   @Autowired
   Gson gson;

   @Autowired
   JoinRepository jr;

   @Autowired
   JobcateRepository jcr;

   @Autowired
   JavaMailSender sender;

   @GetMapping("/join.do")
   public String joinGetHandle(ModelMap map) {
      List<Map> cate = jcr.getAll();
      map.put("map", cate);
      System.out.println(cate);
      return "job.join";
   }

   @PostMapping("/join.do")
   public String joinPostHandle(WebRequest wr, ModelMap map) {

      String id = (String) wr.getParameter("id");
      String pass = (String) wr.getParameter("pass");
      String name = (String) wr.getParameter("name");
      String age = (String) wr.getParameter("age");
      String gender = (String) wr.getParameter("gender");
      String job = (String) wr.getParameter("job");
      String nick = (String) wr.getParameter("nick");
      String email = (String) wr.getParameter("email");
      String phone = (String) wr.getParameter("phone");

      System.out.println(id + pass + name + gender + job + nick + email + phone);

      Map data = new HashMap<>();
      data.put("id", id);
      data.put("password", pass);
      data.put("name", name);
      data.put("age", age);
      data.put("gender", gender);
      data.put("nick", nick);
      data.put("email", email);
      data.put("phone", phone);

      int a = jr.add(data);

      return "job.index";

   }

   
   // 아이디 중복 체크
   @GetMapping(path = "/joinajax.do", produces = "application/json;charset=UTF-8")
   @ResponseBody
   public String joinAjaxHandle(@RequestParam String id) {
      System.out.println("id :" + id);
      Map cid = jr.getById(id);
      System.out.println("cid :" + cid);
      System.out.println(cid);
      Map map = new HashMap<>();
      if (cid != null) {
         map.put("pass", "on");
         System.out.println(id + "사용중인 아이디");
      } else {
         map.put("pass", "off");
         System.out.println(id + "사용가능한 아이디");
      }
      return gson.toJson(map);

   }

   // 이메일 인증
   
   @RequestMapping("/mail.do")
   @ResponseBody

   public String sendMail(@RequestParam Map param, WebRequest wr) {
      String receiver = (String) param.get("email");
      SimpleMailMessage msg = new SimpleMailMessage();
      msg.setSubject("인증번호");
      String txt = "인증키 ☞";
      String confirm = UUID.randomUUID().toString().split("-")[0];
      System.out.println(receiver);
      txt += confirm;

      wr.setAttribute("confirm", confirm, WebRequest.SCOPE_SESSION);
      msg.setText(txt);
      msg.setTo(receiver);
      msg.setFrom("Sample@example.com");

      try {
         sender.send(msg);
         System.out.println("성공");
         return "true";
      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("실패");
         return"false";
      }
   }

   @RequestMapping("/emailauth.do")
   @ResponseBody

   public String emailauthHandle(@RequestParam Map param, WebRequest wr) {
      String confirm = (String) wr.getAttribute("confirm", WebRequest.SCOPE_SESSION);
      String confrim1 = (String) param.get("confirmkey");
      String rst;
      wr.removeAttribute("confirmKey", WebRequest.SCOPE_REQUEST);
      if (confirm.equals(confrim1)) {
         rst = "true";
         wr.setAttribute("rst", rst, WebRequest.SCOPE_SESSION);
         System.out.println(rst);
         return rst;
      } else {
         rst = null;
         wr.setAttribute("rst", rst, WebRequest.SCOPE_SESSION);
         System.out.println(rst);
         return rst;
      }

   }
   
   

   @RequestMapping("/emailcheck.do")
   @ResponseBody
   public String emailcheckHandle(HttpServletRequest req, @RequestParam String mail) throws IOException {

      String w = req.getParameter("w");
      Map map = (Map) jr.getByEmail(w);
      gson.toJson(map);
      return gson.toJson(mail);
   }
}