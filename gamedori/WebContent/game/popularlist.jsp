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
	color:firebrick;
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
	width: 100%;
	height: 100%;
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
.img-wrap, .gameName{
	text-decoration: none;
	color: black;
	font-family: DungGeunMo;
	font-weight: 200;
	font-size: 15px;
}
.genre {
	margin: 0;
	color: black;
	font-weight: 100px;
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
					<a class="img-wrap" href="content.jsp?game_no=<%=gpdto.getGame_no()%>"> <img class="game_img"
						src="imgDownload.do?game_img_no=<%=gpdto.getGame_img_no()%>">
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
	<div class="row-empty"></div>
	<div>
		<h3 class="font-game">B E S T　TO P　1 0 0</h3>
	</div>
	<div class="row wrap">
		<div class="row-empty"></div>
		<%
			for (GamePopularDto gpdto : list) {
		%>
		<div class="row game-wrap">
			<a class="img-wrap" href="content.jsp?game_no=<%=gpdto.getGame_no()%>"> <img
				width="150" height="150"
				src="imgDownload.do?game_img_no=<%=gpdto.getGame_img_no()%>">
				<h5 class="gameName">
					<span class="gameNo"><%=gameCount += 1%>.</span><%=gpdto.getGame_name()%>
				</h5>
			</a>
			<h6 class="genre">
				장르 :
				<%=gpdto.getGenre_type()%></h6>
		</div>
		<%
			}
		%>
		<div class="row-empty"></div>
	</div>
	<div class="row-empty"></div>
</article>
</form>
<jsp:include page="/template/footer.jsp"></jsp:include>