package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//채용상세검색 메뉴 뿌려주는 리포지터리
@Repository
public class ReviewRepository {

	

	@Autowired
	SqlSessionTemplate template;
	
	public int writeReview(Map map) {
		return template.insert("review.writeReview",map);
	}
	
	public Map didIWriteReview(Map map) {
		return template.selectOne("review.didIWriteReview", map);
	}
	
	public List<Map> getReviewsByCono(int cono){
		return template.selectList("review.getReviewsByCono",cono);
	}
	
}
