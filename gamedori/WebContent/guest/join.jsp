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
	 var regexName = /^[가-힣]{2,8}$/;
	 var regexId = /^[a-zA-Z0-9]{5,20}$/;
	 var regexPw = /^[a-zA-Z0-9]{8,16}$/;
	 var regexNick =/^[가-힣]{1,8}$/;
	 var regexPhone =/^[0-9]{,11}$/;
    var name = document.getElementById("name");
	var id = document.getElementById("id");
    var pw = document.getElementById("pw");
    var checkpw = document.getElementById("checkpw");
    var nick = document.getElementById("nick");
    var phone = document.getElementById("phone");
    if(!regexName.test(name.value)) {
        alert("이름은 한글 2글자 이상 8글자 이하로 입력해 주세요");
        name.value="";
        name.focus();
    	return false;
    }
    else if(!regexId.test(id.value)) {
        alert("아이디는 5~20자의 영문 대소문자와 숫자만 입력하세요");
        id.value="";
        id.focus();
    	return false;
    }

    else if(!regexPw.test(pw.value)) {
        alert("패스워드는 8~16자의 영문 대소문자와 숫자로만 입력");
        pw.value="";
        pw.focus();
    	return false;
    }

    else if(!(pw.value.slice(0,pw.value.length)===checkpw.value.slice(0, checkpw.value.length))) {
        alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
        join.checkpw.value = "";
        join.checkpw.focus();
        return false;
    }
    else if(!regexNick.test(nick.value)){
    	alert("닉네임은 한글 8자 이내로 입력해 주세요");
    	nick.value="";
    	nick.focus="";
    	return false;
    }
    else if(!regexPhone.test(phone.value)){
    	alert("숫자만 입력해 주세요");
    	phone.value="";
    	phone.focus="";
    	return false;
    }
    else{
    alert("회원가입이 완료되었습니다.");
    return true;
    }
}
</script>
<article>
<div class="font-game">
	<h3>회원가입</h3>
</div>
	<div class="row today-wrap"><div class="row-empty"></div></div>
</article>
	<form action="join.do" method="post" name="join" onsubmit="return checked();">
		<table class="table table-border left">
			<tbody>
			<tr>
				<th>이름</th>
					<td>
						<input type="text" name="member_name" id="name" required placeholder="2~8자의 한글을 입력해주세요" maxlength="20">
					</td>
			</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" id="id" required placeholder="5~20자 영문 또는 숫자 ※아이디 중복 불가" maxlength="20">
						<%if(request.getParameter("errorID")!=null) {%>
							<span><font color="#FF0000">이미 아이디가 사용 중 입니다.</font></span>
						<%} %>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_pw" id="pw" placeholder="8~16자 영문 또는 숫자" maxlength="16">
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<th>
						<input type="password" id ="checkpw" maxlengh="16">
					</th>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="member_nick" id="nick" required placeholder="한글 8자 이내 ※닉네임 중복 불가" maxlength="24">
						<%if(request.getParameter("errorNick")!=null) {%>
							<span><font color="#FF0000">이미 닉네임이 사용 중 입니다.</span></h6>
						<%}%>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone" id="phone" required placeholder="- 제외" maxlength="11">
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