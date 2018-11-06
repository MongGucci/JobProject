package job.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import job.models.ChatlogRepository;
import job.models.ComChatService;
import job.models.PickedhireRepository;



@Controller
public class ChatController extends TextWebSocketHandler{
	@Autowired
	Gson gson;
	@Autowired
	PickedhireRepository phrepo;

	@Autowired
	WebRequest wr;
	
	@Autowired
	ComChatService service;
	@Autowired
	ChatlogRepository crepo;


	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		service.addSocket(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		try{
			service.removeSocket(session);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//전체채팅 
		try {
			
		
		String payload = message.getPayload();
		//System.out.println("payload : "+payload);
		Map got = gson.fromJson(payload, Map.class);
		
		Map user = (Map) session.getAttributes().get("user");
		//got.put("nick", (String)user.get("NICK"));
		got.put("talker",(String)session.getAttributes().get("nick"));
		
		System.out.println("nick네임 : "+(String)session.getAttributes().get("nick"));
		//TextMessage tmt = new TextMessage(gson.toJson(got));
		
		
		//service.sendAll(got);
		
		
		List<Map> ids = phrepo.getIdsbyCono(1116);
		
		
		System.out.println("comlist : "+service.comlist);
		
		for(int i=0;i<service.comlist.size();i++) {
			String id=(String)service.comlist.get(i).getAttributes().get("userId");
			System.out.println("userid뽑은거 : "+id);
			if(ids.get(i).containsValue(id)) {
				System.out.println("ㅇㅇㅇ :" +ids.get(i).containsValue(id));
				System.out.println("got : "+got);
				System.out.println("누구한테보내녀 : "+service.comlist.get(i));
				service.comlist.get(i).sendMessage(new TextMessage(gson.toJson(got)));
			}
		}
		System.out.println("뽑힌아이디들 / "+ids);
		/*String[] id = new String[ids.size()];
		for(int i=0;i<ids.size();i++) {
			id[i]=ids.get(i);
		}*/
		//got.put("ids", ids);
		/*service.sendIncludeGroup(gson.toJson(got),id);*/
		
		
		String nick= (String)user.get("NICK");
		crepo.updateSome(nick);
		//몽고에 넣기
		Date senddate = new Date(System.currentTimeMillis());
		SimpleDateFormat sd = new SimpleDateFormat("YYYY-MM-dd hh:mm");
		Map mongo = new HashMap();
		mongo.put("nick",(String)user.get("NICK"));
		mongo.put("text",(String)got.get("text"));
		mongo.put("senddate",sd.format(senddate));	
		Map ret = crepo.insertLine(mongo);
		if(ret==null) {
			System.out.println("몽고에넣기실패 흙흙모래모래");
		}
		/*List<Map> chathistory = crepo.getChatLog();	
		wr.setAttribute("chathistory", chathistory, WebRequest.SCOPE_SESSION);*/
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}