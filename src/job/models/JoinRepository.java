package job.models;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinRepository {

	@Autowired
	SqlSessionTemplate template;
	
	
	
	public int add(Map map){
		return template.insert("applicant.add", map);
	}

	public String getById(Map map) {
		return template.selectOne("applicant.getById",map);
	}
	
	public int getByIdAndPass(Map data) {
		return template.selectOne("applicant.getByIdAndPass",data);
	}
	
	public String getByEmail(Map map) {
		return template.selectOne("applicant.getByEmail",map);
	}
}
