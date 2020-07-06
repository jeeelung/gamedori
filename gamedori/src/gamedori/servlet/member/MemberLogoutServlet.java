package gamedori.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/member/logout.do")
public class MemberLogoutServlet extends HttpServlet{
	
	//GET방식만 처리하는 메소드도 존재 : doGet
	//POST방식만 처리하는 메소드도 존재 : doPost
	//전부다 처리하는 메소드 : service
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		할일 : 세션의 "userinfo" 삭제 및 index.jsp 로 redirect
//		req.getSession().setAttribute("userinfo", null);
		req.getSession().removeAttribute("userinfo");//항목삭제
//		req.getSession().invalidate();//세션삭제
		
		resp.sendRedirect(req.getContextPath());//루트(root)로 redirect
	}
}