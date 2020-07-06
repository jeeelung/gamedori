package gamedori.servlet.FAQ;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FAQDao;
import gamedori.beans.dto.FAQDto;

@WebServlet(urlPatterns = "/faq/edit.do")
public class FAQEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : faq_head, faq_title, faq_content, faq_no -> faqDto
			FAQDto fdto = new FAQDto();
			fdto.setFaq_no(Integer.parseInt(req.getParameter("faq_no")));
			fdto.setFaq_head(req.getParameter("faq_head"));
			fdto.setFaq_title(req.getParameter("faq_title"));
			fdto.setFaq_content(req.getParameter("faq_content"));
			
//			처리 : 
			FAQDao fdao = new FAQDao();
			fdao.edit(fdto);
			
//			출력 : 
			resp.sendRedirect("content.jsp?faq_no="+fdto.getFaq_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}