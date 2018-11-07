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
	
}
