package job.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class searchDao {

	@Autowired
	SqlSessionTemplate template;
	
	// 요게 기업정보 상세보기
	public Map searchcom(int cono) {
		return template.selectOne("company.searchcom",cono);
	}
	// 요게 기업검색 리스트
	public List<Map> schlist(String coname) {
		return template.selectList("search.company",coname);
	}
	// 요게 관심기업 버튼
	public int schbtn(Map map) { 
		return template.insert("pickedcompany.schbtn",map);
	}
	// 요게 관심기업 중복 검사
	public List<Map> ckbtn(Map map) {
		System.out.println("버튼중복 : "+map);
		return template.selectList("pickedcompany.ckbtn",map);
	}
	// 요게 관심 기업 리스트 촤르륵
	public List<Map> cksearch(String coname) {
		return template.selectList("company.cksearch",coname);
	}
	// 요게 통합 검색 
	public List<Map> isearch(Map map) {
		return template.selectList("company.isearch",map);
	}
	
	public List<Map> company(List list){
		return template.selectList("search.company",list);
	}
	public List<Map> hire(List list){
		return template.selectList("search.hire",list);
	}
	public List<Map> passjaso(List list){
		return template.selectList("search.passjaso",list);
	}
	public List<Map> sharejaso(List list){
		return template.selectList("search.sharejaso",list);
	}
	
	
}

