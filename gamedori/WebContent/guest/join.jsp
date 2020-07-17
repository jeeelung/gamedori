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
<style>
	    <style>
        body {    
    font-family: 나눔바른고딕, NanumBarunGothic, 맑은고딕, "Malgun Gothic", 돋움, Dotum, "Apple SD Gothic Neo", sans-serif;
    font-size: 12px;
    color: rgb(33, 33, 33);
    letter-spacing: 0.03em;
}

table {
    width: auto;
}

tr {
    height: 50px;
}

input[type=text], input[type=password] {
    padding: 5px 10px; /* 상하 우좌 */
    margin: 3px 0; /* 상하 우좌 */
    font-family: inherit; /* 폰트 상속 */
    border: 1px solid #ccc; /* 999가 약간 더 진한 색 */
    font-size:14pt;
    box-sizing: border-box;
    border-radius: 3px;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -webkit-transition: width 0.4s ease-in-out;
    transition: width 0.4s ease-in-out;
}

input[type=text]:focus, input[type=password]:focus {
    border: 2px solid #555;
}

input[type=submit],input[type=button] {
    margin-top: 10px;
    width:100px;
    height:40px;
    line-height: 22px;
    padding: 5px, 10px; /* 상하 우좌 */
    background: #E6E6E6;
    color: #000000;
    font-size: 15px;
    font-weight: normal;
    letter-spacing: 1px;
    border: none;
    cursor: pointer;
    border-radius: 3px;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
}

input[type=submit]:hover {
    background-color: #FFBF00;
}
        
th{
    font-size: 15px;
    align: left;           
}
    
</style>


<div class="wrap" align="center">
	<div class="header">
	<img src="../image/signup.png">	
	<hr color="726a95" width="400px" size="2">
	</div>
	<form action="join.do">
	<div class="tb td_write">
		<table border="0">
			<tbody>
			<tr>
				<th width="100">이름</th>
					<td>
						<input size="36" type="text" name="member_name" required placeholder="5~20자 영문 또는 숫자" maxlength="20">
					</td>
			</tr>
				<tr>
					
						<th>아이디</th>
				
					<td>
					
						<input size="36" type="text" name="member_id" required placeholder="5~20자 영문 또는 숫자" maxlength="20">		   
        		    
						<input type="button" value="중복 확인" onclick="openIdChk()">
				
					</td>
				</tr>
				<tr>
						<th width="100px">비밀번호</th>
					
					<td>
					
						<input size="36" type="password" name="member_pw" required placeholder="8~16자 영문 또는 숫자" maxlength="16">
					
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
					    <div class="brd">
						<input size="36" type="text" name="member_nick" required placeholder="한글 8자 이내" maxlength="24" class="ipt">
						</div>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>					
						<input size="36" type="text" name="member_phone" required placeholder="- 제외" maxlength="11">
					</td>
				</tr>
				<tr>
					<th>관심 분야</th>
					<td>
					<%for( GenreDto g :genreList){%>
						<input  type="checkbox" name="member_favorite" id="mf<%=g.getGenre_no() %>" value="<%=g.getGenre_no() %>">						
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
		</div>
	</form>
	<%if(request.getParameter("error")!=null) {%>
		<h6><font color="#FF0000">가입 정보 중에 이미 사용된 정보가 있습니다.</font></h6>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>