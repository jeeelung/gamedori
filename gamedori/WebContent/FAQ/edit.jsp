<%@page import="home.beans.dto.BoardDto"%>
<%@page import="home.beans.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	edit.jsp : 게시글 수정 페이지
	- 구조는 write.jsp와 동일하지만 차이가 있다면 글 정보가 미리 표시되어 있어야 한다
	- 정보를 표시해줘야 하기 때문에 PK(board_no)가 필요하다
-->
<%
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	CommuDao bdao = new CommuDao();
	BoardDto bdto = bdao.get(board_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>게시글 수정</h2>
	
	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden" name="board_no" value="<%=board_no%>">
		
		<table border="1">
			<tbody>
				<tr>
					<th>말머리</th>
					<td>
						<!-- 말머리는 select로 구현 -->
						<select name="board_head">
							<option value="">말머리 선택</option>
							<option value="정보">정보</option>
							<option value="공지">공지</option>
							<option value="유머">유머</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="board_title" size="70" required
								value="<%=bdto.getBoard_title()%>">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="board_content" required 
							rows="15" cols="72"><%=bdto.getBoard_content()%></textarea>
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












