<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 
	write.jsp : 게시글 작성 페이지
	- 입력 항목은 2개 : notice_title, notice_content
	- 작성자는 회원정보가 자동으로 설정
 -->
 
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>공지사항 작성</h2>
	
	<!-- 게시글 전송 폼 -->
	<form action="write.do" method="post">
		
		<table border="1">
			<tbody>
				
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="notice_title" size="70" required>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="notice_content" required rows="15" cols="72"></textarea>
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
