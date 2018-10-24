package job.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JobcateRepository {

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getCate(){
		return template.selectList("jobcate.getCate");
	}
	
}
