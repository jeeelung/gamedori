package gamedori.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dao.MemberDao;
import gamedori.beans.dto.MemberDto;

public class TestLoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException{
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
//			목표 : 서버를 구동하기만 하면 로그인이 되어있도록 구현하는 것
//			- 관리자로 가입시키든, 사용자로 가입시키든 선택하여 구현
//			- 주의 : 개발용이므로 서비스 배포시 반드시 제거
			
//			계획 :
//			1) 현재 요청을 보낸 사용자의 로그인 여부 조사
//			2) 1번에서 로그인이 되어있다면 통과, 안되어있다면 로그인 처리를 수행
//			 - DB에 아이디를 미리 만들어 두었다면 그 아이디를 불러와서 처리
//			 - DB에 아이디를 미리 만들어 두지 않았다면 신규 가입 처리 후 수행
//			3) 2번에서 불러온 정보를 세션에 저장 후 통과
			
			
//			1번 코드
			MemberDto mdto = (MemberDto)req.getSession().getAttribute("userinfo");
			
//			2번 코드
			if(mdto==null) {
				
				MemberDao mdao = new MemberDao();
				MemberDto user = mdao.get("khacademy"); // khacademy 아이디 확인
				if(user==null) { // 찾는 아이디가 없으면
					//회원가입 및 재검색
					MemberDto newUser = new MemberDto();
					newUser.setMember_name("semidori");
					newUser.setMember_id("semidori");
					newUser.setMember_pw("semidori");
					newUser.setMember_nick("테스트계정");
					newUser.setMember_phone("01012124545");
					mdao.join(newUser);
					
					user = mdao.get("semidori");
				}
				
				// 로그인
				req.getSession().setAttribute("userinfo", user);
				
			}
			
			chain.doFilter(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
