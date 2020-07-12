package gamedori.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gamedori.beans.dto.MemberDto;

// admin 폴더에 있는 전체 페이지를 필터링
//@WebFilter(urlPatterns = "/admin/*")
public class AdminFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 목표 : 허가받지 않은 사용자가 관리자 기능을 이용하는 것을 차단
		// 정보 : session에 있는 userinfo를 이용하여 검사(형태:MemberDto)
		// 계획 :
//			1) 세션의 정보를 추출한다
//			2) 로그인 여부를 검사한다
//				- 로그인이 되어있지 않으면 로그인 페이지로 리다이렉트
//			3) 권한을 검사한다
//				- 관리자인 경우 통과
//				- 관리자가 아닌 경우 403 오류를 송출(권한없음)
		
		// 다운 캐스팅
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
//		1번
		MemberDto mdto = (MemberDto)req.getSession().getAttribute("userinfo");
		
//		2번 : LoginFilter에서 하는 작업이므로 삭제
//		if(mdto==null) {
//			resp.sendRedirect(req.getContextPath()+"/member/login.jsp"); // 로그인 하고 와!
//			return; //중지(+반환)
//		}
		
//		3번 : 관리자 여부 확인			
		String member_auth = mdto.getMember_auth();
			
		if(member_auth.equals("관리자")){
			chain.doFilter(request, response);	// 관리자 통과
		} else {
			resp.sendError(403); // 관리자 외 차단(403:권한없음)
		}
		
	}

}
