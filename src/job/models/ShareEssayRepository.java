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
		return template.insert("like.setLike", map);
	}
	
	public Integer addLike(Integer no) {
		return template.insert("like.addLike", no);
	}
	
	public Map myLike(Map map){
		return template.selectOne("like.myLike",map);
	}
	
	public Integer setReply(Map map) {
		return template.insert("reply.setReply", map);
	}
	public List<Map> getReply(Integer no) {
		return template.selectList("reply.getReply", no);
	}
	
	public int updateReply(Integer no) {
		return template.update("reply.updateReply", no);
	}
	
	public int deleteShareEssay(Integer no) {
		return template.delete("shareEssay.deleteShareEssay", no);
	}
	
	public int deletePicked(Integer no) {
		return template.delete("shareEssay.deletePicked", no);
	}

	public List<Map> getMyRe(String id){
		return template.selectList("reply.getMyRe",id);
	}
}
