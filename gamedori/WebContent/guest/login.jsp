<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>로그인</h2>
	
	<form action="login.do" method="post">
		<table border="0">
			<tbody>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" required>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_pw" required>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="2">
						<input type="submit" value="Login">
					</td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<a href="find_id.jsp">아이디가 기억나지 않습니다</a>
						<br>
						<a href="find_pw.jsp">비밀번호가 기억나지 않습니다</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>	
	
	<%if(request.getParameter("error") != null){%>
		<!-- 오류 메시지는 페이지에 error라는 파라미터가 있을 경우만 출력 -->
		<h6><font color="#FF0000">입력하신 로그인 정보가 맞지 않습니다</font></h6>
	<%} %>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
