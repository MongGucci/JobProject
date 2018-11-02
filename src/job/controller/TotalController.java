package job.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;


@Controller
public class TotalController extends TextWebSocketHandler {
	@Autowired
	Gson gson;
	
	@Autowired
	ServletContext sc;

	

	List<WebSocketSession> list;
	List<String> sce;

	public TotalController() {
		list = new ArrayList<>();
		sce = new ArrayList<>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		sce.add(session.getId());
		sc.setAttribute("sessionId", sce);
		
		
		list.add(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		list.remove(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
	}

}