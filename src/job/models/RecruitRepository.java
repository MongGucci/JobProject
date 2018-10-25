package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//채용상세검색 메뉴 뿌려주는 리포지터리
@Repository
public class RecruitRepository {

	

	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getAllCate() {
		return template.selectList("jobcate.getAll");
	}
	
	public List<Map> getAllBigLocation() {
		return template.selectList("location.getBig");
	}
	
	public List<Map> getAllSmallLocation(String big) {
		return template.selectList("location.getSmall",big);
	}
	
	public List<Map> getAllCotype() {
		return template.selectList("cotype.getAll");
	}
	
	public List<Map> getAllHireshape() {
		return template.selectList("hireshape.getAll");
	}
	
}
