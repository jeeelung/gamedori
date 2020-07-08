package gamedori.servlet.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.NoticeDao;
import gamedori.beans.dto.NoticeDto;

@WebServlet(urlPatterns = "/gamedori/edit.do")
public class NoticeEditServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			NoticeDto ndto = new NoticeDto();
			ndto.setNotice_no(Integer.getInteger("notice_no"));
			ndto.setMember_no(Integer.getInteger("member_no"));
			ndto.setNotice_title(req.getParameter("notice_title"));
			ndto.setNotice_content(req.getParameter("notice_content"));
			ndto.setNotice_date(req.getParameter("notice_date"));
			ndto.setNotice_read(Integer.getInteger("notice_read"));

//			처리 : 
			NoticeDao ndao = new NoticeDao();
			ndao.edit(ndto);

//			출력 : 
			resp.sendRedirect("content.jsp?notice_no=" + ndto.getNotice_no());
		    } 
		    catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);

		}

	}

}
