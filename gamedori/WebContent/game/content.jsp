<%@page import="gamedori.beans.dto.GameListDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page import="gamedori.beans.dao.GameListDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="gamedori.beans.dto.GameWriterDto"%>
<%@page import="gamedori.beans.dao.GameWriterDao"%>
<%@page import="gamedori.beans.dao.GameDao"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/base.css">
<style>
.font-game {
	font-family: arcadeclassic;
	font-size: 40px;
	color: white;
	margin: 0;
}

.font-kor {
	font-family: DungGeunMo;
	color: white;
	font-size: 35px;
	margin: 0;
	margin-top: 30;
	padding: 0;
}

.line {
	text-align: center;
	border: 1px solid #85BCE1;
	background-color: #85BCE1;
	color: white;
	font-size: 30px;
	height: 100;
	width: 100%;
}
.swf-wrap {
	top: 0;
	padding: 0;
	text-align: center;
	width:100%;
	height: 500;
}

.content {
	width: 100%;
	text-align: center;
	margin: auto;
}

.h-170 {
	height: 170px;
}
.img-wrap, .gameName {
	text-decoration: none;
	color: black;
	font-family: DungGeunMo;
	font-weight: 200;
	font-size: 15px;
	margin-top: 10;
}
.gameNo {
	font-family: arcadeclassic;
	font-size: 25px;
	color:firebrick;
	margin: 0;
}
.recom-wrap {
	top: 0;
	padding: 0;
	text-align: center;
	width:100%;
	background-color: #E8E9EC;
}
.game-wrap:hover .gameName{
	color: #20639B;
}
.list-btn {
	background-color: transparent;
	border: transparent;
	color: white;
	font-weight: 700;
}
.list-wrap{
    display: inline-block;
    text-align: right;
    vertical-align: middle;
    float: right;
    /* height: 100%; */
    position: relative;
    left: 0;
    right: -39;
    top: -20;
}
.delete-btn {
	background-color: #85BCE1;
	color: white;
	border: none;
	width: 80;
}
</style>

<%
	GameDao gdao = new GameDao();

	int game_no = Integer.parseInt(request.getParameter("game_no"));

	//조회수 계산
	//	- session에 memory라는 저장소 정보를 추출한다 (없을 수도 있으므로)
	Set<Integer> game_memory = (Set<Integer>) session.getAttribute("game_memory");

	//	- memory가 없을 경우에는 "게시물을 아예 처음 읽는 경우"이므로 저장소 생성
	if (game_memory == null) {
		game_memory = new HashSet<>();
	}

	//	- memory에 현재 글 번호를 저장
	boolean isFirst = game_memory.add(game_no);
	//	System.out.println(memory);
	session.setAttribute("game_memory", game_memory);

	// game_no를 이용하여 조회수를 증가시킨다
	// 반드시 game_list 를 가져오기 전에 증가
	MemberDto user = (MemberDto) session.getAttribute("userinfo");
	if (isFirst) {
		gdao.plusReadCount(game_no, user.getMember_no()); // 내 글에는 조회수가 올라가면 안되므로 회원번호를 함께 전달
	}

	GameWriterDao gwdao = new GameWriterDao();
	GameWriterDto gwdto = gwdao.get(game_no);
	
	// 공통장르 추천 게임 랜덤으로 추출
	GameListDao gldao = new GameListDao();
	int genre_no = gldao.getGenre(game_no);
	List<Integer> recommend = gldao.recommend(genre_no);
	
	int count = recommend.size();
	System.out.println(count);
	
	Random r = new Random();
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<section class="content">
	<article class="w-90">
		<div class="row-empty"></div>
		<div class="row-empty"></div>
		<div class="line">
			<h3 class="font-game header"><%=gwdto.getGame_name()%></h3>
			<a class="list-wrap" href="javascript:history.back();">
				<input class="list-btn" type="button" value="목록으로">
			</a>
		</div>
		<div class="swf-wrap">
			<embed width="100%" height="100%"
				src="fileDownload.do?game_no=<%=game_no%>"
				type="application/x-shockwave-flash" allowfullscreen="true">
		</div>
	</article>
	<article class="w-90">
		<div class="line">
			<h3 class="font-kor">이런 게임은 어때요?</h3>
		</div>
		<div class="recom-wrap">
			<%
			for(int j=0; j<5; j++) {
				int no = r.nextInt(count);
				
				System.out.println("no ="+no);
				
				int value = recommend.get(no);
				System.out.println("value ="+value);
				
				GameListDto gldto = gldao.getList(value);
			%>
				<div class="row game-wrap">
					<a class="img-wrap img-transparent" href="content.jsp?game_no=<%=gldto.getGame_no()%>">
						<img width="153" height="120" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
						<h5 class="gameName"><%=gldto.getGame_name()%></h5>
					</a>
				</div>
			<%}%>
		</div>
		<div class="row-empty"></div>
	<div>
	<%if(user.getMember_no() == gwdto.getMember_no()){%>
		<a href="delete.do?game_no=<%=game_no%>">
			<input class="delete-btn" type="button" value="삭제">
		</a>		
	<%}%>
	</div>
		<div class="row-empty"></div>
		<div class="row-empty"></div>
	</article>
</section>
<jsp:include page="/template/footer.jsp"></jsp:include>