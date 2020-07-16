<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>비밀번호 변경이 완료되었습니다.</h2>
	
	<h4><a href="#">내정보 보기</a></h4>

	<h4><a href="<%=request.getContextPath()%>/index.jsp">홈으로 이동</a></h4>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>