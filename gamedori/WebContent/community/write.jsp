<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo");
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form action="write.do" method="post" enctype="multipart/form-data">
		<table align="center">
			<thead>
				<tr>
					<td>
						<%if(request.getParameter("commu_super_no") != null) {%>
						<input type="hidden" name="commu_super_no" value="<%=request.getParameter("commu_super_no")%>">
						<%}%>
						<input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
					</td>
				</tr>
				<tr>
					<th>말머리</th>
					<td>
						<Select name="commu_head">
							<option value="">말머리 선택</option>
							<option>자유</option>
							<option>공략</option>
							<option>유머</option>
						</Select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input  type="text" name="commu_title" maxlength="100" size="50" required>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>내용</th>
					<td align="left" valign="top">
						<textarea rows="20" cols="100" maxlength="4000" name="commu_content" required></textarea>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="commu_file" multiple accept=".jpg,.png,.gif">
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center" >
					<td colspan="2">
						<input type="button" value="임시저장">
						<input type="button" value="미리보기">
						<input type="submit" value="등록">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>