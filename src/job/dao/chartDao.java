package job.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class chartDao {


   @Autowired
   SqlSessionTemplate template;
   
   // 남/여 차트  
   public List<Map> comchart(Map map) {
      return template.selectList("charts.comchart",map);
   }
   // 기업 등록한 사람 수 확인
   public Map saram(Map map) {
	   return template.selectOne("charts.saram",map);
   }
   // 나이별로 차트
   public List<Map> agechart(Map map) {
	   System.out.println("agechart : "+template.selectList("charts.agechart",map));
	   return template.selectList("charts.agechart",map);
   }
}

