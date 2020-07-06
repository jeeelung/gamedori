<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	파라미터로 전달되는 경우 : 변조가 가능하므로 위험한 방식
// 	String member_id = request.getParameter("member_id");

//	세션으로 전달되는 경우 : 변조가 불가능하지만 세션 용량을 고려하여 바로 삭제해야 한다는 주의사항이 있다
	String member_id = (String)session.getAttribute("member_id");
	session.removeAttribute("member_id");
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h3>검색된 아이디는 <%=member_id%> 입니다</h3>
	
	<!-- 이 다음에 할 것으로 예상되는 작업에 대한 링크를 제공 -->
	<h5><a href="login.jsp">로그인 하러가기</a></h5>
	<h5><a href="find_pw.jsp">비밀번호가 기억나지 않아요</a></h5>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>