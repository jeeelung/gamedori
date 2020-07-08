package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dto.MemberDto;

@WebServlet(urlPatterns="/guest/join.do")
public class MemberJoinServlet extends HttpServlet{
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		req.setCharacterEncoding("UTF-8");//사용자의 요청을 UTF-8 형태로 복원하라!
		
		MemberDto mdto = new MemberDto();
		mdto.setMember_name(req.getParameter("member_name"));
		mdto.setMember_id(req.getParameter("member_id"));
		mdto.setMember_pw(req.getParameter("member_pw"));
		mdto.setMember_nick(req.getParameter("member_nick"));
		mdto.setMember_phone(req.getParameter("member_phone"));
		
		//처리 : MemberDao를 이용한 데이터베이스 등록
		MemberDao mdao = new MemberDao();
		mdao.join(mdto);
		
		//출력 : 이곳에서 하는 것이 아니라 다른 JSP 파일로 강제 이동
		resp.sendRedirect("join_result.jsp");
		
		
	}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}


}
}
