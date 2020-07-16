<%@page import="gamedori.beans.dto.GenreDto"%>
<%@page import="gamedori.beans.dao.GenreDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gamedori.beans.dto.GamePopularDto"%>
<%@page import="gamedori.beans.dao.GamePopularDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.MemberGenreTypeDao"%>
<%@page import="gamedori.beans.dto.MemberGenreTypeDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.GameListDao"%>
<%@page import="gamedori.beans.dto.GameListDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo");
	int member_no = mdto.getMember_no();

	GamePopularDao gpdao = new GamePopularDao();
	int top = 100;

	List<GamePopularDto> list = gpdao.getList(top);
	int gameCount = 0;

	// 회원 관심분야 추출
	MemberGenreTypeDao mgtdao = new MemberGenreTypeDao();
	List<MemberGenreTypeDto> favorite = mgtdao.getFavorite(member_no);

	// 관심분야 게임 리스트
	int topN = 5;
	
	// 장르명 추출
	GenreDao gdao = new GenreDao();
	List<GenreDto> genre = gdao.getList();
	
	// 정렬 방식 설정
	String arrow = request.getParameter("genre_arrow") == null? "desc": request.getParameter("genre_arrow");
	int genre_no = request.getParameter("genre_no")==null? 0: Integer.parseInt(request.getParameter("genre_no"));
	
	System.out.println(arrow);
	System.out.println(genre_no);
	
	boolean isList = genre_no == 0;
	boolean isGameRead = arrow.equals("game_read");
	
	GameListDao gldao = new GameListDao();
	List<GameListDto> gameList = new ArrayList<>();
	
	if(isList) {
		gameList = gldao.getList(arrow);
	} else {
		gameList = gldao.getGenreList(genre_no, arrow);
	}
	
	System.out.println(request.getQueryString());
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/swiper/css/swiper.min.css">
<style>
.font-game {
	font-family: arcadeclassic;
	font-size: 40px;
	color: #20639B;
	margin: 10;
}

.font-kor {
	font-family: DungGeunMo;
	color: firebrick;
	font-size: 30px;
}

.line {
	border: 1px solid #20639B;
}

.gameNo {
	font-family: arcadeclassic;
	font-size: 20px;
	color: #20639B;
}

/* .wrap {
	border-top: 3px solid #20639B;
	border-bottom: 3px solid #20639B;
}
 */
* {
	box-sizing: border-box;
}

.swiper-container {
	width: 100%;
	max-height: 300px;
}

.swiper-container .swiper-slide>.game-wrap {
	float: left;
	width: 18.1%;
	padding: 10px;
	margin-top: 20px;
}

.swiper-container .swiper-slide, .swiper-container .swiper-slide .game_img
	{
	width: 180;
	height: 130;
}

.swiper-container .swiper-slide {
	margin-bottom: 10px;
}

.swiper-container .swiper-slide .game_name {
	text-align: center;
	font-size: 15px;
}

.genre_type {
	text-align: center;
	max-height: 20px;
	font-weight: 700;
}

.img-wrap, .gameName {
	text-decoration: none;
	color: black;
	font-family: DungGeunMo;
	font-weight: 200;
	font-size: 15px;
	margin-bottom: 0;
}

.genre {
	margin: 0;
	color: black;
	font-weight: 100px;
}

.gameName {
	margin-top: 0;
}

.wrap {
	background-color: lightgray;
}

.arrow-wrap {
	float: right;
	margin: 10px;
}

.arrow-wrap select {
	width: 80px;
	font-weight: 800;
	color: #20639B;
	border: none;
}

.menu-sec, .menu-sec ul {
	list-style: none;
	padding: 0;
	margin: 0;
	background-color: #85BCE1;
	font-weight: 900;
	width: 100%;
	display: inline-block;
}

.menu-sec>li {
	/* 폭 설정이 가능해야하므로 inline-block */
	display: inline-block;
}

/* 모든 li는 relative 설정 */
.menu-sec li {
	position: relative;
	padding: 1rem;
	font-size: 15px;
	width: 100px;
	text-align: center;
	cursor: pointer;
}

/*
    2단계 메뉴 설정

    1) 2단계 메뉴부터는 position을 absolute로 설정
    2) 처음에는 2단계 이후의 메뉴가 나오지 않도록 처리
*/
.menu-sec>li ul {
	/* .menu li > ul */
	position: absolute;
	left: 0;
	/* 기준과 왼쪽을 맞춰라 */
	top: 100%;
	/* 기준의 바닥에 시작점을 맞춰라 */
	display: none;
}

/* 메뉴에 커서가 올라가면 하위 메뉴가 나오도록 처리 */
.menu-sec li:hover>ul {
	display: block;
}

