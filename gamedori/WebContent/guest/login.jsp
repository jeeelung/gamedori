<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
    main{
            width:1000px;
            margin:auto;
        }
        
        /* article 내에 사용하는 헤더는 가운데 정렬 */
        article h1,
        article h2,
        article h3,
        article h4,
        article h5,
        article h6{
            text-align: center;
        }
        
        /*
        입력창 스타일
        - form-input : 100% 크기의 입력창
        - form-btn : 100% 크기의 버튼
        */
        
        .form-input, .form-btn{
            width:100%;
            padding:0.5rem;
            outline: none;/* 선택 시 자동 부여되는 테두리 제거 */
            border:1px solid black;
        }
        .form-input:focus{
            border-color: blue;
        }
        .form-btn {
           font-size: 20px;
            background-color: #B22222;
            color:white;
            cursor: pointer;
        }
        .form-btn:hover {
            background-color: #EF9A9A;
        }
        
        .title{
             text-align:center;
             margin-bottom: 0;
             font-family: 'DungGeunMo', sans-serif; 
       }
        

</style>

<div align="center">
	<form action="login.do" method="post">
	 <div class="row-empty"></div>
            <div class="row-empty"></div>
	 <div class="row">
                    <img src="../image/login.png">
                </div>
	
		<table border="0">
			<tbody>
				<tr>
					<th class="title">아이디</th>
					<td>
						<input type="text" name="member_id" required>
					</td>
				</tr>
				<tr>
					<th class="title">비밀번호</th>
					<td>
						<input type="password" name="member_pw" required>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="2">
						<input type="submit" value="Login">
					</td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<a href="find_id.jsp">아이디가 기억나지 않습니다</a>
						<br>
						<a href="find_pw.jsp">비밀번호가 기억나지 않습니다</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>	
	
	<%if(request.getParameter("error") != null){%>
		<!-- 오류 메시지는 페이지에 error라는 파라미터가 있을 경우만 출력 -->
		<h6><font color="#FF0000">입력하신 로그인 정보가 맞지 않습니다</font></h6>
	<%} %>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
