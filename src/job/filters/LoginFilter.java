package job.filters;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

@Service("in")
public class LoginFilter extends HttpFilter {

	protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		System.out.println("����������" + req.getRequestURI());
		HttpSession session = req.getSession();
		ServletContext ctx = session.getServletContext();
		
		String query = req.getQueryString();
		String uri = req.getRequestURI();
		String target = uri.substring(req.getContextPath().length());
		session.setAttribute("target", target + (query!=null ? "?"+query : ""));
		
		
		
		if(session.getAttribute("auth") == null) {
			res.sendRedirect(ctx.getContextPath() + "/login.do");
			
		}else {
			chain.doFilter(req, res);
		}
		
		
	}
}
