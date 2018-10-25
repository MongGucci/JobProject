package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//기업정보알려주는 리포지터리
@Repository
public class CompanyRepository {

	

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getAll() {
		return template.selectList("company.getAll");
	}
	
}
