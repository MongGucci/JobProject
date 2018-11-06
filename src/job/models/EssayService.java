package job.models;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EssayService {
	@Autowired
	EssayRepository essay;
	
	public List<Map> hireAjax(){
		List<Map> list;
		int total = essay.totalHire();
		System.out.println("total:"+total);
		int listcnt = total/10;
		if(total%10 !=0) {
			listcnt++;
		}
	
			Map pageMap = new HashMap<>();
			pageMap.put("start", 1);
			pageMap.put("end", 10);
			System.out.println(pageMap);
			list = essay.getHire(pageMap);
		
		System.out.println(list);
		Map cnt =new HashMap<>();
		cnt.put("listcnt", listcnt);
		
		
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
	        	map.put("DDAY", "D-"+day);
	        }
	        System.out.println((end-current)/(1000*60*60*24));
			
		}
		list.add(cnt);
		return list;
	}

}
