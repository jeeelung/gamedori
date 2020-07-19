<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">

<%
	//rootPath에는 프로젝트 root path(/home)가 자동으로 계산되어 저장된다. 이는 절대경로 작성 시 활용할 수 있다.
	String rootPath = request.getContextPath();
	//로그인 여부에 따른 메뉴 구성을 변경
	// - 세션에 "userinfo"라는 데이터가 있으면 로그인 , 없으면 로그아웃 상태
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");//다운캐스팅(down-casting)
	boolean isLogin = mdto != null;
%>

<!--  	로그인 상태일 경우 -->
<%
	if (isLogin) {
%>
<div class="member-wrap">
	<h5 class="menu-font">
		<a href="<%=rootPath%>/member/logout.do">로그아웃 </a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/member/info.jsp">마이페이지</a>
	</h5>
	<%if(mdto.getMember_auth().equals("관리자")){ %>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/admin/home.jsp">관리페이지</a>
	</h5>
	<%}%>
</div>
<div class="notice-wrap">
	<h5 class="menu-font">
		<a href="<%=rootPath%>/notice/list.jsp">공지사항</a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/eventboard/event_list.jsp">EVENT</a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/faq/list.jsp">자주 묻는 질문</a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/qna/qna_list.jsp">1:1 문의</a>
	</h5>
</div>
<%} else { %>
<div class="notice-wrap">
	<h5 class="menu-font">
		<a href="<%=rootPath%>/notice/list.jsp">공지사항</a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/eventboard/event_list.jsp">EVENT</a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/faq/list.jsp">자주 묻는 질문</a>
	</h5>
</div>
<div class="member-wrap">
	<h5 class="menu-font">
		<a href="<%=rootPath%>/guest/join.jsp">회원가입</a>
	</h5>
	<h5>｜</h5>
	<h5 class="menu-font">
		<a href="<%=rootPath%>/guest/login.jsp">로그인</a>
	</h5>
</div>
<%}%>
<ul class="menu">
	<li><a href="<%=rootPath%>/game/latestlist.jsp">최신게임</a></li>
	<li><a href="<%=rootPath%>/game/popularlist.jsp">인기게임</a></li>
	<li><a href="<%=rootPath%>/game/genrelist.jsp">장르별</a></li>
	<li><a href="<%=rootPath%>/game/upload.jsp">업로드</a>
		<!-- <ul class="menu-sec">
			<li><a href="#">업로드 요청</a></li>
		</ul> -->
	</li>
	<li><a href="<%=rootPath%>/community/list.jsp">커뮤니티</a></li>
	
</ul>