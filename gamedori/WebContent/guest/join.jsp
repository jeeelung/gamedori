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
 .form-input {
            border:1px solid black;
        }
        .form-input.correct {
            border:1px solid blue;
        }
        .form-input.incorrect{
            border: 1px solid red;
        }
         .correct-message {
            color:blue;
        }
        .incorrect-message{
            color:red;
        }
        /* 메시지 관련 스타일 */
        .correct-message, .incorrect-message{
            display: none;
        }
        .form-input.correct ~ .correct-message {
            display:block;
        }
        .form-input.incorrect ~ .incorrect-message {
            display: block;
        }
</style>
<script language="javascript">
function checkName(){
	var regexName = /^[가-힣]{2,8}$/g;
	var name = document.getElementById("name").value;
	return regex.test(name);
}
function checkId(){
	 var regexId = /^[a-zA-Z0-9]{5,20}$/g;
	 var id = document.getElementById("id").value;
	 return regex.test(id);
}
function checkPw(){
	var regexPw = /^[a-zA-Z0-9]{8,16}$/g;
	var pw = document.getElementById("pw").value;
	return regex.test(pw);
}
function checkNick(){
	var regexNick =/^[가-힣]{1,8}$/g;
	var nick = document.getElementById("nick").value;
	return regex.test(nick);
}
function checkPhone(){
	var regexPhone =/^[0-9]{1,11}$/g;
	 var phone = document.getElementById("phone").value;
	 return regex.test(phone);
}
function checkCheckpw(){
	var pw = document.getElementById("pw");
	var checkpw = document.getElementById("checkpw");
	return pw.value.slice(0,pw.value.length)===checkpw.value.slice(0, checkpw.value.length);    
}
function checked(){
        var nameIsValid = checkName();
        var idIsValid = checkId();
        var pwIsValid = checkPw();
        var nickIsValid = checkNick();
        var phoneIsValid = checkPhone();
        var pwcheckIsValid = checkCheckPw();
        //아이디가 맞는 경우는 전송될테니까 추가적인 작업이 필요하지 않지만 틀린 경우는 처리를 해야한다.
         var nameTag = document.getElementById("name");
         var idTag = document.getElementById("id");
         var pwTag = document.getElementById("pw");
         var nickTag = document.getElementById("nick");
         var phoneTag = document.getElementById("phone");
         var checkpwTag = document.getElementById("chekcpw")
        //뭐가 붙어있을지 모르니 둘 다 삭제
        nameTag.classList.remove("correct");
        nameTag.classList.remove("incorrect");
        idTag.classList.remove("correct");
        idTag.classList.remove("incorrect");
        pwTag.classList.remove("correct");
        pwTag.classList.remove("incorrect");
        nickTag.classList.remove("correct");
        nickTag.classList.remove("incorrect");
        phoneTag.classList.remove("correct");
        phoneTag.classList.remove("incorrect");
        checkpwTag.classList.remove("correct");
        checkpwTag.classList.remove("incorrect");
        if(nameIsValid==false){
            nameTag.classList.add("incorrect");
        }else{
            nameTag.classList.add("correct");
        }
        if(idIsValid==false){
            idTag.classList.add("incorrect");
        }else{
            idTag.classList.add("correct");
        }
        if(pwIsValid==false){
            pwTag.classList.add("incorrect");
        }else{
            pwTag.classList.add("correct");
        }
        if(nickIsValid==false){
            nickTag.classList.add("incorrect");
        }else{
            nickTag.classList.add("correct");
        }
        if(phoneIsValid==false){
            phoneTag.classList.add("incorrect");
        }else{
            phoneTag.classList.add("correct");
        }
        if(checkpwIsValid==false){
            checkpwTag.classList.add("incorrect");
        }else{
            checkpwTag.classList.add("correct");
        }
        return nameIsValid && idIsValid && pwIsValid && nickIsValid && phoneIsValid && checkpwIsValid;
    }
</script>
<div align="center">
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
						<span class="correct-message">올바른 이름 형식입니다</span>
            			<span class="incorrect-message">이름은 한글 2~8자로 구성하세요</span> 
					</td>
			</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" id="id" required placeholder="5~20자 영문 또는 숫자 maxlength="20">
						<%if(request.getParameter("errorID")!=null) {%>
							<span><font color="#FF0000">이미 아이디가 사용 중 입니다.</font></span>
						<%} %>
						<span class="correct-message">올바른 아이디 형식입니다</span>
            			<span class="incorrect-message">아이디는 영문소문자와 숫자로 8~20자 내외로 구성하세요</span> 
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_pw" id="pw" placeholder="8~16자 영문 또는 숫자" maxlength="16">
						<span class="correct-message">올바른 비밀번호 형식입니다</span>
            			<span class="incorrect-message">비밀번호는 영문대/소문자와 숫자로 8~16자 내외로 구성하세요</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<th>
						<input type="password" id ="checkpw" maxlength="16">
						<span class="correct-message">비밀번호가 일치합니다.</span>
            			<span class="incorrect-message">비밀번호가 불일치합니다.</span>
					</th>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="member_nick" id="nick" required placeholder="한글 8자 이내" maxlength="24">
						<%if(request.getParameter("errorNick")!=null) {%>
							<span><font color="#FF0000">이미 닉네임이 사용 중 입니다.</span></h6>
						<%}%>
						<span class="correct-message">올바른 닉네임 형식입니다</span>
            			<span class="incorrect-message">닉네임는 한글로 8자 내외로 구성하세요</span>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone" id="phone" required placeholder="- 제외" maxlength="11">
						<span class="correct-message">올바른 전화번호 형식입니다</span>
            			<span class="incorrect-message">전화번호는 010으로 시작하는 숫자로 11자 내외로 구성하세요</span>
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