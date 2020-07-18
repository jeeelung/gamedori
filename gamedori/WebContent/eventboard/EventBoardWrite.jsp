<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>



td, th{
 width:auto;
 border-radius: 5px;
}

.font_han{
	font-family: DungGeunMo;
	color: #20639B;
}



</style>

<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">

	<h2 class="font-game">To Write The Event Notice</h2>


	<form action="eventwrite.do" method="post" enctype="multipart/form-data" >

		<table border = "1" class=" table.table-hover>tbody>tr:hover" >

			<tr>
				<th class="font_han">제목</th>
				<td>
					<!-- 제목은 일반 입력창으로 구현 --> <input type="text" name="event_title"
					size="78" required>
				</td>
			</tr>
			<tr>
				<th class="font_han">내용</th>
				<td>
					<!-- 내용은 textarea로 구현 --> 
					<textarea name="event_content" required
						rows="15" cols="72"></textarea>
				</td>
			</tr>


			<tr>
				<th class="font_han">첨부파일</th>
				<td>
				<input class="font_file form-inline " type="file" name="event_file" multiple accept=".jpg, .png, .gif">
				</td>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center"><input class="form-btn form-inline" type="submit" value="작성">
					</td>
				</tr>
			</tfoot>

		</table>

	</form>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>