<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gamedori.beans.dto.GenreDto"%>
<%@page import="gamedori.beans.dao.GenreDao"%>
<%@page import="java.util.List"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	GenreDao genre = new GenreDao();
	List<GenreDto> genreList = genre.getList();
%>
<div align="center">
	
	<h2>회원가입</h2>
	
	<form action="join.do">
		<table border="0">
			<tbody>
			<tr>
				<th>이름</th>
					<td>
						<input type="text" name="member_name" required placeholder="5~20자 영문 또는 숫자" maxlength="20">
					</td>
			</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" required placeholder="5~20자 영문 또는 숫자" maxlength="20">
						<input type="button" value="중복 확인" onclick="openIdChk()">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_pw" required placeholder="8~16자 영문 또는 숫자" maxlength="16">
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="member_nick" required placeholder="한글 8자 이내" maxlength="24">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone" required placeholder="- 제외" maxlength="11">
					</td>
				</tr>
				<tr>
					<th>관심 분야</th>
					<td>
					<%for( GenreDto g :genreList){%>
						<input type="checkbox" name="member_favorite" id="mf<%=g.getGenre_no() %>" value="<%=g.getGenre_no() %>">						
						<label for="mf<%=g.getGenre_no()%>"><%=g.getGenre_type()%></label>
					<%} %>	
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
	<%if(request.getParameter("error")!=null) {%>
		<h6><font color="#FF0000">가입 정보 중에 이미 사용된 정보가 있습니다.</font></h6>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>