package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//채용상세검색 메뉴 뿌려주는 리포지터리
@Repository
public class HireRepository {

	

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getAllHires() {
		return template.selectList("hire.getAllHires");
	}
	
	public List<Map> getSearchResults(Map map){
		return template.selectList("hire.getSearchResults",map);
	}
	
	public Map getHirebyHino(int hino){
		return template.selectOne("hire.getHireByHino",hino);
	}
	

	public List<Map> getHirebyCono(int cono){
		return template.selectList("hire.getHireByCono",cono);
	}
	
	public List<Map> getAllHiresByStartdate() {
		return template.selectList("hire.getAllHiresByStartdate");
	}
	
	public List<Map> getAllHiresByEnddate() {
		return template.selectList("hire.getAllHiresByEnddate");
	}
	
	public List<Map> getAllHiresByHits() {
		return template.selectList("hire.getAllHiresByHits");
	}
	
	public List<Map> getDeadline3(String id){
		try {
			return  template.selectList("hire.getDeadline3",id);
		}catch(Exception e){
			return null;
		}
	}
	
}