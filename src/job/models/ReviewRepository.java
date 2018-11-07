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
		int r =template.insert("review.writeReview",map);
		System.out.println("reviewRepo 터지나요오 : " +r);
		
		return r;
	}
	
	public Map didIWriteReview(Map map) {
		return template.selectOne("review.didIWriteReview", map);
	}
	
	public List<Map> getReviewsByCono(int cono){
		return template.selectList("review.getReviewsByCono",cono);
	}
	
	public int getAvgStar(int cono) {
		try {
			return template.selectOne("review.getAvgStar",cono);
		}catch(Exception e) {
			System.out.println("등록된 평점이없어서 평균이안나옴");
			return 0;
		}
		
	}
	
	public List<Map> getReview(String id){
		return template.selectList("review.getReview",id);
	}

	
}
