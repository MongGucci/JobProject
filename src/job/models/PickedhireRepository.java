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
		return template.insert("pickedhire.pickhire",map);
	}
	
	
	
}
