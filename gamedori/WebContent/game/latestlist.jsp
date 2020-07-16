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
	
	
	// 오늘의 게임 페이지 번호 계산 코드
	int todayPageSize = 5;
	String todayPageStr = request.getParameter("todaypage")==null? "1": request.getParameter("todaypage");
	int todayPageNo;
	try{
		todayPageNo = Integer.parseInt(todayPageStr);
		
		if(todayPageNo <= 0 ){ // 음수시 강제 예외
			throw new Exception();
		}
	} catch(Exception e){ // 문제가 생기면 무조건 1페이지
		todayPageNo = 1;
	}
	
	// 시작 글 순서와 종료 글 순서 계산
	int todayFinish = todayPageNo * todayPageSize;
	int todayStart = todayFinish - (todayPageSize - 1);
	
	// 페이지 네비게이터 계산
	int todayBlockSize = 5;
	int todayStartBlock = (todayPageNo - 1) / todayBlockSize * todayBlockSize + 1;
	int todayFinishBlock = todayStartBlock + 4;
	
	// 페이지 개수 
	int todayCount = gldao.getTodayCount();
	int todayPageCount = (todayCount + todayPageSize -1) / todayPageSize;
	
	if(todayFinishBlock > todayPageCount) {
		todayFinishBlock = todayPageCount;
	}
		
	// 신규게임 추출
	List<GameListDto> list = gldao.getNewList(top, start, finish);
	
	// 오늘의 게임 추출
	List<GameListDto> todayList = gldao.getTodayList(todayStart, todayFinish);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #20639B;
}
.line {
	border: 1px solid #20639B;
}
.gameNo {
	font-family: arcadeclassic;
	font-size: 20px;
	color:#20639B;
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

</style>

    <article>
        <div class="font-game">
        	<h3>TO D A Y　N E W　G A M E</h3>
        </div>
        <div class="row today-wrap">
        <div class="row-empty"></div>

<!-- 오늘의 게임 이전 버튼 생성 -->
<%if(todayPageNo != 1) {%>
	<a class="arrow-left" href="latestlist.jsp?todaypage=<%=todayPageNo-1%>">
		<img src="<%=request.getContextPath()%>/image/left.png" width="50" height="50">
	</a>
<%} else {%>
	<a class="arrow-left"  href="latestlist.jsp?todaypage=<%=todayPageCount%>">
		<img src="<%=request.getContextPath()%>/image/left.png" width="50" height="50">
	</a>
<%}%>
<!-- 오늘의 게임 이미지 생성 -->
<%if(!todayList.isEmpty()) {%>
	<%for(GameListDto gldto : todayList){ %>
	<div class="row game-wrap">
		<img width="150" height="150" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
		<div>
			<h5 class="gameName"><%=gldto.getGame_name()%></h5>
			<h6 class="genre">장르 : <%=gldto.getGenre_type()%></h6>
		</div>
	</div>
	<%}%>
<%} else {%>
	<%List<GameListDto> top5 = gldao.getNewList(5, 1, 5);%>
	<%for(GameListDto gldto : top5) {%>
	<div class="row game-wrap">
        <img width="150" height="150" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
        <div>
			<h5 class="gameName"><%=gldto.getGame_name()%></h5>
			<h6 class="genre">장르 : <%=gldto.getGenre_type()%></h6>
		</div>
    </div>
	<%}%>
<%}%>

<!-- 오늘의 게임 다음 버튼 생성 -->
<%if(todayPageCount != todayPageNo) {%>
	<a class="arrow-right" href="latestlist.jsp?todaypage=<%=todayPageNo+1%>">
		<img src="<%=request.getContextPath()%>/image/right.png" width="50" height="50">
	</a>
<%} else {%>
	<a class="arrow-right" href="latestlist.jsp?todaypage=1">
		<img src="<%=request.getContextPath()%>/image/right.png" width="50" height="50">
	</a>
<%}%>
		<div class="row-empty"></div>
        </div>
</article>      
<!-- 신규게임 top 100 -->
    <article>
        <div class="row-empty"></div>
        <div class="font-game">
        	<h3>N E W　TO P　1 0 0</h3>
        </div>
        <div class="row wrap">
        <div class="row-empty"></div>
            <%for(GameListDto gldto : list) { %>
            <div class="row game-wrap">
            <a href="content.jsp?game_no=<%=gldto.getGame_no()%>">
	            <img width="160" height="140" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
            </a>
                <h5 class="gameName"><span class="gameNo"><%=gldto.getRow_num()%>.</span><%=gldto.getGame_name()%></h5>
                <h6 class="genre">장르 : <%=gldto.getGenre_type()%></h6>
            </div>
            <%}%>
        <div class="row-empty"></div>
        </div>
        <div class="row-empty"></div>
<!-- 페이지 네비게이터 -->
<%if(startBlock > 1) {%>
	<a href="latestlist.jsp?page=<%=startBlock-1%>">[이전]</a>
<%}%>

	<%for(int i=startBlock; i<=finishBlock; i++) { %>
		<a href="latestlist.jsp?page=<%=i%>"><%=i%></a>
	<%}%>
	
<%if(pageCount > finishBlock) {%>	
	<a href="latestlist.jsp?page=<%=finishBlock+1%>">[다음]</a>
<%}%>
    </article>
<jsp:include page="/template/footer.jsp"></jsp:include>