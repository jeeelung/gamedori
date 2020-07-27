<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- change_password.jsp : 비밀번호 변경 입력 페이지 -->

<jsp:include page="/template/header.jsp"></jsp:include>
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

        .form-input.correct ~.correct-message {
            display: block;
        }

        .form-input.incorrect ~.incorrect-message {
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
        //폼 전송 여부를 판정하는 함수
function checkForm() {
	var pwIsValid = checkPw();
    var checkPwIsValid = checkCheckPw();
    //아이디가 맞는 경우는 전송될테니까 추가적인 작업이 필요하지 않지만 틀린 경우는 처리를 해야한다.
    var pwTag = document.getElementById("pw");
 	var checkPwTag = document.getElementById("checkPw"); 
    //뭐가 붙어있을지 모르니 둘 다 삭제
    pwTag.classList.remove("correct");
    pwTag.classList.remove("incorrect");
    checkPwTag.classList.remove("correct");
    checkPwTag.classList.remove("incorrect");
    if (pwIsValid == false) {
        pwTag.classList.add("incorrect");
    } else{
        pwTag.classList.add("correct");
    }
	if(checkPwIsValid==false){
	    checkPwTag.classList.add("incorrect");
	}else{
	    checkPwTag.classList.add("correct");
	}

    if(!pwIsValid || !checkPwIsValid){
        return false;
    }else{
        return true;
    }
}

    </script>
<div align="center">
	<form action="change_password.do" method="post"onsubmit="return checkForm();">
	<table width="400">
	<tbody>
	<tr>
	<th>변경할 비밀번호 입력</th>
	<td>
		<input width="50%"type="password" class="form-input" name="member_pw" 
		placeholder="비밀번호는 영문대/소문자와 숫자로 8~16자 내외로 구성하세요" id="pw">
		<span class="correct-message">올바른 비밀번호 형식입니다</span>
  		<span class="incorrect-message">영문/숫자로 8~16자 내외로 구성하세요</span>
  	</td>	
	</tr>
	<tr>
	<th>비밀번호 확인</th>
	<td>
 		<input width="50%" type="password"class="form-input" id ="checkPw" maxlength="16" placeholder="비밀번호 확인">
		<span class="correct-message">비밀번호가 일치합니다.</span>
 		<span class="incorrect-message">비밀번호가 불일치합니다.</span>
		<input type="submit" value="변경">
	</td>
	</tr>
	</tbody>
	</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>