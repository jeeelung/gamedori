<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 	info.jsp 
	1.세션의 정보 조회
	2.데이터베이스에서 정보 조회
	3.조회된 정보를 출력
-->
<%
//세션에서 userinfo를 읽어온다
	MemberDto mdto=(MemberDto)session.getAttribute("userinfo");

//session에 들어있는 정보는 최신 정보가 아니므로 DB에서 다시 조회한 다음 출력하는것으로 변경!
	int member_no=mdto.getMember_no();
	MemberDao mdao=new MemberDao();
	MemberDto user=mdao.get(member_no);//member_id(P.K)를 이용한 단일조회 수행


%>



<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">

	<h2>내정보</h2>

	<table border="1" width="500">

		<tbody>
		<tr>
				<th>이름</th>
				<td><%=user.getMember_name() %></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><%=user.getMember_id() %></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td><%=user.getMember_nick() %></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=user.getMember_phone() %></td>
			</tr>
			
			<tr>
				<th>등급</th>
				<td><%=user.getMember_auth() %></td>
			</tr>
	
			<tr>
				<th>포인트</th>
				<td><%=user.getMember_point()%></td>
			</tr>
		</tbody>
	</table>
	
	<h5><a href="logout.do">로그 아웃</a></h5>
	
<!-- 	check.jsp 로 보낼 때에는 최종 목적지를 go 라는 이름의 파라미터로 추가해야 한다 -->
	
<!-- 	아래의 링크는 비밀번호 확인 페이지로 가지만 최종 목적지는 change_password.jsp라는 뜻의 링크이다 -->
	<h5><a href="check.jsp?go=change_password.jsp">비밀번호 변경하기</a></h5>
	
<!-- 	아래의 링크는 비밀번호 확인 페이지로 가지만 최종 목적지는 change_info.jsp라는 뜻의 링크이다 -->
	<h5><a href="check.jsp?go=change_info.jsp">개인정보 변경하기</a></h5>
<!-- 	아래의 링크는 비밀번호 확인 페이지로 가지만 최종 목적지는 exit.do라는 뜻의 링크이다 -->
	<h5><a href="check.jsp?go=exit.do">회원 탈퇴</a></h5>
	

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>