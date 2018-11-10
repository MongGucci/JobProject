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
	public List<Map> getSearchResultsbyPage(Map map){
		return template.selectList("hire.getSearchResultsbyPage",map);
	}
	
	public Map getHirebyHino(int hino){
		return template.selectOne("hire.getHireByHino",hino);
	}
	

	public List<Map> getHirebyCono(int cono){
		return template.selectList("hire.getHireByCono",cono);
	}
	
	public List<Map> getStartByPage(Map p) {
		System.out.println("page로 불러온 값start : "+template.selectList("hire.getStartByPage",p));
		return template.selectList("hire.getStartByPage",p);
	}
	public List<Map> getEndByPage(Map p) {
		System.out.println("page로 불러온 값end : "+template.selectList("hire.getEndByPage",p));
		return template.selectList("hire.getEndByPage",p);
	}
	public List<Map> getHitsByPage(Map p) {
		System.out.println("page로 불러온 값hits : "+template.selectList("hire.getHitsByPage",p));
		return template.selectList("hire.getHitsByPage",p);
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
	
	public List<Map> getDeadLine6(){
		
			return  template.selectList("hire.getDeadLine6");
		
	}
	public List<Map> getToday(String id){
		try {
			System.out.println("getToday 성공?");
			return  template.selectList("hire.getToday",id);
		}catch(Exception e){
			System.out.println("getToday 실패?" );
			e.printStackTrace();
			return null;
		}
	}

	public Map forcookie(int hino){
		
		return  template.selectOne("hire.forcookie",hino);
	
	}
	

	// 채용 정보 검색 
	public List<Map> hiresearch(Map map) {
		return template.selectList("hire.hiresearch", map);
	}	
	
	public int increaseHits(int hino) {
		int r = template.update("hire.increaseHits",hino);
		System.out.println("hrepo.increaseHits(hino); 결과 "+r);
		return r;
	}
	
	
	
	
}