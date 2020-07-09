package gamedori.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dto.MemberDto;

// 패턴이 없으므로 일일이 입력
// - 비회원 기능(guest) 과 회원 기능(member)으로 폴더를 나눠서 폴더 전체(/폴더/*)로 입력해도 됨
@WebFilter(urlPatterns = {"/member/info.jsp", "/member/change_password.jsp", 
		"/member/change_password_result.jsp", "/member/change_info.jsp", "/member/check.jsp", 
		"/member/logout.do", "/member/change_password.do", "/member/exit.do", 
		"/member/change_info.do", "/member/check.do", "/admin/*"})
public class LoginFilter implements Filter{
// 목표 : 현재 요청을 보내고 있는 사용자(누군지는 모름)가 로그인 상태인 지 판정
// 정보 :
//	- 로그인 정보 : session에 저장된 userinfo 정보 (형태 : MemberDto)
// 계획 :
//	1) 세션에 있는 userinfo 정보를 꺼낸다
//	2) 해당 정보가 있는지 없는지 검사한다
//		- 있으면 : 로그인이 되어있는 사용자라고 볼 수 있다 (통과)
//		-  Chain.doFilter(request, response);
//		- 없으면 : 로그인이 되어있지 않은 사용자라고 볼 수 있다 (로그인 페이지로 리다이렉트)
//		-  response.sendRedirect("로그인페이지");
	
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		
		// 다운 캐스팅
		HttpServletRequest req = (HttpServletRequest)arg0;
		HttpServletResponse resp = (HttpServletResponse)arg1;
		
		// 로그인 여부 확인
		MemberDto mdto = (MemberDto)req.getSession().getAttribute("userinfo");
		
		if(mdto!=null) { // 로그인 상태
			arg2.doFilter(arg0, arg1);	// 통과
		} else { // 비회원 상태
			// 리다이렉트는 사용자에게 내가 알려준 위치로 다시 들어오라고 전송하는 명령
			// 사용자에게 알려지는 주소이므로 프로젝트명(Context Path)을 적어야 함
			// 필터는 반드시 절대경로로 써야한다 (어느 페이지에서 들어올 지 모르기 때문에)
			resp.sendRedirect(req.getContextPath()+"/member/login.jsp"); // 로그인 페이지로 이동
		}
		
	}

}