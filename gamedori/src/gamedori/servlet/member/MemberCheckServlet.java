package gamedori.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dto.MemberDto;

@WebServlet(urlPatterns = "/member/check.do")
public class MemberCheckServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//비밀번호를 검사하는 서블릿
			//입력 : 비밀번호(member_pw), 아이디(member_id) , 목적지 주소(go)
		
			
			String go = req.getParameter("go");//목적 페이지 주소
			
			String member_pw = req.getParameter("member_pw");
			
			MemberDto mdto = (MemberDto) req.getSession().getAttribute("userinfo");			
			String member_id = mdto.getMember_id();
			
			
			MemberDao mdao = new MemberDao();
			MemberDto user = new MemberDto();
			user.setMember_id(member_id);
			user.setMember_pw(member_pw);
			MemberDto result = mdao.login(user);
			
			if(result == null) {//인증 실패(로그인 실패)
//				인증이 실패한 경우에는 check.jsp로 되돌려야 하는데... 그냥 가라고 하면 목적지 정보가 누락된다
//				- 파라미터로 원래 가려고 했던 목적지 정보를 같이 전달해 주어야 한다.
				resp.sendRedirect("check.jsp?error&go="+go);
			}
			else {//인증 성공(로그인 성공)
//				resp.sendRedirect("change_password.jsp");
//				resp.sendRedirect("change_info.jsp");
//				resp.sendRedirect("exit.do");
				resp.sendRedirect(go);//go에 들어있는 주소로 redirect 해라!
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
