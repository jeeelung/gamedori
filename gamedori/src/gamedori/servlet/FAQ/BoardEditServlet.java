package gamedori.servlet.FAQ;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import home.beans.dao.BoardDao;
import home.beans.dto.BoardDto;

@WebServlet(urlPatterns = "/board/edit.do")
public class BoardEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : board_head, board_title, board_content, board_no -> BoardDto
			BoardDto bdto = new BoardDto();
			bdto.setBoard_no(Integer.parseInt(req.getParameter("board_no")));
			bdto.setBoard_head(req.getParameter("board_head"));
			bdto.setBoard_title(req.getParameter("board_title"));
			bdto.setBoard_content(req.getParameter("board_content"));
			
//			처리 : 
			FAQDao bdao = new FAQDao();
			bdao.edit(bdto);
			
//			출력 : 
			resp.sendRedirect("content.jsp?board_no="+bdto.getBoard_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}





