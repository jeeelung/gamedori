package gamedori.servlet.FAQ;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.FAQDao;
import gamedori.beans.dto.FAQDto;
import gamedori.beans.dto.MemberDto;

//@WebServlet(urlPatterns = "/faq/write.do")
public class FAQWriteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			목표 : 게시글 등록 후 상세 페이지로 이동
//			준비 : 말머리, 제목, 내용, 작성자
			
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
			int member_no = mdto.getMember_no();//작성자 추출
			
			FAQDto fdto = new FAQDto();
			fdto.setFaq_head(req.getParameter("faq_head"));
			fdto.setFaq_title(req.getParameter("faq_title"));
			fdto.setFaq_content(req.getParameter("faq_content"));
			fdto.setFaq_writer_no(member_no);
			
			FAQDao fdao = new FAQDao();
			int faq_no = fdao.getSequence();//들어갈 번호 먼저 추출
			fdto.setFaq_no(faq_no);//들어갈 번호를 설정한 뒤
			fdao.write(fdto);//등록
			
			resp.sendRedirect("content.jsp?faq_no="+faq_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);//--> 미리 등록된 에러 페이지 500번으로 연동
		}
	}
}









