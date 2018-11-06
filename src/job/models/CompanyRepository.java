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
	
	public int addAll(Map map) {
		return template.insert("company.addAll",map);
	}
	
	public Map getByCo (String co) {
		return template.selectOne("company.getByCo",co);
	}
	
	public List<Map> getChatRooms(String id){
		return template.selectList("pickedcompany.getChatRooms",id);
	}
	
	public String getConameByCono(int cono) {
		return template.selectOne("company.getConameByCono",cono);
	}
}
