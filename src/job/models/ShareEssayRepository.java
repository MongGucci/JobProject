package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShareEssayRepository {
	
	@Autowired
	SqlSessionTemplate template;

	public Integer setShareEssay(Map map) {
		return template.insert("shareEssay.setShareEssay", map);
	}
	
	public List<Map> getShareEssay(){
		return template.selectList("shareEssay.getShareEssay");
	}
	
	public Map getShareDetail(String no){
		return template.selectOne("shareEssay.getShareDetail",no);
	}

	public Integer setLike(Map map) {
		return template.insert("shareEssay.setLike", map);
	}
	
	public Integer addLike(Integer no) {
		return template.insert("shareEssay.addLike", no);
	}
	
	public Map myLike(Map map){
		return template.selectOne("shareEssay.myLike",map);
	}

}
