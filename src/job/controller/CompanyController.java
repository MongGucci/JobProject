package job.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.models.CompanyRepository;
import job.models.LocationRepository;

@Controller
@RequestMapping("/admin")
public class CompanyController extends HttpServlet{

	@Autowired
	CompanyRepository cr;
	
	
	@Autowired
	LocationRepository lr;
	
	@GetMapping("/write.do")
	public String writeGetHandle(ModelMap map) {
		List<Map> wt = lr.getBig();
		/*List<Map> ws = lr.getSmall();*/
		map.put("wt", wt);
		/*map.put("ws", ws);*/
		System.out.println(wt);
		/*System.out.println(ws);*/
		return"admin/write";
	}
	
	@PostMapping("/write.do")
	public String wirtePostHandle(WebRequest wr, ModelMap map) {
		
		String coname = (String)wr.getParameter("coname");
		String industry = (String)wr.getParameter("industry");
		String sales = (String)wr.getParameter("sales");
		String ceo = (String)wr.getParameter("ceo");
		String salary = (String)wr.getParameter("salary");
		String workers = (String)wr.getParameter("workers");
		String lat = (String)wr.getParameter("lat");
		String lng = (String)wr.getParameter("lng");
		String first = (String)wr.getParameter("first");
		String homepage = (String)wr.getParameter("homepage");
		String big = (String)wr.getParameter("big");
		String small = (String)wr.getParameter("small");
		String cotype = (String)wr.getParameter("cotype");
		
		System.out.println(coname +" / "+ industry +" / "+ sales +" / "+ ceo +" / "+ salary +" / "+ lat +" / "
		+ lng +" / "+ first +" / "+ homepage +" / "+ big +" / "+ small);
		Map data = new HashMap<>();
		data.put("coname", coname);
		data.put("industry", industry);
		data.put("sales", sales);
		data.put("ceo", ceo);
		data.put("salary", salary);
		data.put("workers", workers);
		data.put("lat", lat);
		data.put("lng", lng);
		data.put("first", first);
		data.put("homepage", homepage);
		data.put("big", big);
		data.put("small", small);
		data.put("cotype", cotype);
		
		return "";
	}
	
}
