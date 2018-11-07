package job.models;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.client.result.UpdateResult;

@Repository
public class ChatlogRepository {

	@Autowired
	MongoTemplate template;
	
	public Map insertLine(Map map) {
		Map ret = template.insert(map,"chatlog");
		return ret;
	}
	
	public List<Map> getAllChatLog(){
		Criteria c = new Criteria().where("mode").is("all");
		return template.find(new Query(c),Map.class,"chatlog");
	}
	
	public List<Map> getChatLogbyCono(String cono){
		Criteria c = new Criteria().where("mode").is(cono);
		System.out.println("cono챗로구 : " +template.find(new Query(c),Map.class,"chatlog"));
		return template.find(new Query(c),Map.class,"chatlog");
	}
	
	
}
