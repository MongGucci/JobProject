package job.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class searchDao {
	@Autowired
	SqlSessionTemplate template;
	
	// 요게 기업정보 상세보기
	public Map searchcom(int cono) {
		return template.selectOne("company.searchcom",cono);
	}
	// 요게 기업검색 리스트
	public List<Map> schlist(String coname) {
		return template.selectList("company.schlist",coname);
	}
}
