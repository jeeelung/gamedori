<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #20639B;
}
.wrap {
	border-top: 3px solid #20639B;
	border-bottom : 3px solid #20639B;
}
.today-wrap {
	border-top: 3px solid #20639B;
	border-bottom : 3px solid #20639B;
	position : relative;
}
.table{
	
}
.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #20639B;
	/* 테두리 병합 */
	border-collapse: collapse;
}
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td,
        .table.table-border > tbody > tr > th,
        .table.table-border > tbody > tr > td,
        .table.table-border > tfoot > tr > th,
        .table.table-border > tfoot > tr > td {
            /* 칸에 테두리를 부여 */
            border:2px solid #20639B;
   				color:dodgerblue;
        }
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td > a,
        .table.table-border > tbody > tr > th > a,
        .table.table-border > tbody > tr > td > a,
        .table.table-border > tfoot > tr > th > a,
        .table.table-border > tfoot > tr > td > a{
            text-decoration : none;
             color:dodgerblue;
        }
select{
border: 2px solid dodgerblue;
}

textarea{
display:incline-block;
postion : absolute;
align:left;
resize:none;
width:100%;
height: 478px;
border-width:0px;
}
textarea:focus{
border-width:0px;
}

</style>
<div>
<article>
<div class="font-game">
	<h3>FAQ 작성</h3>
</div>
<div class="row today-wrap"><div class="row-empty"></div>
</article>

	<!-- 게시글 전송 폼 -->
	<form action="write.do" method="post" enctype="multipart/form-data">
		<table class="table table-border" width= "80%">
			<thead>
				<tr>
				<th>말머리</th>
					<td class="left">
						<!-- 말머리는 select로 구현 --> 
						<select name="faq_head" class="faq_head">
							<option value="">말머리 선택</option>
							<option value="회원문의">회원문의</option>
							<option value="게임문의">게임문의</option>
					</select>
					</td>
				</tr>
			</thead>
			<tbody text-align="left" align="top">
				<tr>
					<th width="10%">제목</th>
					<td class="left">
						<!-- 제목은 일반 입력창으로 구현 --> 
						<input  type="text" name="faq_title" maxlength="100" size="70" required>
					</td>
				</tr>
			<tr height="500px">
			<th width="10%">내용</th>
				<td margin="0px" padding="0px">
					<!-- 내용은 textarea로 구현 -->
					<textarea rows="20" cols="100" maxlength="4000" name="faq_content" required></textarea>
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
					<td colspan="2">
						<input class="form-btn form-inline" type="submit" value="작성완료">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>