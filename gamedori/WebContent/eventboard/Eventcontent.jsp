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

	
	
	EventboardDto edto= new EventboardDto();
	
	
%>     

<jsp:include page="/template/header.jsp"></jsp:include>


<article class="w-60">
	<div class="row">
		<h2>게시글 상세보기</h2>
	</div>
	<div class="row">
		
		
		<%=edto.getEvent_title()%>
	</div>
	<div class="row">
		<!-- 작성자 -->
		<%=edto.getMember_id() %>
	</div>
	
	<div class="row">
		<%=edto.getEvent_date() %>
		조회 <%=edto.getEvent_read()%>
	</div>
	
	<!-- 게시글 내용 영역 -->
	<div class="row" style="min-height:300px;">
		<%=edto.getEvent_content()%>
	</div>
	
	
	
	<!-- 각종 버튼들 구현 -->
	<div class="row right">
		<a href="EventBoardWrite.jsp">
			<input class="form-btn form-inline" type="button" value="글쓰기">
		</a>
		
		
	
		
		<a href="event_list.jsp">
			<input class="form-btn form-inline" type="button" value="목록">
		</a>
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>