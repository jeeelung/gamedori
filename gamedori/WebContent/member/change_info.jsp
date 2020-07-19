<%@page import="gamedori.beans.dto.GenreDto"%>
<%@page import="gamedori.beans.dao.GenreDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.MemberFavoriteDao"%>
<%@page import="gamedori.beans.dto.MemberFavoriteDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session 에서 userinfo 데이터를 불러온다!
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo"); //down-casting
	
	// session 에 들어있는 정보는 최신 정보가 아니므로 DB에서 다시 조회한 다음 출력하는 것으로 변경!
	String member_id = mdto.getMember_id();
	MemberDao mdao = new MemberDao();
	MemberDto user = mdao.get(member_id); // member_id(P.K)를 이용한 단일 조회 수행
	MemberFavoriteDao mfdao = new MemberFavoriteDao();
	
	List<Map<String,Object>> fList = mfdao.getList(mdto.getMember_no());
%>
 <style>
        /* 입력창 관련 스타일 */
        .form-input {
            border: 1px solid black;
        }

        .form-input.correct {
            border: 1px solid blue;
        }

        .form-input.incorrect {
            border: 1px solid red;
        }

        .correct-message {
            color: blue;
        }

        .incorrect-message {
            color: red;
        }

        /* 메시지 관련 스타일 */
        .correct-message,
        .incorrect-message {
            display: none;
        }

        .form-input.correct~.correct-message {
            display: block;
        }

        .form-input.incorrect~.incorrect-message {
            display: block;
        }

    </style>
    <script>
        //아이디를 검사하는 함수 : 반드시 true 또는 false를 반환해야 checkForm에서 사용이 가능하다
        //- true를 반환하는 경우는 아이디가 적합한 형식이라는 의미
        //- false를 반환하는 경우는 아이디가 적합하지 않은 형식이라는 의미

        //정규표현식에는 flag를 부여할 수 있다.
        // - g(global) : 1회성 검사가 아닌 지속적인 전체 검사를 수행
        // - i(ignorecase) : 대/소문자 구분 없이 검사
        // - m(multiline) : 매 줄마다 형식 검사를 수행
      
        //isValid의 결과에 따라서 입력창에 correct / incorrect 클래스를 추가
        //비밀번호를 검사하는 함수 : 반드시 true 또는 false를 반환해야 checkForm에서 사용이 가능하다
        function checkPw() {
            var regex = /[a-zA-Z0-9]{8,16}/g;
            var pw = document.getElementById("pw").value;
            return regex.test(pw);
        }
        function checkCheckPw(){
            var pw = document.getElementById("pw").value;
            var checkPw = document.getElementById("checkPw").value;

        	return pw === checkPw;
        }
        function checkNick(){
            var regexNick =/^[가-힣]{1,8}$/g;
            var nick = document.getElementById("nick").value;
            return regexNick.test(nick);
        }
function checkPhone(){
     var regexPhone =/^[0-9]{1,11}$/g;
	 var phone = document.getElementById("phone").value;
	 return regexPhone.test(phone);
}

        //폼 전송 여부를 판정하는 함수
function checkForm() {
	var pwIsValid = checkPw();
    var nickIsValid = checkNick();
    var phoneIsValid = checkPhone();
    var checkPwIsValid = checkCheckPw();
    //아이디가 맞는 경우는 전송될테니까 추가적인 작업이 필요하지 않지만 틀린 경우는 처리를 해야한다.
    var pwTag = document.getElementById("pw");
    var nickTag = document.getElementById("nick");
 	var phoneTag = document.getElementById("phone");
 	var checkPwTag = document.getElementById("checkPw"); 
    //뭐가 붙어있을지 모르니 둘 다 삭제
    pwTag.classList.remove("correct");
    pwTag.classList.remove("incorrect");
    nickTag.classList.remove("correct");
    nickTag.classList.remove("incorrect");
    phoneTag.classList.remove("correct");
    phoneTag.classList.remove("incorrect");
    checkPwTag.classList.remove("correct");
    checkPwTag.classList.remove("incorrect");
    if (pwIsValid == false) {
        pwTag.classList.add("incorrect");
    } else{
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
	if(checkPwIsValid==false){
	    checkPwTag.classList.add("incorrect");
	}else{
	    checkPwTag.classList.add("correct");
	}

    if(!pwIsValid || !nickIsValid || !phoneIsValid || !checkPwIsValid){
        return false;
    }else{
        return true;
    }
}

    </script>
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>정보 수정</h2>
	
	<form action="change_info.do" method="post" onsubmit="return checkForm();">
		<table width="400">
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
					<input type="password" class="form-input" name="member_pw" 
					placeholder="비밀번호" id="pw">
					<span class="correct-message">올바른 비밀번호 형식입니다</span>
            		<span class="incorrect-message">비밀번호는 영문대/소문자와 숫자로 8~16자 내외로 구성하세요</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
					 <input type="password"class="form-input" id ="checkPw" maxlength="16">
						<span class="correct-message">비밀번호가 일치합니다.</span>
            			<span class="incorrect-message">비밀번호가 불일치합니다.</span>
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" class="form-input" name="member_nick" id="nick"
						 required placeholder="8자 내외의 한글로 입력하세요" maxlength="11" value="<%=user.getMember_nick()%>">
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
					    <input type="text" class="form-input" name="member_phone"
					    id="phone" required placeholder="- 제외  11자 내외의 숫자 입력" maxlength="11"value="<%=user.getMember_phone()%>">
					    <span class="correct-message">올바른 전화번호 형식입니다</span>
            			<span class="incorrect-message">전화번호는 숫자로 11자 내외로 구성하세요</span>
					</td>
				</tr>
				<tr>
					<th>관심 분야</th>
					<td>
					<%for( Map<String,Object> g :fList){%>
						<input type="checkbox" name="member_favorite"
						<%if((Integer)g.get("member_favorite_no") != 0){ %>checked<%} %>
						id="mf<%=g.get("genre_no") %>" value="<%=g.get("genre_no") %>">						
						<label for="mf<%=g.get("genre_no")%>"><%=g.get("genre_type")%></label>
					<%} %>	
					</td>	
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="2">
						<input type="hidden" name="member_no" value="<%=user.getMember_no() %>">
						<input type="submit" value="변경">
					</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>