<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">

	<h2>게시글 작성</h2>

	<!-- 게시글 전송 폼 -->
	<form action="write.do" method="post" enctype="multipart/form-data">
		<table align="center">
			<thead>
				<tr>
					<td>
					<th>말머리</th>
					<td>
						<!-- 말머리는 select로 구현 --> <select name="faq_head">
							<option value="말머리 선택">말머리 선택</option>
							<option value="회원문의">회원문의</option>
							<option value="게임문의">게임문의</option>
					</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 --> <input type="text" name="faq_title" maxlength="100" size="70" required>
					</td>
				</tr>
			</thead>
			<tr>
				<th>내용</th>
				<td>
					<!-- 내용은 textarea로 구현 --> <textarea rows="20" cols="100" maxlength="4000" name="faq_content" required></textarea>
				</td>
			</tr>

			<!-- 첨부파일 -->
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="faq_file" multiple accept=".jpg, .png, .gif"></td>
			</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="2" align="center">
					<input type="button" value="임시저장">
					<input type="button" value="미리보기">
					<input type="submit" value="확인">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>




