<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/base.css">
<style>
.div {
	font-family: arcadeclassic;
}

.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #a49ec2;
}

.wrap {
	border-top: 3px solid #a49ec2;;
	border-bottom: 3px solid #a49ec2;;
}

.today-wrap {
	border-top: 3px solid #a49ec2;
	border-bottom: 3px solid #a49ec2;
	position: relative;
}

.table {
	
}

.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #a49ec2;
	/* 테두리 병합 */
	border-collapse: collapse;
}

.table.table-border>thead>tr>th, .table.table-border>thead>tr>td, .table.table-border>tbody>tr>th,
	.table.table-border>tbody>tr>td, .table.table-border>tfoot>tr>th,
	.table.table-border>tfoot>tr>td {
	/* 칸에 테두리를 부여 */
	border: 1px solid #a49ec2 !important;
	color: #a49ec2;
}

.table.table-border>thead>tr>th, .table.table-border>thead>tr>td>a,
	.table.table-border>tbody>tr>th>a, .table.table-border>tbody>tr>td>a,
	.table.table-border>tfoot>tr>th>a, .table.table-border>tfoot>tr>td>a {
	text-decoration: none;
	color: #a49ec2;
}

.pagination a {
	color: gray;
	text-decoration: none;
	display: inline-block;
	padding: 0.5rem;
	min-width: 2.5rem;
	text-align: center;
	border: 1px solid transparent;
}

.pagination a:hover, /*마우스 올라감*/ .pagination .on { /*활성화 */
	border: 1px solid gray;
	color: black;
}

.font-header {
	font-family: arcadeclassic;
	font-size: 35px;
	color: #a49ec2;
}

.font-header2 {
	font-family: arcadeclassic;
	font-size: 20px;
	color: white;
}

.font_han {
	font-family: DungGeunMo;
	width: "30%";
}

.invisible {
	clear: none;
	border: 0px none;
	float: none;
	background-color: transparent;
}
</style>
<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">

	<h3 class="font-game">W r i t e　W h a t e v e r　Y o u　W a n t</h3>

	<form action="write.do" method="post" enctype="multipart/form-data">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<%
						if (request.getParameter("commu_super_no") != null) {
					%>
					<input type="hidden" name="commu_super_no"
						value="<%=request.getParameter("commu_super_no")%>">
					<%
						}
					%>
					<input type="hidden" name="member_no"
						value="<%=mdto.getMember_no()%>">

				</tr>
				<tr>
					<th>말머리</th>
					<td style="text-align: left;"><Select margin-right="900"
						name="commu_head">
							<option value="">말머리 선택</option>
							<option value="자유">자유</option>
							<option value="공략">공략</option>
							<option value="유머">유머</option>
					</Select></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input class="invisible" type="text" name="commu_title"
						size="152" required></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>내용</th>
					<td align="left" valign="top"><textarea class="invisible"
							rows="15" cols="135" name="commu_content" required></textarea></td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="commu_file" multiple
						accept=".jpg,.png,.gif"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="2"><input class="form-btn form-inline4"
						type="button" value="임시저장"> <input
						class="form-btn form-inline4" type="button" value="미리보기">
						<input class="form-btn form-inline4" type="submit" value="등록">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>