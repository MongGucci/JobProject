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
		Map m = template.selectOne("review.didIWriteReview", map);
		System.out.println("여긴들어오냐"+m);
		return m;
	}
	
}
