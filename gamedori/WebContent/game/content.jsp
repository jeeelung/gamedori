<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="gamedori.beans.dto.GameWriterDto"%>
<%@page import="gamedori.beans.dao.GameWriterDao"%>
<%@page import="gamedori.beans.dao.GameDao"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base.css">
    <style>
        .line {
            border: 1px solid black;
        }
        .content {
            width: 100%;
            text-align: center;
            margin: auto;
        
        }
        .h-170 {
            height: 170px;
        }
    </style>
<script>

</script>
<%
	
	GameDao gdao = new GameDao();
	
	int game_no = Integer.parseInt(request.getParameter("game_no"));
	
	//조회수 계산
	//	- session에 memory라는 저장소 정보를 추출한다 (없을 수도 있으므로)
	Set<Integer> game_memory = (Set<Integer>)session.getAttribute("game_memory");

//	- memory가 없을 경우에는 "게시물을 아예 처음 읽는 경우"이므로 저장소 생성
	if(game_memory == null){
		game_memory = new HashSet<>();
	}
	
//	- memory에 현재 글 번호를 저장
	boolean isFirst = game_memory.add(game_no);
//	System.out.println(memory);
	session.setAttribute("game_memory", game_memory);
	
	// game_no를 이용하여 조회수를 증가시킨다
	// 반드시 game_list 를 가져오기 전에 증가
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	if(isFirst){
		gdao.plusReadCount(game_no, user.getMember_no()); // 내 글에는 조회수가 올라가면 안되므로 회원번호를 함께 전달
	}
	
	GameWriterDao gwdao = new GameWriterDao();
	GameWriterDto gwdto = gwdao.get(game_no);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
	<section class="content">
		<article class="w-70">
			<div class="row-empty"></div>
			<div class="row-empty"></div>
			<div class="line">
				<h3><%=gwdto.getGame_name()%></h3>
            </div>
			<div class="row-empty"></div>
			<div class="row">
				<embed width="80%" height="500" src="fileDownload.do?game_no=<%=game_no%>" quality="high" align="middle">
				</embed>
			</div>
        </article>
        <article class="w-70">
           <div class="row line h-170">
               <h3>추천게임란</h3>
           </div>
			<div class="row-empty"></div>
			<div class="row-empty"></div>
        </article>
	</section>
<jsp:include page="/template/footer.jsp"></jsp:include>