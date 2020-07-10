package gamedori.servlet.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.QnaDao;
import gamedori.beans.dto.QnaDto;

	@WebServlet(urlPatterns="/qna/edit.do")
	public class QnaEditServlet extends HttpServlet{
		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				QnaDto qdto = new QnaDto();
				qdto.setQna_no(Integer.parseInt(req.getParameter("qna_no")));
				qdto.setQna_head(req.getParameter("board_head"));
				qdto.setQna_title(req.getParameter("board_title"));
				qdto.setQna_content(req.getParameter("board_content"));
				
//				처리 : 
				QnaDao qdao = new QnaDao();
				qdao.edit(qdto);
				
//				출력 : 
				resp.sendRedirect("content.jsp?qna_no="+qdto.getQna_no());
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		}
	}
