package job.models;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

@Repository
public class SoarRepository {

	@Autowired
	MongoTemplate template;

	public Map insertCompany(Map map) {
		Map ret = template.insert(map, "soar");
		return ret;
	}

	public Map getCompany(Integer cono) {
		Criteria c = Criteria.where("cono").in(cono);

		return template.findOne(new Query(c), Map.class, "soar");
	}

	public void updateComapny(Integer cono, int count, List inner) {

		Criteria c = Criteria.where("cono").in(cono);
		Update cnt = new Update().set("cnt", count);
		Update in = new Update().set("inner", inner);

		template.updateMulti(new Query(c), cnt, "soar");
		template.updateMulti(new Query(c), in, "soar");

	}

	public List<Map> getAllSoar() {

		return template.find(new Query(), Map.class, "soar");

	}
}
