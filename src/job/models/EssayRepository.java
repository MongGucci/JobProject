package job.models;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class EssayRepository {
	
	@Autowired
	SqlSessionTemplate template;
	
	public List<Map> getJobCate() {
		return template.selectList("essay.getJobCate");
	}
	
	public Integer setMyEssay(Map map) {
		return template.insert("essay.setMyEssay", map);
	}
	public List<Map> getMyEssay(String id) {
		return template.selectList("essay.getMyEssay",id);
	}
	
	public Map getDetailEssay(String no) {
		return template.selectOne("essay.getDetailEssay",no);
	}
	
	public Integer updateEssay(Map map) {
		return template.update("essay.updateEssay", map);
	}
	
	public List<Map> getHire(Map map) {
		return template.selectList("essay.getHire",map);
	}
	
	public Map getJasoForm(Integer hino) {
		return template.selectOne("essay.getJasoForm",hino);
	}
	public List<Map> getPassJaso() {
		return template.selectList("essay.getPassJaso");
	}
	
	public Integer totalHire() {
		return template.selectOne("essay.totalHire");
	}
	
	

}
