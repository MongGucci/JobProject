package job.models;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.WebRequest;

@Service
public class EssayService {
	@Autowired
	EssayRepository essay;
	
	@Autowired
	HttpSession session;
	
	public List<Map> hireAjax(){
		List<Map> list =essay.getAllJasoForm();
		
		
		
		for(int i=0;i<list.size();i++) {
			Map map = list.get(i);
			map.put("mode", "hire");
			
			java.sql.Timestamp timeStamp = (Timestamp) map.get("ENDDATE");
	        java.sql.Date date = new java.sql.Date(timeStamp.getTime()); 
	        long end = date.getTime();
	        long current = System.currentTimeMillis();
	        long day = (end-current)/(1000*60*60*24);
	        if(day == 0) {
	        	map.put("DDAY", "D-DAY");
	        }else {
	        	map.put("DDAY", "D"+day);
	        }
	        System.out.println((end-current)/(1000*60*60*24));
			
		}
		
		return list;
	}
	
	public List<Map> myEssayAjax(){
		String id = (String) session.getAttribute("userId");
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd.HH:mm");
		List<Map> list =essay.getMyJaso(id);
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			Date date = (Date) map.get("LASTDATE");
			map.put("LASTDATE", fmt.format(date));

		}
		
		
		
		for(int i=0;i<list.size();i++) {
			Map map = list.get(i);
			map.put("mode", "myEssay");
	
			
		}
		
		return list;
	}
	
	public List<Map> passAjax(){
		
		List<Map> list =essay.getPassJaso();
		
		
		
		for(int i=0;i<list.size();i++) {
			Map map = list.get(i);
			map.put("mode", "pass");
	
			
		}
		
		return list;
	}

}
