package job.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import job.dao.chartDao;
import job.dao.searchDao;
import job.models.CompanyRepository;
import job.models.HireRepository;
import job.models.ReviewRepository;
import job.models.SoarRepository;

@Controller
@RequestMapping("/search")
public class SearchController {
	@Autowired
	searchDao searchdao;

	@Autowired
	HireRepository hrepo;

	@Autowired
	ReviewRepository rvrepo;

	@Autowired
	CompanyRepository crepo;

	@Autowired
	chartDao chartdao;

	@Autowired
	Gson gson;

	@Autowired
	SoarRepository soar;

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest req;

	@GetMapping("/search.do")
	public String searchGetHandle(Map map) {

		List<Map> company = crepo.getAll();
		map.put("company", company);
		return "job.search";
	}

	// 검색
	@RequestMapping("/searchpost.do")
	public String searchPostHandle(WebRequest wr) {
		String coname = (String) wr.getParameter("search");
		String[] words = coname.split(" ");
		List search = new ArrayList();
		for(int i=0;i<words.length;i++) {
			search.add(words[i]);
			System.out.println("list에 들어가는거 " +words[i]);
		}
		List<Map> results = searchdao.company(search);
		for(int i=0;i<results.size();i++) {
			System.out.println("results: "+results.get(i));
		}

		wr.setAttribute("keyword", coname, wr.SCOPE_REQUEST);
		
		if(results.size()==0) {
			return "job.schnull.index";
		}else {
			wr.setAttribute("sli", results, wr.SCOPE_REQUEST);
			return "job.schlist.index";
		}
		
	}

	// 요게 상세보기
	@RequestMapping("/schdetail.do")
	public String detailHandle(WebRequest wr, Map map, ModelMap mmp) {
		String no = (String) wr.getParameter("cono");
		int cono = Integer.parseInt(no);

		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map dt = searchdao.searchcom(cono);
		System.out.println("dtdtdtd:" + dt);
		wr.setAttribute("dt", dt, wr.SCOPE_REQUEST);

		List<Map> hiring = hrepo.getHirebyCono(cono);
		map.put("hiring", hiring);

		Map ch = new HashMap<>();
		ch.put("cono", cono);
		List<Map> chart = chartdao.comchart(ch);

		Map sa = new HashMap<>();
		sa.put("cono", cono);
		Map saram = chartdao.saram(sa);
		System.out.println("사람 : " + saram);
		map.put("saram", saram);

		// 남/여 차트 세팅
		String result = "";

		for (int i = 0; i < chart.size(); i++) {
			result += "['" + chart.get(i).get("GENDER") + "', " + chart.get(i).get("CNT") + "],";
		}

		map.put("result", result);
		System.out.println("ehlfk");
		// 나이별 차트
		Map tw = new HashMap<>();
		tw.put("cono", cono);
		List<Map> age = chartdao.agechart(tw);
		System.out.println("연령대별을 찍어봅니다 :" + age + "/" + tw);
		System.out.println(age.size());

		String agetext = "";

		for (int i = 0; i < age.size(); i++) {
			agetext += "['" + age.get(i).get("SARAM") + "', " + age.get(i).get("CNT") + "],";
		}

		map.put("agetext", agetext);
		// ====================================

		if (id != null) {
			Map mm = new HashMap();
			mm.put("id", id);
			mm.put("cono", cono);
			Map didI = rvrepo.didIWriteReview(mm);

			Map comap = new HashMap<>();
			comap.put("id", id);
			comap.put("cono", cono);

			List<Map> comjjim = searchdao.ckbtn(comap);
			wr.setAttribute("comjjim", comjjim, wr.SCOPE_REQUEST);

			System.out.println("썻냐안썻냐" + didI);
			if (didI != null) {
				map.put("youwrote", true);
			}
		}

		List<Map> reviews = rvrepo.getReviewsByCono(cono);
		map.put("reviews", reviews);

		int avg = rvrepo.getAvgStar(cono);
		if (avg == 0) {
			map.put("avg", 0);
		} else {
			map.put("avg", avg);
		}

		Map sd = new HashMap<>();
		sd.put("id", id);
		sd.put("cono", cono);

		// ==============================
		String coname = (String) dt.get("CONAME");
		System.out.println("어딘???:" + soar.getCompany(coname));
		Map company = soar.getCompany(coname);
		List<Map> before = soar.getAllSoar();
		System.out.println(before);
		System.out.println("id:" + session.getId());

		if (company == null) {
			Map skyrocket = new HashMap<>();
			List<String> inner = new ArrayList<>();
			skyrocket.put("coname", coname);
			skyrocket.put("cono", cono);
			skyrocket.put("cnt", 1);
			inner.add(session.getId());
			skyrocket.put("inner", inner);

			soar.insertCompany(skyrocket);
		} else {
			List in = (List) company.get("inner");
			if (!in.contains(session.getId())) {
				in.add(session.getId());
				int count = (int) company.get("cnt");
				count += 1;
				soar.updateComapny(coname, count, in);
			}

		}

		List<Map> after = soar.getAllSoar();
		System.out.println(after);

		if (wr.getParameter("recommend") != null) {
			map.put("recommend", true);
		}
		
		String uri = req.getRequestURI();
		String target = uri.substring(req.getContextPath().length())+"?cono="+cono;
		
		System.out.println(req.getRequestURI());
		wr.setAttribute("target", target, wr.SCOPE_SESSION);

		return "job.schdetail.index";

	}

