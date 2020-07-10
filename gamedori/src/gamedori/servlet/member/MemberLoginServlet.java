package gamedori.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dto.MemberDto;

@WebServlet(urlPatterns = "/guest/login.do")
public class MemberLoginServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto mdto = new MemberDto();
			mdto.setMember_id(req.getParameter("member_id"));
			mdto.setMember_pw(req.getParameter("member_pw"));

			// 처리
			MemberDao mdao = new MemberDao();
			MemberDto user = mdao.login(mdto);

			// 출력
			if (user == null) {// 로그인 실패
				resp.sendRedirect("login.jsp?error");// 사용자에게 로그인 페이지로 되돌아가도록 지시
			} else {// 로그인 성공
//					로그인 시각을 갱신
				mdao.updateLoginTime(user.getMember_no());

//					로그인한 사용자 정보(user)를 "userinfo"라는 이름으로 세션에 저장
//					- 서블릿에서는 session이라는 이름의 객체가 없으므로 req에서 꺼내서 사용해야 한다
//					- JSP에서는 session이라는 이름으로 바로 접근이 가능하도록 준비되어 있다
				req.getSession().setAttribute("userinfo", user);

//					resp.sendRedirect("../index.jsp");//사용자에게 메인 페이지로 가도록 지시
				resp.sendRedirect(req.getContextPath());// 메인 페이지의 절대경로
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
<<<<<<< HEAD
}
=======
}
>>>>>>> refs/remotes/origin/master
