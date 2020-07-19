package gamedori.sevlet.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.PointDao;
import gamedori.beans.dao.PointHistoryDao;
import gamedori.beans.dao.ReplyDao;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.PointDto;
import gamedori.beans.dto.PointHistoryDto;
import gamedori.beans.dto.ReplyDto;


@WebServlet(urlPatterns = "/community/reply_insert_point.do")
public class ReplyInsertPointServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
			req.setCharacterEncoding("UTF-8");
			
			try {
//				입력 : reply_writer(세션) , reply_content(파라미터) 
				MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");
				//세션에서 유저정보 뺴오고
				
				
				//rdto라는 박스를 만들고 
				ReplyDto rdto = new ReplyDto();
				
				//rdto에 2개의 정보를 삽입해주고
				rdto.setMember_no(mdto.getMember_no());
				rdto.setReply_content(req.getParameter("reply_content"));
				rdto.setOrigin_no(Integer.parseInt(req.getParameter("origin_no")));
				
				
				
				//시퀀스 불러오고
				ReplyDao rdao = new ReplyDao();
				int reply_no = rdao.getSequence();
				rdto.setReply_no(reply_no);
				// 댓글 등록하고
				rdao.write(rdto);
				
				
//				출력 : 
				resp.sendRedirect(req.getContextPath() + "/community/content.jsp?commu_no="+rdto.getOrigin_no());
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		
	}
}
