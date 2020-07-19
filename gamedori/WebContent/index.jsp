<%@page import="gamedori.beans.dto.GenreDto"%>
<%@page import="gamedori.beans.dao.GenreDao"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.GameListDao"%>
<%@page import="gamedori.beans.dto.GameListDto"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	GameListDao gldao = new GameListDao();
	int top = 100;
	
	// 페이지 번호 계산 코드
	int pageSize = 20;
	String pageStr = request.getParameter("page")==null? "1": request.getParameter("page");
	int pageNo;
	try{
		pageNo = Integer.parseInt(pageStr);
		
		if(pageNo <= 0 ){ // 음수시 강제 예외
			throw new Exception();
		}
	} catch(Exception e){ // 문제가 생기면 무조건 1페이지
		pageNo = 1;
	}
	
	// 시작 글 순서와 종료 글 순서 계산
	int finish = pageNo * pageSize;
	int start = finish - (pageSize - 1);
	
	// 페이지 네비게이터 계산
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + 9;
	
	// 페이지 개수 
	int count = top;
	int pageCount = (count + pageSize -1) / pageSize;
	
	if(finishBlock > pageCount) {
		finishBlock = pageCount;	
	}
		
	// 신규게임 추출
	List<GameListDto> list = gldao.getNewList(top, start, finish);
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/swiper/css/swiper.min.css">
<style>
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
.font-game {
	font-family: arcadeclassic;
	font-size: 40px;
	color: #20639B;
	margin-bottom: 0;
}

.font-kor {
	font-family: DungGeunMo;
	color:firebrick;
	font-size: 30px;
}
.line {
	border: 1px solid #20639B;
}
.gameNo {
	font-family: arcadeclassic;
	font-size: 25px;
	color:firebrick;
	margin: 0;
}
.gameName, .game_name{
	margin-top: 0;
}

.wrap {
	border-top: 3px solid #20639B;
	border-bottom: 3px solid #20639B;
	background-color: lightgray;
}

.today-wrap {
	border-top: 3px solid #20639B;
	border-bottom: 3px solid #20639B;
	position: relative;
}

.arrow-left > img{
	float:left;
	position: absolute;
	left:0;
	bottom:40%;
}

.arrow-right > img{
	float:right;
	position: absolute;
	right:0;
	bottom:40%;
}
.genre {
	margin: 0;
}
.game-wrap:hover .gameName{
	color: #20639B;
}

.game-wrap:hover .game_name{
	color : firebrick;
}

</style>
<!-- 장르별 신규게임 -->
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
</script>
<article>
	<div class="row">
		<h3 class="font-game">N E W　G A M E S　B Y　G E N R E</h3>
	</div>
	<!-- 이미지 슬라이더 영역 -->
	<div class="swiper-container">
		<!-- 필수영역-->
		<div class="swiper-wrapper">
			<!-- 배치되는 이미지 또는 화면 -->
			<%
			GenreDao gdao = new GenreDao();
			List<GenreDto> genreList = gdao.getList();
			for(GenreDto gdto : genreList) {
				int genre_no = gdto.getGenre_no();
				List<GameListDto> todayList = gldao.getTodayList(genre_no);
			%>
			<div class="swiper-slide">
				<div class="genre_type">
					<h1 class="font-kor"><%=gdto.getGenre_type()%></h1>
				</div>
				<%  for (GameListDto gldto : todayList) {%>
				<div class="game-wrap">
					<a class="img-wrap"
						href="<%=request.getContextPath()%>/game/content.jsp?game_no=<%=gldto.getGame_no()%>"> <img
						class="game_img img-transparent"
						src="<%=request.getContextPath()%>/game/imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>"
						width="180" height="130">
						<span class="gameNo">TOP <%=gldto.getRow_num()%>.</span>
						<p class="game_name"><%=gldto.getGame_name()%></p>
					</a>
				</div>
				<%}%>
			</div>
			<%}%>
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
<!-- 신규게임 top 100 -->
    <article>
        <div class="row-empty"></div>
        <div class="row">
        	<h3 class="font-game">N E W　TO P　1 0 0</h3>
        </div>
        <div class="row wrap">
        <div class="row-empty"></div>
            <%for(GameListDto gldto : list) { %>
            <div class="row game-wrap">
            <a href="<%=request.getContextPath()%>/game/content.jsp?game_no=<%=gldto.getGame_no()%>">
	            <img class="img-transparent" width="230" height="170" src="<%=request.getContextPath()%>/game/imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
                <h5 class="gameName"><span class="gameNo"><%=gldto.getRow_num()%>.</span><%=gldto.getGame_name()%></h5>
                <h6 class="genre">장르 : <%=gldto.getGenre_type()%></h6>
            </a>
            </div>
            <%}%>
        <div class="row-empty"></div>
        </div>
        <div class="row-empty"></div>
<!-- 페이지 네비게이터 -->
<%if(startBlock > 1) {%>
	<a href="<%=request.getContextPath()%>/index.jsp?page=<%=startBlock-1%>">[이전]</a>
<%}%>

	<%for(int i=startBlock; i<=finishBlock; i++) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?page=<%=i%>"><%=i%></a>
	<%}%>
	
<%if(pageCount > finishBlock) {%>	
	<a href="<%=request.getContextPath()%>/index.jsp?page=<%=finishBlock+1%>">[다음]</a>
<%}%>
    </article>
<jsp:include page="/template/footer.jsp"></jsp:include>