package gamedori.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dao.MemberFavoriteDao;
import gamedori.beans.dao.PointDao;
import gamedori.beans.dto.MemberDto;
import gamedori.beans.dto.MemberFavoriteDto;
import gamedori.beans.dto.PointDto;

@WebServlet(urlPatterns = "/guest/join.do")
public class MemberJoinServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");// 사용자의 요청을 UTF-8 형태로 복원하라!

			MemberDto mdto = new MemberDto();
			
			MemberDao mdao = new MemberDao();
			int member_no = mdao.getMember_no();
			mdto.setMember_no(member_no);
			mdto.setMember_name(req.getParameter("member_name"));
			mdto.setMember_id(req.getParameter("member_id"));
			mdto.setMember_pw(req.getParameter("member_pw"));
			mdto.setMember_nick(req.getParameter("member_nick"));
			mdto.setMember_phone(req.getParameter("member_phone"));

			// 처리 : MemberDao를 이용한 데이터베이스 등록
			
			mdao.join(mdto);
			
			String []genre_no = req.getParameterValues("member_favorite");
			
			for (int i = 0; i < genre_no.length; i++) {
				MemberFavoriteDto mfdto = new MemberFavoriteDto();
				mfdto.setGenre_no(Integer.parseInt(genre_no[i]));
				mfdto.setMember_no(member_no);
				
				MemberFavoriteDao mfdao = new MemberFavoriteDao();
				mfdao.choice(mfdto);
			}
			//회원포인트적립 로직 필요.
			PointDao pdao = new PointDao();
			PointDto pdto = new PointDto();
			pdto.setPoint_type("신규가입");
			pdto.setPoint_score(5000);
			
			pdao.insert(pdto,member_no);
			
			//pointDao에 있는 insert
			
			// 출력 : 이곳에서 하는 것이 아니라 다른 JSP 파일로 강제 이동
			resp.sendRedirect("join_result.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
