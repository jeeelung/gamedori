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
	<style>
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #20639B;
}
.wrap {
	border-top: 3px solid #20639B;
	border-bottom : 3px solid #20639B;
}
.today-wrap {
	border-top: 3px solid #20639B;
	border-bottom : 3px solid #20639B;
	position : relative;
}
.table{
	width: auto;
}
.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #20639B;
	/* 테두리 병합 */
	border-collapse: collapse;
}
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td,
        .table.table-border > tbody > tr > th,
        .table.table-border > tbody > tr > td,
        .table.table-border > tfoot > tr > th,
        .table.table-border > tfoot > tr > td {
            /* 칸에 테두리를 부여 */
            border:2px solid #20639B;
             color:black;         
        }
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td > a,
        .table.table-border > tbody > tr > th > a,
        .table.table-border > tbody > tr > td > a,
        .table.table-border > tfoot > tr > th > a,
        .table.table-border > tfoot > tr > td > a{
            text-decoration : none;
             color:black;
        }
</style>
<script>
function checked(){
	var idtext = document.getElementById("ide");
    //아이디의 id값
    var patext = document.getElementById("pass");
    //비밀번호의 id값
    var cpatext = document.getElementById("cpass");
   //비밀번호확인의 id값
    var nametext = document.getElementById("name");
    var phonetext = 
}
</script>
<article>
<div class="font-game">
	<h3>회원가입</h3>
</div>
	<div class="row today-wrap"><div class="row-empty"></div></div>
</article>
	<form action="join.do" method="post">
		<table class="table table-border left">
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
						<input type="text" name="member_id" required placeholder="5~20자 영문 또는 숫자 ※아이디 중복 불가" maxlength="20">
						<%if(request.getParameter("errorID")!=null) {%>
							<span><font color="#FF0000">이미 아이디가 사용 중 입니다.</font></span>
						<%} %>
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
						<input type="text" name="member_nick" required placeholder="한글 8자 이내 ※닉네임 중복 불가" maxlength="24">
						<%if(request.getParameter("errorNick")!=null) {%>
							<span><font color="#FF0000">이미 닉네임이 사용 중 입니다.</span></h6>
						<%}%>
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
						<input class="form-btn form-inline" type="submit" value="가입">
					</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>