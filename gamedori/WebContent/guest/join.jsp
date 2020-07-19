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
      	 	text-align:left;
      	 	margin-bottom: 0;
      	 	font-family: 'DungGeunMo', sans-serif; 
	    }
        
    </style>

<body>
    <form action="join.do">
    <main>
        <header></header>
        <nav></nav>
        <section>
            
            <div class="row-empty"></div>
            <div class="row-empty"></div>
              
            <article class="w-35">
                <div class="row">
                    <img src="../image/signup.png">
                </div>
                <div class="row">
                        <h4 class="title" style="font-family: DungGeunMo;">이름</h4>
                     <input class="form-input" type="text" placeholder="5자 이하 한글" name="member_name">
                </div>
                <div class="row">
                        <h4 class="title">닉네임</h4>                      
                    <input class="form-input" type="text" placeholder="한글 8자 이내" name="member_nick">
                </div>
                <div class="row">
                       <h4 class="title">아이디</h4>
                    <input class="form-input" type="text" placeholder="5~20자 영문 또는 숫자" name="member_id">
                </div>
                <div class="row">
                       <h4 class="title">비밀번호</h4>                     
                    <input class="form-input" type="password" placeholder="8~16자 영문 또는 숫자" name="member_pw">
                </div>
                <div class="row">
                       <h4 class="title">비밀번호 확인</h4>                     
                    <input class="form-input" type="password" placeholder="8~16자 영문 또는 숫자" name="member_checkPw">
                </div>
                <div class="row">
                       <h4 class="title">전화번호</h4>                     
                    <input class="form-input" type="text" placeholder="-제외" name="member_phone">
                </div>
				<div class="row">
				<h4 class="title">관심 분야</h4>
					<%for( GenreDto g :genreList){%>
						<input  type="checkbox" name="member_favorite" id="mf<%=g.getGenre_no() %>" value="<%=g.getGenre_no() %>">						
						<label for="mf<%=g.getGenre_no()%>"><%=g.getGenre_type()%></label>
					<%} %>	
				</div>			
                <br>
                <div class="row">
                    <input class="form-btn" type="submit" value="가입완료">
                </div>                
            </article>
            <div class="row-empty"></div>
                     
        </section>
        <footer></footer>
    </main>
    </form>
</body>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>