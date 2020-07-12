package gamedori.sevlet.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.CommunityDao;
import gamedori.beans.dao.ReplyDao;
import gamedori.beans.dto.CommunityDto;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.ReplyDto;


@WebServlet(urlPatterns = "/board/reply_insert.do")
public class ReplyInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
			try {
//				입력 : member_no(세션) , reply_content(파라미터) 
				MemberDto user = (MemberDto) req.getSession().getAttribute("userinfo");
				
				ReplyDto rdto = new ReplyDto();
				
				
				rdto.setMember_no(user.getMember_no());
				rdto.setReply_content(req.getParameter("reply_content"));
				
				if(req.getParameter("reply_no") != null) {
					rdto.setReply_super_no(Integer.parseInt(req.getParameter("reply_no")));
				}
				
				
				ReplyDao rdao = new ReplyDao();
				int reply_no = rdao.getSequence();
				rdto.setReply_no(reply_no);
				
				rdao.write(rdto);
				
				
//				출력 : 
				resp.sendRedirect("content.jsp?board_no="+rdto.getReply_no());
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		
	}
}
