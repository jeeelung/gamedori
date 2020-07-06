package gamedori.servlet.FAQ;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FAQDao;

@WebServlet(urlPatterns = "/faq/delete.do")
public class FAQDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : faq_no
			int faq_no = Integer.parseInt(req.getParameter("faq_no"));
			
//			처리 : 삭제
			FAQDao fdao = new FAQDao();
			fdao.delete(faq_no);//삭제
			
//			출력 : list.jsp로 redirect
			resp.sendRedirect("list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}