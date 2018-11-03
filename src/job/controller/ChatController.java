package job.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import job.dao.loginDao;
import job.models.AlertService;
import job.models.ChatlogRepository;



@Controller
public class ChatController extends TextWebSocketHandler{
	@Autowired
	Gson gson;
	

	
	@Autowired
	AlertService alert;
	@Autowired
	ChatlogRepository crepo;
	
	List<WebSocketSession> sockets;

	public ChatController() {
		sockets = new ArrayList<>();
	}
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		alert.addSocket(session);

	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		alert.removeSocket(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//전체채팅 
		String payload = message.getPayload();
		System.out.println("payload : "+payload);
		Map got = gson.fromJson(payload, Map.class);
		
		Map user = (Map) session.getAttributes().get("user");
		got.put("nick", (String)user.get("NICK"));
		
		//TextMessage tmt = new TextMessage(gson.toJson(got));
		
		alert.sendAll(got);
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
	
	}
	
}