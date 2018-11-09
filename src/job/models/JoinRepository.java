package job.models;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinRepository {

   @Autowired
   SqlSessionTemplate template;
   
   
   
   public int add(Map map){
      return template.insert("applicant.add", map);
   }

   public Map getById(String id) {
      return template.selectOne("applicant.getById",id);
   }
   
   public int getByIdAndPass(Map data) {
      return template.selectOne("applicant.getByIdAndPass",data);
   }
   
   public Map getByEmail(String mail) {
      return template.selectOne("applicant.getByEmail",mail);
   }
   
   public Map getByNick(String nick) {
	      return template.selectOne("applicant.getByNick",nick);
	   }
   public Map userinfo(String id) {
	   return template.selectOne("applicant.userinfo",id);
   }
}