package job.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class addhireDao {

	@Autowired
	SqlSessionTemplate template;
	
	// 채용정보 등록
	public int addhire(Map map) {
		return template.insert("hire.addhire",map);
	}
	
	public List<Map> getAll(){
		return template.selectList("hireshape.getAll");
	}
	
	// 등록된 기업이 있나 없나 
	public Map getconame(String coname) {
		return template.selectOne("company.getconame",coname);
	}
}
