package gamedori.servlet.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.NoticeDao;

@WebServlet(urlPatterns = "/gamedori/delete.do")
public class NoticeDeleteServelt extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 입력 ; board_no
			int notice_no = Integer.parseInt(req.getParameter("notice_no"));

			// 처리 : 삭제
			NoticeDao ndao = new NoticeDao();
			ndao.delete(notice_no); // 삭제

			// 출력 : list.jsp redirect
			resp.sendRedirect("list.jsp"); // 같은폴더니까 상대경로
		 } 
			catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
