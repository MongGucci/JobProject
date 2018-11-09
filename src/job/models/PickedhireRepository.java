package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PickedhireRepository {



	@Autowired
	SqlSessionTemplate template;

	public int pickHire(Map map) {
		return template.insert("pickedhire.pickhire", map);
	}


	public List<Map> myjjim(Map map) {
		return template.selectList("pickedhire.myjjim", map);

	}

	public List<Map> getPick(String id) {
		return template.selectList("pickedhire.getPick", id);
	}

	public String ckemail() {
		return template.selectOne("pickhire.ckemail");
	}
	 public List<Map> getIdsbyCono(int cono){
		   return template.selectList("pickedcompany.getIdsbyCono",cono);
	   }
	 
	 public List<Map> getCom(String id) {
		 return template.selectList("pickedcompany.getCom",id);
	 }


}