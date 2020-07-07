package gamedori.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dto.MemberDto;
@WebServlet(urlPatterns = "/member/change_info.do")
public class MemberChangeInfoServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			// 입력
			// member_
			MemberDto mdto = (MemberDto)req.getSession().getAttribute("userinfo");
			String member_id = mdto.getMember_id();
			
			MemberDto user = new MemberDto();
			user.setMember_id(member_id);
			user.setMember_nick(req.getParameter("member_nick"));
			user.setMember_phone(req.getParameter("member_phone"));
			user.setMember_pw(req.getParameter("member_pw"));
			
			// 처리
			MemberDao mdao = new MemberDao();
			mdao.changeInfo(user);
			
			// 출력
			resp.sendRedirect("info.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
