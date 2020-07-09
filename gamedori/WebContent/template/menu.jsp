<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//rootPath에는 프로젝트 root path(/home)가 자동으로 계산되어 저장된다. 이는 절대경로 작성 시 활용할 수 있다.
	String rootPath = request.getContextPath();
	//로그인 여부에 따른 메뉴 구성을 변경
	// - 세션에 "userinfo"라는 데이터가 있으면 로그인 , 없으면 로그아웃 상태
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo");//다운캐스팅(down-casting)
	boolean isLogin = mdto != null;
%>
<!--  	로그인 상태일 경우 -->
	<%if(isLogin){ %>
	<a href="<%=rootPath%>/index.jsp">홈으로</a>
	<a href="<%=rootPath%>/member/logout.do">로그아웃</a>
	<a href="<%=rootPath%>/member/info.jsp">내정보</a>
	
<!-- 		관리자 로그인 상태일 경우 -->
	<%if(mdto.getMember_auth().equals("관리자")) {%>
	<a href="<%=rootPath%>/admin/home.jsp">관리메뉴</a>
	<%} %>

	<a href="#">공지사항</a>
	<a href="#">커뮤니티</a>
	<a href="#">이벤트</a>
	<a href="#">FAQ</a>
	<a href="#">1:1문의</a>	
	<%}else{ %>
<!-- 	로그인 상태가 아닐 경우 -->
	<a href="<%=rootPath%>/guest/join.jsp">회원가입</a>
	<a href="<%=rootPath%>/guest/login.jsp">로그인</a>
	<a href="<%=rootPath%>/notice/list.jsp">공지사항</a>
	<a href="#">커뮤니티</a>
	<a href="#">이벤트</a>
	<a href="#">FAQ</a>
	<a href="#">1:1문의</a>	
	<%}%>