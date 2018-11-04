package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//기업정보알려주는 리포지터리
@Repository
public class JasoRepository {

	

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getAll() {
		return template.selectList("jaso.getCompany");
	}
	
	public List<Map> getCate() {
		return template.selectList("jaso.getCate");
	}
	
	public List<Map> getHire() {
		return template.selectList("jaso.getHire");
	}
	
	
	
	public int addJasoForm(Map map) {
		return template.insert("jaso.addJasoForm",map);
	}
	
	public int addPassJaso(Map map) {
		return template.insert("jaso.addPassJaso",map);
	}
	
	
}
