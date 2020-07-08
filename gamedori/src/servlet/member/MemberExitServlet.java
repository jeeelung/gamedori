package servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dto.MemberDto;
@WebServlet(urlPatterns="/member/exit.do")
public class MemberExitServlet extends HttpServlet{
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		//입력 : member_id(세션)
		MemberDto mdto=(MemberDto) req.getSession().getAttribute("userinfo");
		int member_no=mdto.getMember_no();
		
		//처리
		MemberDao mdao =new MemberDao();
		mdao.exit(member_no);
		
		req.getSession().removeAttribute("userinfo");
//		req.getSession().invalidate();
		
		//출력
		resp.sendRedirect("goodbye.jsp");
	
}
catch(Exception e) {
	e.printStackTrace();
	resp.sendError(500);
}
}
}
