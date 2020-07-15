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
 /* 입력창 관련 스타일 */
        .form-input {
            border:1px solid black;
        }
        .form-input.correct {
            border:1px solid blue;
        }
        .form-input.incorrect {
            border: 1px solid red;
        }
        
        /* 메시지 관련 스타일 */
        .correct-message {
            color:blue;
        }
        .incorrect-message{
            color:red;
        }
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

<script>
function checkId(){
    var regex = /[a-z0-9]{8,20}/g;
    var id = document.querySelector("input[name=id]").value;
    
    var isValid = regex.test(id);
            
    return isValid;//판정 결과를 반환
}
//isValid의 결과에 따라서 입력창에 correct / incorrect 클래스를 추가
function processId(isValid){
    var idTag = document.querySelector("input[name=id]");
    
    //뭐가 붙어있을지 모르니 둘 다 삭제
    idTag.classList.remove("correct");
    idTag.classList.remove("incorrect");
    
    //원하는 클래스를 부여
    if(isValid){
        idTag.classList.add("correct");
    }
    else{
        idTag.classList.add("incorrect");
    }
}        
//비밀번호를 검사하는 함수 : 반드시 true 또는 false를 반환해야 checkForm에서 사용이 가능하다
function checkPw(){
    var regex = /[a-zA-Z0-9]{8,16}/g;
    var pw = document.querySelector("input[name=pw]").value;
    return regex.test(pw);
}
function processPw(isValid){
    
}
//폼 전송 여부를 판정하는 함수
function checkForm(){
    var idIsValid = checkId();
    //아이디가 맞는 경우는 전송될테니까 추가적인 작업이 필요하지 않지만 틀린 경우는 처리를 해야한다.
    if(!idIsValid){
        processId(idIsValid);    
    }
    return idIsValid && checkPw();//둘 다 true인 경우만 true반환
}
</script>
<div align="center">

	<h2>회원가입</h2>
	
	<form action="join.do" method="post" onsubmit="return checkForm">
		<table border="0">
			<tbody>
			<tr>
				<th>이름</th>
					<td>
						<input type="text" name="member_name" required placeholder="5~20자 영문 또는 숫자">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="member_id" required placeholder="5~20자 영문 또는 숫자">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_pw" required placeholder="8~16자 영문 또는 숫자">
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="member_nick" required placeholder="한글 8자 이내">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone" required placeholder="- 제외">
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
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>