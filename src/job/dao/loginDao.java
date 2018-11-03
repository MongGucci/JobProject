package job.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class loginDao {

	@Autowired
	SqlSessionTemplate template;
	
	// 로그인
	public Map loginck(Map map) {
		return template.selectOne("applicant.loginck",map);
	}
	// 유저 정보 
	public Map userck(String id) {
		return template.selectOne("applicant.userck",id);
	}
	// 비밀번호 변경
	public int pwchange(Map map) {
		return template.update("applicant.pwchange",map);
	}
	
	public String getnick(String id) {
		return template.selectOne("applicant.getnick",id);
	}
	
}
