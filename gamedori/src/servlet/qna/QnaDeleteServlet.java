package servlet.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.QnaDao;


@WebServlet(urlPatterns="/qna/delete.do")
public class QnaDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		int qna_no =Integer.parseInt(req.getParameter("qna_no"));
//		처리 : 삭제
		QnaDao qdao =new QnaDao();
		qdao.delete(qna_no); // 삭제
//		출력 : list.jsp로 redirect
		resp.sendRedirect("list.jsp");
	}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}

