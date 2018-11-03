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
	
	public List<Map> getChatLog(){
		return template.findAll(Map.class,"chatlog");
		
	}
	
	public void updateSome(String id) {
		Criteria c = new Criteria().where("readers").ne(id); 

		Update u= new Update().push("readers",id);
		UpdateResult rst= template.updateMulti(new Query(c),u,"chatlog");
	}
}
