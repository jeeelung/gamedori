<%@page import="gamedori.beans.dto.QnaDto"%>
<%@page import="gamedori.beans.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	edit.jsp : 게시글 수정 페이지
	- 구조는 write.jsp와 동일하지만 차이가 있다면 글 정보가 미리 표시되어 있어야 한다
	- 정보를 표시해줘야 하기 때문에 PK(board_no)가 필요하다
-->

<%
	int qna_no = Integer.parseInt(request.getParameter("qna_no"));
	QnaDao qdao = new QnaDao();
	QnaDto qdto = qdao.get(qna_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>게시글 수정</h2>
	
	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden" name="qna_no" value="<%=qna_no%>">
		
		<table border="1">
			<tbody>
				<tr>
					<th>말머리</th>
					<td>
						<!-- 말머리는 select로 구현 -->
						<select name="qna_head">
							<option value="">말머리</option>
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
						<input type="text" name="qna_title" size="70" required
								value="<%=qdto.getQna_title()%>">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="qna_content" required 
							rows="15" cols="72"><%=qdto.getQna_content()%></textarea>
					</td>  
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="qna_email" size="70" required
								value="<%=qdto.getQna_email()%>">
					</td>
				</tr>
					<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="qna_file" multiple accept=".jpg,.png,.gif">
					</td>
				</tr>
				<tr>
					<th>답변</th>
					<td>
						<textarea name="qna_answer" required 
							rows="15" cols="72"><%=qdto.getQna_answer()%></textarea>
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