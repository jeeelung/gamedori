<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	write.jsp : 게시글 작성 페이지
	- 입력 항목은 3개 : board_head, board_title, board_content
	- 작성자는 회원정보가 자동으로 설정
	
	- 첨부파일을 추가할 수 있도록 구현(이미지만 허용)
 -->
 <%
 		MemberDto mdto=(MemberDto)session.getAttribute("userinfo");
 		boolean isAdmin = mdto.getMember_auth().equals("관리자");
 %>
<jsp:include page="/template/header.jsp"></jsp:include>

	
		<div align="center">
	<h2>문의글 작성</h2>
	
	<!-- 게시글 전송 폼 -->

	<form action="write.do" method="post" enctype="multipart/form-data">
		<table align="center" border="1">
						<%if(request.getParameter("qna_super_no") != null) {%>
						<input type="hidden" name="qna_super_no" value="<%=request.getParameter("qna_super_no")%>">
						<%}%>
						<input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
	

		
		<thead>

				<tr>
					<th>말머리</th>
					<td>
						<!-- 말머리는 select로 구현 -->
						<select name="qna_head">
							<option value="">말머리 선택</option>
							<option value="회원">회원</option>
							<option value="게임">게임</option>
							<option value="포인트">포인트</option>
						</select>
					</td>
				</tr>

				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="qna_title" size="70" required>
					</td>
				</tr>
				<tr>
					</thead>
					<tbody>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="qna_content" required rows="15" cols="72"></textarea>
					</td>  
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="qna_email" size="70" required>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="qna_file" multiple accept=".jpg, .png, .gif">
					</td>
				</tr>
				
				<%if(isAdmin){ %>
				<tr>
					<th>답변</th>
					<td>
						<input type="text" name="qna_answer" size="70" required>
					</td>
				</tr>

				<%}else{ %>
							
				<%} %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="문의하기">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
