<%@page import="gamedori.beans.dto.EventboardDto"%>

<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	
-->
<%
	int event_no = Integer.parseInt(request.getParameter("event_no"));
	EventboardDao edao = new EventboardDao();
	EventboardDto edto = edao.get(event_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>게시글 수정</h2>
	
	<!-- 게시글 전송 폼 -->
	<form action="Eventedit.do" method="post">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden" name="event_no" value="<%=event_no%>">
		
		<table border="1">
			<tbody>
				<tr>
					<th>제목</th>
					<td>
					
						<input type="text" name="event_title" size="70" required
								value="<%=edto.getEvent_title()%>">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						
						<textarea name="event_content" required 
							rows="15" cols="72"><%=edto.getEvent_content()%></textarea>
					</td>  
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
