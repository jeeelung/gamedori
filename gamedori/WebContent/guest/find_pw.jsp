<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>비밀번호 찾기</h2>
	
	<form action="find_pw.do" method="post">
		<table border="0">
			<tbody>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" required>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone" required>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="member_name" required>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td align="center" colspan="2">
						<input type="submit" value="찾기">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	
	
	<!-- error에 대한 처리 -->
	<%if(request.getParameter("error") != null){ %>
	<h6><font color="red">해당하는 정보로 비밀번호를 찾지 못했습니다</font></h6>
	<%} %>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
