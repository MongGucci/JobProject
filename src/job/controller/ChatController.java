package job.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import job.models.ChatlogRepository;
import job.models.CoChatService;
import job.models.PickedhireRepository;



@Controller
public class ChatController extends TextWebSocketHandler{
	@Autowired
	Gson gson;
	
	@Autowired
	CoChatService service;
	
	@Autowired
	ChatlogRepository crep;
	
	@Autowired
	PickedhireRepository phrepo;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		service.addSocket(session);
		
		
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		service.removeSocket(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload();
		Map got = gson.fromJson(payload,Map.class);
		Map user = (Map)session.getAttributes().get("user");
		got.put("nick", (String) user.get("NICK"));
		
		
		//phrepo.getIdsbyCono(cono);
		//------------------------------------------------------------------------------------
		//MongoDB에넣기 
		// 1. id(보낸사람) / 2.text내용 / 3.senddate/ 4.읽은사람(list형으로)
		// 1.(String) session.getAttributes().get("userId");
		// 2. (String)map.get("text")
		//3. senddate
		Date senddate = new Date(System.currentTimeMillis());
		SimpleDateFormat sd = new SimpleDateFormat("YYYY-MM-dd hh:mm");
		sd.format(senddate);
		//4. sockets에 있는사람. chatids 리스트!!!재사용
		Map mongo = new HashMap();
		mongo.put("nick", (String) user.get("NICK"));
		mongo.put("text",  (String)got.get("text"));
		mongo.put("senddate",sd.format(senddate));
		mongo.put("mode", "all");
		Map ret = crep.insertLine(mongo);
		if(ret==null) {
			System.out.println("몽고에넣기실패 흙흙모래모래");
			}
				
	}
	
}