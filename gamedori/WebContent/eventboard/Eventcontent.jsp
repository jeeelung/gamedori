<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.EventDto"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int event_no = Integer.parseInt(request.getParameter("event_no"));
	Set<Integer> memory = null;
	if(memory == null){
		memory = new HashSet<>();
	}
	boolean isFirst = memory.add(event_no);
	System.out.println(memory);
		
	session.setAttribute("memory", memory);
	
	EventboardDao edao= new EventboardDao();
	
	MemberDto user = (MemberDto) session.getAttribute("userinfo");
	
	if(isFirst){
		edao.plusReadcount(event_no, user.getMember_id());
	}
	
	
	EventboardDto edto= new EventboardDto();
	
	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.get(edto.getMember_id());
	
	boolean isAdmin = user.getMember_auth().equals("관리자");
	
	
%>     

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>게시글 상세보기</h2>

	<!-- 테이블에 글 정보를 출력 -->
	<table border="1" width="60%">
		<tbody>
			
			<tr>
				<td>
				<!-- 작성자 -->
					<%=edto.getMember_id() %>
					
				</td>
			</tr>
			<tr>
				<td>
				<%=edto.getEvent_date()%>
				조회<%=edto.getEvent_read() %>	
					
				</td>
			</tr>
			
			<!-- 게시글 내용 영역 -->
			<tr height="300">
				<td valign="top">
				<%=edto.getEvent_content() %>
				</td>  
			</tr>
				<!-- 각종 버튼들 구현 -->
				<tr>
				<td colspan="2" align="right">
					<a href="EventBoardWrite.jsp">
					<input type="button" value="글쓰기">
					</a>
			
<jsp:include page="/template/footer.jsp"></jsp:include>