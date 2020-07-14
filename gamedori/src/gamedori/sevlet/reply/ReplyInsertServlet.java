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
				//세션에서 유저정보 뺴오고
				int member_no=user.getMember_no();
				
				//rdto라는 박스를 만들고 
				ReplyDto rdto = new ReplyDto();
				
				//rdto에 2개의 정보를 삽입해주고
				rdto.setReply_content(req.getParameter("reply_content"));
				rdto.setOrigin_no(Integer.parseInt(req.getParameter("origin_no")));
				
				
				
				//시퀀스 불러오고
				ReplyDao rdao = new ReplyDao();
				int reply_no = rdao.getSequence();
				rdto.setReply_no(reply_no);
				// 댓글 등록하고
				rdao.write(rdto);
				
				//개수를 다시 보자
				
				CommunityDao cdao = new CommunityDao();
				cdao.editReplycount(rdto.getOrigin_no());
				
//				출력 : 
				resp.sendRedirect("content.jsp?community_no="+rdto.getOrigin_no());
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		
	}
}
