package job.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import job.models.AlertService;



@Controller
public class ChatController extends TextWebSocketHandler{
	@Autowired
	Gson gson;
	
	@Autowired
	AlertService alert;
	
	
	
	
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
		String payload = message.getPayload();
	}
	
}