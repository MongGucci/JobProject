package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LocationRepository {

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getBig(){
		return template.selectList("location.getBig");
	}
	public List<Map> getSmall(){
		return template.selectList("location.getSmall");
	}
	
}
