package job.controller;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import job.models.AlertService;
import job.models.HireRepository;
import job.models.PickedhireRepository;
import job.models.RecruitRepository;
import job.models.ReviewRepository;
import job.models.SoarRepository;

@Controller
@RequestMapping("/recruit")
public class RecruitController {

	@Autowired
	Gson gson;
	@Autowired
	RecruitRepository rrepo;
	@Autowired
	HireRepository hrepo;
	@Autowired
	PickedhireRepository phrepo;
	@Autowired
	ReviewRepository rvrepo;
	@Autowired
	AlertService alert;
	@Autowired
	SoarRepository soar;

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest req;
	
	@GetMapping("/select.do") //Index나 nav에서 채용공고 클릭 시

	public String selectGetHandle(Map map, WebRequest wr) {
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");

		List<Map> cate = rrepo.getAllCate();
		List<Map> big = rrepo.getAllBigLocation();
		List<Map> cotype = rrepo.getAllCotype();
		List<Map> hireshape = rrepo.getAllHireshape();
		map.put("cate", cate);
		map.put("big", big);
		map.put("cotype", cotype);
		map.put("hireshape", hireshape);

		String mode = (String) wr.getParameter("mode");
		String pg = (String) wr.getParameter("page");
		System.out.println("mode/pg : " + mode + "/" + pg);
		List<Map> Totalstart = hrepo.getAllHiresByStartdate();
		List<Map> Totalhits = hrepo.getAllHiresByHits();
		List<Map> Totalend = hrepo.getAllHiresByEnddate();

		int startpage = (Totalstart.size() % 10 == 0) ? (Totalstart.size() / 10) : (Totalstart.size() / 10) + 1;
		int hitspage = (Totalhits.size() % 10 == 0) ? (Totalhits.size() / 10) : (Totalhits.size() / 10) + 1;
		int endpage = (Totalend.size() % 10 == 0) ? (Totalend.size() / 10) : (Totalend.size() / 10) + 1;

		map.put("startpage", startpage);
		map.put("hitspage", hitspage);
		map.put("endpage", endpage);

		List<Map> dead = hrepo.getDeadLine6();
		System.out.println(dead);
		map.put("dead", dead);

		Map m = new HashMap<>();
		if (mode == null) {

			if (pg != null) {
				int page = Integer.parseInt(pg);
				int s = ((page - 1) * 10) + 1;
				int e = page * 10;
				System.out.println("s/e : " + s + e);
				m.put("s", s);
				m.put("e", e);

			} else {

				m.put("s", 1);
				m.put("e", 10);
			}

			List<Map> start = hrepo.getStartByPage(m);
			System.out.println("페이지눌러들갈때 값 start " + start);
			
			for (int i = 0; i < start.size(); i++) {
				Map p = start.get(i);

				java.sql.Timestamp timeStamp = (Timestamp) p.get("ENDDATE");
				java.sql.Date date = new java.sql.Date(timeStamp.getTime());
				long end = date.getTime();
				long current = System.currentTimeMillis();
				long day = (end - current) / (1000 * 60 * 60 * 24);
				if (day == 0) {
					p.put("DDAY", "D-DAY");
				} else if(day>0){

					p.put("DDAY", "D-" + (day+1));
				} else {
					p.put("DDAY", "[마감]");
				}
				System.out.println((end - current) / (1000 * 60 * 60 * 24));

			}
			map.put("start", start);
			return "job.selectstart";

		} else if (mode.equals("hits")) {

			if (pg != null) {
				int page = Integer.parseInt(pg);
				m.put("s", ((page - 1) * 10) + 1);
				m.put("e", page * 10);

			} else {
				m.put("s", 1);
				m.put("e", 10);
			}

			List<Map> hits = hrepo.getHitsByPage(m);
			System.out.println("페이지눌러들갈때 값 hits " + hits);
			for (int i = 0; i < hits.size(); i++) {
				Map p = hits.get(i);

				java.sql.Timestamp timeStamp = (Timestamp) p.get("ENDDATE");
				java.sql.Date date = new java.sql.Date(timeStamp.getTime());
				long end = date.getTime();
				long current = System.currentTimeMillis();
				long day = (end - current) / (1000 * 60 * 60 * 24);
				if (day == 0) {
					p.put("DDAY", "D-DAY");
				} else if(day>0){

					p.put("DDAY", "D-" + (day+1));
				} else {
					p.put("DDAY", "[마감]");
				}
				System.out.println((end - current) / (1000 * 60 * 60 * 24));

			}
			map.put("hits", hits);
			return "job.selecthits";
		} else if (mode.equals("end")) {

			if (pg != null) {
				int page = Integer.parseInt(pg);
				m.put("s", ((page - 1) * 10) + 1);
				m.put("e", page * 10);

			} else {
				m.put("s", 1);
				m.put("e", 10);
			}

			List<Map> end = hrepo.getEndByPage(m);
			System.out.println("페이지눌러들갈때 값 end " + end);
			for (int i = 0; i < end.size(); i++) {
				Map p = end.get(i);

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
			map.put("end", end);
			return "job.selectend";
		} else {
			System.out.println("mode값이 이상함select.do");
			return "job.index";
		}

	}
	
	@PostMapping(path = "/selectajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody //채용공고 	선택검색에서     지역(대) 선택 시

	public String selectAjaxHandle(@RequestParam String big) {
		List<Map> small = rrepo.getAllSmallLocation(big);
		return gson.toJson(small);
	}

	@GetMapping("/selectdetail.do") //리스트에서 어느 기업의 채용공고를 클릭 시

	public String selectdetailPostHandle(@RequestParam Map param, Map map, WebRequest wr) {
		List<Map> results = hrepo.getSearchResults(param);
		System.out.println("selectdetail.do에 들어온 param값 ? "+param);
		int totalpage = (results.size() % 10 == 0) ? (results.size() / 10) : (results.size() / 10) + 1;
		map.put("totalpage", totalpage);
		String pg = (String) param.get("page");
		
		if (pg != null) {
			int page = Integer.parseInt(pg);
			param.put("s", ((page - 1) * 10) + 1);
			param.put("e", page * 10);

		} else {
			param.put("s", 1);
			param.put("e", 10);
		}
		List<Map> result = hrepo.getSearchResultsbyPage(param);
		
		for (int i = 0; i < result.size(); i++) {
			Map p = result.get(i);

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
		
		map.put("lists", result);
		wr.setAttribute("condition", param, wr.SCOPE_SESSION);

		return "job.selectdetail";
	}

	

	@GetMapping("/jobpost.do") //리스트에서 어느 기업의 채용공고를 클릭 시

	public String jobpostGetHandle(HttpServletResponse response, @RequestParam Map param, Map post, WebRequest wr,
			ModelMap map) {

		
		SimpleDateFormat fmt = new SimpleDateFormat("yy.MM.dd");
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		int hino = Integer.parseInt((String) param.get("hino"));
		hrepo.increaseHits(hino);
		Map company = hrepo.getHirebyHino(hino);
		String hi = String.valueOf(hino);
		System.out.println("무슨 상세내용을 넣어줘야하지 : "+company);
		Cookie setCookie = new Cookie(hi, "hino"); // 쿠키 생성
		setCookie.setMaxAge(60 * 60 * 24); // 기간을 일주일로 지정
		response.addCookie(setCookie);

		Date start = (Date) company.get("STARTDATE");
		Date end = (Date) company.get("ENDDATE");
		company.put("START", fmt.format(start));
		company.put("END", fmt.format(end));
		long gap = end.getTime() - System.currentTimeMillis();
		if (gap < 0) {
			company.put("MAGAM", true);
		}
		post.put("list", company);

		if (id != null) {

			Map jjimap = new HashMap<>();
			jjimap.put("id", id);
			jjimap.put("hino", hino);

			List<Map> jjim = phrepo.myjjim(jjimap);
			wr.setAttribute("jjim", jjim, wr.SCOPE_REQUEST);
		}

		// ==============================
		int cono = ((BigDecimal) company.get("CONO")).intValue();
		String coname = (String) company.get("CONAME");
		System.out.println("어딘???:" + soar.getCompany(coname));
		Map comp = soar.getCompany(coname);
		List<Map> before = soar.getAllSoar();
		System.out.println(before);
		System.out.println("id:" + session.getId());
		

		if (comp == null) {
			Map skyrocket = new HashMap<>();
			List<String> inner = new ArrayList<>();
			skyrocket.put("coname", coname);
			skyrocket.put("cono", cono);
			skyrocket.put("cnt", 1);
			inner.add(session.getId());
			skyrocket.put("inner", inner);

			soar.insertCompany(skyrocket);
		} else {
			List in = (List) comp.get("inner");
			if (!in.contains(session.getId())) {
				in.add(session.getId());
				int count = (int) comp.get("cnt");
				count += 1;
				soar.updateComapny(coname, count, in);
			}

		}

		List<Map> after = soar.getAllSoar();
		System.out.println(after);

		// ==============================
		int avg = rvrepo.getAvgStar(cono);
		if (avg == 0) {
			map.put("avg", 0);
		} else {
			map.put("avg", avg);
		}
		//===============================
		String uri = req.getRequestURI();
		String target = uri.substring(req.getContextPath().length())+"?hino="+hino;
		
		System.out.println(req.getRequestURI());
		wr.setAttribute("target", target, wr.SCOPE_SESSION);

		return "job.jobpost";

	}



	@PostMapping("/review.do") //기업 공고jsp에서 리뷰를 남길 때
	public String writeReviewHandle(WebRequest session, @RequestParam Map param) {
		System.out.println("param :" + param);

		String s = (String) param.get("star");
		String good = (String) param.get("good");
		String bad = (String) param.get("bad");
		String id = (String) session.getAttribute("userId", session.SCOPE_SESSION);
		int star = Integer.parseInt(s);
		System.out.println("cono: " + param.get("cono"));
		String no = (String) param.get("cono");
		int cono = Integer.parseInt(no);

		// System.out.println(s+"/"+star+"/"+good+"/"+bad+"/"+id+"/"+cono);

		Map map = new HashMap();
		map.put("id", id);
		map.put("good", good);
		map.put("bad", bad);
		map.put("star", star);
		map.put("cono", cono);
		int r = rvrepo.writeReview(map);
		System.out.println("r/" + r);
		System.out.println("map : " + map);
		if (r == 1) {
			session.setAttribute("sucess", true, session.SCOPE_REQUEST);
			return "redirect:/search/schdetail.do?cono=" + cono;
		} else {
			session.setAttribute("fail", true, session.SCOPE_REQUEST);
			return "redirect:/search/schdetail.do?cono=" + cono;
		}
	}

/*	@GetMapping("/newpost.do") 
	public void newpostGetHandle(WebRequest wr) {
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map msg = new HashMap<>();

		msg.put("mode", "newpost");
		msg.put("msg", id + "님이 찜한 기업의 공고가 새로 올라왔습니다.");
		msg.put("link", 1113);
		// msg.put("link", 보낸값에서 cono뽑기);
		alert.sendOne(msg, "skdbs0610");
	}
*/

	@GetMapping(path = "/recenthireajax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pickhireAjaxHandle(HttpServletRequest request) {
		System.out.println("쿠카이아작스들옴");
		Cookie[] getCookie = request.getCookies();
		List<Map> recenthinos = new ArrayList<>();
		if (getCookie != null) {
			for (int i = 0; i < getCookie.length; i++) {
				Cookie c = getCookie[i];
				if (c.getValue().equals("hino")) {
					int h = Integer.parseInt(c.getName());
					Map recent = hrepo.forcookie(h);
					recenthinos.add(recent);
				}

			}
		}
		System.out.println("최근 본 공고 번호들 (아작스쿠키 ) :" + recenthinos);

		return gson.toJson(recenthinos);

	}
	
	// 요게 채용 공고 찜하기
	@PostMapping(path = "/hirejjimAjax.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // 채용 공고 jsp에서 공고 찜하기를 클릭 시
	public String hirejjimAjaxHandle(@RequestParam Integer hino, WebRequest wr) {

		Map jjim = new HashMap<>();

		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		Map sd = new HashMap<>();
		sd.put("id", id);
		sd.put("hino", hino);
		System.out.println(sd);
		List<Map> three = hrepo.getDeadline3(id);
		List<Map> today = hrepo.getToday(id);
		wr.setAttribute("three", three, wr.SCOPE_SESSION);
		wr.setAttribute("today", today, wr.SCOPE_SESSION);
		System.out.println("세션에 올라가는 today ? " + today);
		System.out.println("세션에 올라가는 three ? " + three);
		try {

			int a = phrepo.pickHire(sd);
			jjim.put("jjim", true);

		} catch (Exception e) {
			e.printStackTrace();
			jjim.put("jjim", false);
		}
		return gson.toJson(jjim);
	}

}
