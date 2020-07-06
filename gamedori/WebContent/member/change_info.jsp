<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session 에서 userinfo 데이터를 불러온다!
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo"); //down-casting
	
	// session 에 들어있는 정보는 최신 정보가 아니므로 DB에서 다시 조회한 다음 출력하는 것으로 변경!
	String member_id = mdto.getMember_id();
	MemberDao mdao = new MemberDao();
	MemberDto user = mdao.get(member_id); // member_id(P.K)를 이용한 단일 조회 수행
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>정보 수정</h2>
	
	<form action="change_info.do">
		<table border="0">
			<tbody>
			<tr>
				<th>이름</th>
					<td>
						<%=user.getMember_name()%>
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<%=user.getMember_id()%>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_pw" required placeholder="8~16자 영문 또는 숫자"
						value="<%=user.getMember_pw()%>">
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="member_nick" required placeholder="한글 8자 이내"
						value="<%=user.getMember_nick()%>">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone" required placeholder="- 제외"
						value="<%=user.getMember_phone()%>">
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="2">
						<input type="submit" value="가입">
					</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>