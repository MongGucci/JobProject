package job.models;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

@Service
public class AlertService extends TextWebSocketHandler{
	@Autowired
	Gson gson;
	
	List<WebSocketSession> list;
	
	public AlertService() {
		list = new ArrayList<>();
	}
	
	public List<WebSocketSession> allList() {
		return list;
		
	}
	
	public boolean addSocket(WebSocketSession target) {
		return list.add(target);
		
	}
	
	public int sessionSize() {
		return list.size();
	}
	
	public boolean removeSocket(WebSocketSession target) {
		return list.remove(target);
	}
	
	public void sendAll(String txt) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0;i<list.size();i++) {
			try {
				list.get(i).sendMessage(msg);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public void sendAll(Map map) {
		sendAll(gson.toJson(map));
		
	}
	public void sendOne(String txt,String target) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0;i<list.size();i++) {
			try {
				WebSocketSession ws = list.get(i);
				String id = (String)ws.getAttributes().get("userId");
				if(id.equals(target)) {
					ws.sendMessage(msg);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public void sendOne(Map data,String target) {
		sendOne(gson.toJson(data), target);
		
	}
	
	public void sendSome(String txt,String...target) {
		TextMessage msg = new TextMessage(txt);
		for(int i=0;i<list.size();i++) {
			try {
				WebSocketSession ws = list.get(i);
				String id = (String)ws.getAttributes().get("userId");
				if(id.equals(target)) {
					ws.sendMessage(msg);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	

	
	
	
	
}
