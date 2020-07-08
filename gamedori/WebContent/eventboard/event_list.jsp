
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<% 



//	List<BoardDto> list = 목록 or 검색;
EventboardDao edao= new EventboardDao();
List<EventboardDto> list=edao.getList();

  
%>
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

<article class="w-90">
	<!-- 제목 -->
	<div class="row">
		<h2>이벤트 게시판</h2>
	</div>
	
	<!-- 글쓰기 버튼 -->
	<div class="row right">
		<a href="EventBoardWrite.jsp">
			<input class="form-btn form-inline" type="button" value="글쓰기">
		</a>
	</div>
	
	<!-- 글 목록 -->
	<div class="row">
	
		<!-- 테이블 -->
		<table border="1" width="90%" class="table table-border table-stripe table-hover" >
			<thead>
				<tr aling="center">
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody align="center">
				<%-- list의 데이터를 하나하나 edto라는 이름으로 접근하여 출력 --%>
				<%for(EventboardDto edto : list){ %>
				<tr>
				
					<td><%=edto.getEvent_no()%></td>
					<td class="left">
					
					
					
					<!-- 게시글 제목 -->
					<a href="Eventcontent.jsp?event_no=<%=edto.getEvent_no() %>">
					<%=edto.getEvent_title() %>
					</a>
					<%if (edto.getEventboard_replycount() > 0){ %>
						<!-- 댓글 개수를 출력(있을 경우만) -->
						[<%=edto.getEventboard_replycount()%>]
						<%} %>
						
					</td>
					<%MemberDto mdto = edao.getWriter(edto.getMember_no()); %>
					<td><%=mdto.getMember_nick() %></td>
					<td><%=edto.getEventboard_autotime() %></td>
					<td><%=edto.getEvent_read() %></td>
					
				</tr>
				<%} %>
			</tbody>
		
		<tfoot>
			<tr>
				<td colspan="5" align="right">
					<a href="EventBoardWrite.jsp">
						<input type="button" value="글쓰기">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
	
	<!-- 페이지 네비게이터 -->
	<div class="row center pagination">
		
	</div>
	
	<!-- 검색창 -->
	<div class="row center">
	
		<form action="event_list.jsp" method="get">
			<!-- 검색분류 -->
			<select class="form-input form-inline" name="type">
				<option value="event_title">제목만</option>
				<option value="member_id">글작성자</option>
			</select>
			
			<!-- 검색어 -->
			<input class="form-input form-inline" type="text" name="keyword" required>
			 
			<!-- 전송버튼 -->
			<input class="form-btn form-inline" type="submit" value="검색">
		</form>
		
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>