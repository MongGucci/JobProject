package job.models;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public class ShareEssayRepository {
	
	@Autowired
	SqlSessionTemplate template;

	public Integer setShareJaso(Map map) {
		return template.insert("shareJaso.setShareJaso", map);
	}

}