	// 요게 해당하는 기업이름 촤르륵
	@GetMapping(path = "/searchajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchAjaxHandle(WebRequest wr, @RequestParam String coname) {
		/* String coname = (String)wr.getAttribute("coname", wr.SCOPE_SESSION); */
		List<Map> sch = searchdao.schlist(coname);
		System.out.println("촤르륵 : " + sch);
		for (int i = 0; i < sch.size(); i++) {
			Map e = sch.get(i);
			String e1 = gson.toJson(e);
			System.out.println(e1);
			if (i < sch.size() - 1) {
				String a = ",";
				System.out.println(",");
			}
		}
		return gson.toJson(sch);
	}

	// 요게 관심 기업 버튼 클릭 요거 안됨
	@GetMapping("/schbtn.do")
	public String schbtn(WebRequest wr, ModelMap map) {
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		String no = wr.getParameter("no");
		System.out.println("no:" + no);

		if (id == null) {
			return "/login/login";
		} else {
			return "redirect:/search/schdetail.do?cono=" + no;

		}
	}

	// 요게 관심 기업 등록
	@PostMapping(path = "/comjjimAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String comjjimAjaxHandle(@RequestParam Integer cono, WebRequest wr) {
		Map comjjim = new HashMap<>();

		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map cd = new HashMap<>();
		cd.put("id", id);
		cd.put("cono", cono);
		System.out.println(cd);

		try {
			int c = searchdao.schbtn(cd);
			comjjim.put("comjjim", true);
		} catch (Exception e) {
			e.printStackTrace();
			comjjim.put("comjjim", false);
		}
		return gson.toJson(comjjim);
	}

	// 요게 통합 검색
	@PostMapping("/isearch.do")
	public String isearchHandle(WebRequest wr, ModelMap map) {
		String keyword = (String)wr.getParameter("isearch");
		map.put("keyword", keyword);
		System.out.println("검색한 단어 : "+keyword);
		String[] words = keyword.split(" ");
		List search = new ArrayList();
		for(int i=0;i<words.length;i++) {
			search.add(words[i]);
			System.out.println("list에 들어가는거 " +words[i]);
		}
		List<Map> company = searchdao.company(search);
		List<Map> hire = searchdao.hire(search);
		System.out.println("hire 뭐가뜨냐" + hire);
		for (int i = 0; i < hire.size(); i++) {
			Map p = hire.get(i);

			java.sql.Timestamp timeStamp = (Timestamp) p.get("ENDDATE");
			java.sql.Date date = new java.sql.Date(timeStamp.getTime());
			long endd = date.getTime();
			long current = System.currentTimeMillis();
			long day = (endd - current) / (1000 * 60 * 60 * 24);
			if (day == 0) {
				p.put("DDAY", "D-DAY");
			} else if(day>0){

				p.put("DDAY", "D-" + (day+1));
			} else {
				p.put("DDAY", "[마감]");
			}
			System.out.println((endd - current) / (1000 * 60 * 60 * 24));

		}
		List<Map> passjaso = searchdao.passjaso(search);
		List<Map> sharejaso =searchdao.sharejaso(search);
		System.out.println("pass jaso : "+passjaso);
 		if(company.size()==0&&hire.size()==0&&passjaso.size()==0&&sharejaso.size()==0) {
			return "job.schlist.index";
		}else {
			map.put("company", company);
			map.put("hire",hire);
			map.put("passjaso", passjaso);
			map.put("sharejaso",sharejaso);
			System.out.println("company : "+company);
			System.out.println("hire : "+hire);
			System.out.println("passjaso : "+passjaso);
			System.out.println("sharejaso :"+sharejaso);
			return "job.isearchlist";
		}
	}
	
	@GetMapping("/onlyhire.do")
	public String onlyhireHandle(@RequestParam Map param,Map map) {
		String keyword = (String)param.get("keyword");
		String[] words = keyword.split(" ");
		List search = new ArrayList();
		for(int i=0;i<words.length;i++) {
			search.add(words[i]);
			System.out.println("list에 들어가는거 " +words[i]);
		}
		List<Map> hire = searchdao.hire(search);
		
		for (int i = 0; i < hire.size(); i++) {
			Map p = hire.get(i);

			java.sql.Timestamp timeStamp = (Timestamp) p.get("ENDDATE");
			java.sql.Date date = new java.sql.Date(timeStamp.getTime());
			long endd = date.getTime();
			long current = System.currentTimeMillis();
			long day = (endd - current) / (1000 * 60 * 60 * 24);
			if (day == 0) {
				p.put("DDAY", "D-DAY");
			} else if(day>0){

				p.put("DDAY", "D-" + (day+1));
			} else {
				p.put("DDAY", "[마감]");
			}
			System.out.println((endd - current) / (1000 * 60 * 60 * 24));

		}
		map.put("lists", hire);
		map.put("keyword", keyword);
		return "job.onlyhire";
	}

	
	//동적Nㅝ리연습
	@PostMapping("/dynamic.do")
	public void dynamicsearchHandle(WebRequest wr,Map map) {
		String keyword = (String)wr.getParameter("search");
		System.out.println("검색한 단어 : "+keyword);
		String[] words = keyword.split(" ");
		List search = new ArrayList();
		for(int i=0;i<words.length;i++) {
			search.add(words[i]);
			System.out.println("list에 들어가는거 " +words[i]);
		}
		List<Map> results = searchdao.sharejaso(search);
		for(int i=0;i<results.size();i++) {
			System.out.println("results: "+results.get(i));
		}
		
		
	}
}