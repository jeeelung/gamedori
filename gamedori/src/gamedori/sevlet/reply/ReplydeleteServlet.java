package gamedori.sevlet.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.CommunityDao;
import gamedori.beans.dao.ReplyDao;

@WebServlet(urlPatterns = "/board/reply_delete.do")
public class ReplydeleteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			입력 : reply_no, reply_origin
			int reply_no = Integer.parseInt(req.getParameter("reply_no"));
			int origin_no = Integer.parseInt(req.getParameter("reply_origin"));
			
//			처리 : 
			ReplyDao rdao = new ReplyDao();
			rdao.delete(reply_no);
			
			
//			댓글이 삭제되었다면 개수를 다시 세도록 지시
			
			CommunityDao cdao = new CommunityDao();
			cdao.editReplycount(origin_no);

			
//			출력 :
			resp.sendRedirect("content.jsp?community_no="+origin_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}


