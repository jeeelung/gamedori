<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	write.jsp : 게시글 작성 페이지
	- 입력 항목은 3개 : board_head, board_title, board_content
	- 작성자는 회원정보가 자동으로 설정
	
	- 첨부파일을 추가할 수 있도록 구현(이미지만 허용)
 -->
 
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>게시글 작성</h2>
	
	<!-- 게시글 전송 폼 -->
	<form action="write.do" method="post" enctype="multipart/form-data">
	
		<%if(request.getParameter("board_no") != null){ %>
		<!-- 원본글번호가 넘어온다면(즉, 답글이라면) 원본글번호를 hidden으로 첨부 -->
		<input type="hidden" name="board_no" 
						value="<%=request.getParameter("board_no")%>">
		<%} %>
		
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
						<input type="text" name="board_title" size="70" required>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="board_content" required rows="15" cols="72"></textarea>
					</td>  
				</tr>
				
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="board_file" multiple accept=".jpg, .png, .gif">
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="작성">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>




