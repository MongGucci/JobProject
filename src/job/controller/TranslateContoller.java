package job.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import job.models.TransferService;

@Controller
@RequestMapping("/translate")
public class TranslateContoller {

	@Autowired
	TransferService trans;

	@Autowired
	Gson gson;

	@PostMapping(path = "/trans.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String TranslateHandle(@RequestParam Map map) {
		String returnValue = null;
		String choice = null;
		System.out.println(map);
		String lang = (String) map.get("lang");
		switch (lang) {
		case "en":
			choice = lang;
			break;
		case "zh-CN":
			choice = lang;
			break;

		case "es":
			choice = lang;
			break;

		case "fr":
			choice = lang;
			break;

		default:
			returnValue = "번역불가";
			break;
		}

		Set<Entry<String, String>> eset = map.entrySet();
		for (Iterator<Entry<String, String>> i = eset.iterator(); i.hasNext();) {
			Entry<String, String> e = i.next();
			String k = e.getKey();

			String v = e.getValue();

			System.out.println(v);

			if (!v.equals("")) {
				String render = null;
				switch (choice) {
				case "en":
					render = trans.enTransfer(v);
					break;
				case "zh-CN":
					render = trans.cnTransfer(v);
					break;

				case "es":
					render = trans.esTransfer(v);
					break;

				case "fr":
					render = trans.frTransfer(v);
					break;

				}

				Map re = gson.fromJson(render, Map.class);
				Map message = (Map) re.get("message");
				System.out.println(re);
				Map result = (Map) message.get("result");
				System.out.println(result.get("translatedText"));
				map.put(k, result.get("translatedText"));

			}
		}
		System.out.println(map);
		returnValue = gson.toJson(map);
		return returnValue;

	}

}