.menu-sec li:hover {
	background-color: skyblue;
}

.menu-sec a {
	/* .menu > li > a */
	color: white;
	text-decoration: none;
}

.menu-sec li:hover a {
	color: floralwhite;
}
</style>

<script src="<%=request.getContextPath()%>/swiper/js/swiper.min.js"></script>
<script>
	// 창의 로딩이 완료되었을 때 실행할 코드를 예약
	window.onload = function() {
		//swiper 관련 코드를 이곳에 작성
		// var mySwiper = new swiper('선택자', 옵션)
		var mySwiper = new Swiper('.swiper-container', {
			// Optional parameters

			// swiper에 적용할 옵션들을 작성

			direction : 'horizontal', // 표시방식(수직 : vartical / 수평 : horizontal)
			loop : true, // 순환모드 여부(마지막과 처음이 이어지는 것)

			// 자동재생 옵션그룹
			autoplay : {
				delay : 3000, // 자동재생 시간(1000 = 1초)
			},

			// 페이지 네비게이터 옵션그룹
			pagination : {
				el : '.swiper-pagination', // 적용대상의 선택자
				type : 'bullets', // 네비게이터 모양(bullets, fraction, progressbar)
			},

			// 이전/다음 이동버튼 설정그룹
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},

			// 스크롤바 옵션
			//scrollbar: {
			//    el: '.swiper-scrollbar',
			//},

			// 커서 모양을 손모양으로 변경
			grabCursor : true,

			// 슬라이드 전환효과
			// effect: 'coverflow',
			// effect: 'cube',
			// effect: 'fade'
			// effect: 'flip',
			effect : 'slide', // 기본값

		});
	};
	function sendForm(){
		document.querySelector("form").submit();
	}
	
</script>
<article>
	<div class="row">
		<h3 class="font-game">G e n r e　o f　i n te r e s t</h3>
	</div>
	<!-- 이미지 슬라이더 영역 -->
	<div class="swiper-container">
		<!-- 필수영역-->
		<div class="swiper-wrapper">
			<!-- 배치되는 이미지 또는 화면 -->
			<%
				for (MemberGenreTypeDto mgtdto : favorite) {
			%>
			<div class="swiper-slide">
				<div class="genre_type">
					<h1 class="font-kor"><%=mgtdto.getGenre_type()%></h1>
				</div>
				<%
					List<GamePopularDto> favoriteGame = gpdao.getFavorite(mgtdto.getGenre_no(), topN);
				%>
				<%
					for (GamePopularDto gpdto : favoriteGame) {
				%>
				<div class="game-wrap">
					<a class="img-wrap"
						href="content.jsp?game_no=<%=gpdto.getGame_no()%>"> <img
						class="game_img"
						src="imgDownload.do?game_img_no=<%=gpdto.getGame_img_no()%>"
						width="180" height="130">
						<p class="game_name"><%=gpdto.getGame_name()%></p>
					</a>
				</div>
				<%
					}
				%>
			</div>
			<%
				}
			%>
		</div>
		<!-- 페이지 위치 표시 영역(선택) -->
		<div class="swiper-pagination"></div>

		<!-- 이전/다음 버튼(선택) -->
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>

		<!-- 스크롤바(선택) -->
		<div class="swiper-scrollbar"></div>
	</div>
</article>
<article>
	<form action="genrelist.jsp" method="get">
	<%if(request.getParameter("genre_no") != null) { %>
	<input type="hidden" name="genre_no" value="<%=request.getQueryString().substring(9, 10) %>">
	<%} %>
	<div class="row-empty"></div>
	<div class="row-empty"></div>
	<div class="row">
		<ul class="menu-sec center">
			<li><a href="genrelist.jsp">전체</a></li>
		<%for(GenreDto gdto : genre) {%>
			<li><a href="genrelist.jsp?genre_no=<%=gdto.getGenre_no()%>"><%=gdto.getGenre_type()%></a></li>
		<%}%>
		</ul>
	<div class="row-empty"></div>
		<div class="arrow-wrap row">
			<select name="genre_arrow" onchange="sendForm();">
				<option value="desc">최신순</option>
				<option value="game_read">조회순</option>
				<option value="asc">업로드순</option>
			</select>
		</div>
		<div class="row">
		<%for(GameListDto gldto : gameList) {%>
			<div class="row game-wrap">
				<a class="img-wrap" href="content.jsp?game_no=<%=gldto.getGame_no()%>">
					<img width="160" height="140" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
					<h5 class="gameName"><%=gldto.getGame_name()%></h5>
				</a>
			</div>
		<%}%>
		</div>
	</div>
	</form>
</article>
<jsp:include page="/template/footer.jsp"></jsp:include>