<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">

	<h2>이벤트 게시글 작성</h2>


	<form action="eventwrite.do" method="post" enctype="multipart/form-data" >

		<table border="1">

			<tr>
				<th>제목</th>
				<td>
					<!-- 제목은 일반 입력창으로 구현 --> <input type="text" name="event_title"
					size="70" required>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<!-- 내용은 textarea로 구현 --> 
					<textarea name="event_content" required
						rows="15" cols="72"></textarea>
				</td>
			</tr>


			<tr>
				<th>첨부파일</th>
				<<td><input type="file" name="event_file" multiple accept=".jpg, .png, .gif">
				</td>
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