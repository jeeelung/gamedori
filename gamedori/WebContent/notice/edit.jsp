<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
	NoticeDao ndao = new NoticeDao();
	NoticeDto ndto = ndao.get(notice_no);
	
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>공지사항 게시글 수정</h2>

	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden"name="notice_no"value="<%=notice_no%>">

		<table border="1">
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="notice_title"size="70" required
						value="<%=ndto.getNotice_title()%>">
						
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 --> 
						<textarea name="notice_content" required
							rows="15" cols="72"></textarea>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="작성">
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</div>


<jsp:include page="/template/footer.jsp"></jsp:include>