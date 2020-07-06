<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	check.jsp : 비밀번호 검사를 위한 "공통모듈" 페이지
	(주의) 목적지 정보가 반드시 필요하며 파라미터 이름은 go로 처리한다 
-->
<%
	String go = request.getParameter("go");
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>비밀번호 확인</h2>
	
	<form action="check.do" method="post">
		<!-- input type이 hidden 인 경우 화면에는 표시되지 않으면서 데이터 첨부를 수행할 수 있다 -->
		<input type="hidden" name="go" value="<%=go%>">
		<input type="password" name="member_pw" required>
		<input type="submit" value="확인">
	</form>	
	
	<%if(request.getParameter("error") != null){ %>
	<!-- 비밀번호가 틀린 상황이라면 error라는 파라미터가 있을 테니 오류 메시지를 출력한다 -->
		<h6><font color="red">비밀번호가 일치하지 않습니다</font></h6>
	<%} %>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>