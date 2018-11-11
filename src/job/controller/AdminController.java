package job.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;

import job.models.JasoRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	JasoRepository jaso;

	@GetMapping("/companyjaso.do")
	public String companyGetHandle(WebRequest web) {

		List<Map> list = jaso.getAll();
		List<Map> cate = jaso.getCate();
		List<Map> hire = jaso.getHire();

		web.setAttribute("cate", cate, web.SCOPE_REQUEST);
		web.setAttribute("list", list, web.SCOPE_REQUEST);
		web.setAttribute("hire", hire, web.SCOPE_REQUEST);

		return "admin/companyjaso";
	}

	@PostMapping("/companyjaso.do")
	public String companyPostHandle(@RequestParam Map param) {
		System.out.println(param);
		int r = jaso.addJasoForm(param);

		return "redirect:/admin/companyjaso.do";
	}

	@GetMapping("/passjaso.do")
	public String passGetHandle(WebRequest web) {
		List<Map> list = jaso.getAll();
		List<Map> cate = jaso.getCate();

		web.setAttribute("cate", cate, web.SCOPE_REQUEST);
		web.setAttribute("list", list, web.SCOPE_REQUEST);

		return "admin/passjaso";
	}

	@PostMapping("/passjaso.do")
	public String passPostHandle(@RequestParam Map param) {
		System.out.println(param);
		param.put("path", "해당없음");

		int r = jaso.addPassJaso(param);
		return "redirect:/admin/passjaso.do";
	}

}
