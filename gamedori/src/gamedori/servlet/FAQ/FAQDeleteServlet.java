package gamedori.servlet.FAQ;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import home.beans.dao.BoardDao;

@WebServlet(urlPatterns = "/board/delete.do")
public class FAQDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : board_no
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			
//			처리 : 삭제
			FAQDao bdao = new FAQDao();
			bdao.delete(board_no);//삭제
			
//			출력 : list.jsp로 redirect
			resp.sendRedirect("list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}








