<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.GameListDao"%>
<%@page import="gamedori.beans.dto.GameListDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	GameListDao gldao = new GameListDao();
	int top = 14;
	List<GameListDto> list = gldao.getLatestList(top);
	int gameCount = 0;
	
	// 페이지 번호 계산 코드
	int pageSize = 5;
	String pageStr = request.getParameter("page");
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
	int blockSize = 5;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + 4;
	
	// 페이지 개수 
	int count = gldao.getTodayCount();
	int pageCount = (count + pageSize -1) / pageSize;
	
	if(finishBlock > pageCount) {
		finishBlock = pageCount;	
	}
	
	// 오늘의 게임 추출
	List<GameListDto> todayList = gldao.getTodayList(start, finish);
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
        	<select>
        		<option></option>
        	</select>
        </div>
        <div class="row today-wrap">
        <div class="row-empty"></div>
<%-- <h5>
	pageStr = <%=pageStr%>, 
	pageNo = <%=pageNo%>,
	start = <%=start%>
	finish = <%=finish%>
	pageCount = <%=pageCount%>
	startBlock = <%=startBlock%>
	finishBlock = <%=finishBlock%>
</h5> --%>

<!-- 오늘의 게임 이전 버튼 생성 -->
<%if(pageNo != 1) {%>
	<a class="arrow-left" href="latestlist.jsp?page=<%=pageNo-1%>">
		<img src="<%=request.getContextPath()%>/image/left.png" width="50" height="50">
	</a>
<%} else {%>
	<a class="arrow-left"  href="latestlist.jsp?page=<%=pageCount%>">
		<img src="<%=request.getContextPath()%>/image/left.png" width="50" height="50">
	</a>
<%}%>
<!-- 오늘의 게임 이미지 생성 -->
<%if(!todayList.isEmpty()) {%>
	<%for(GameListDto gldto : todayList){ %>
	<div class="row game-wrap">
		<a href="content.jsp?game_no=<%=gldto.getGame_no()%>">
			<img width="150" height="150" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
		</a>
		<div>
			<h5 class="gameName"><%=gldto.getGame_name()%></h5>
			<h6 class="genre">장르 : <%=gldto.getGenre_type()%></h6>
		</div>
	</div>
	<%}%>
<%} else {%>
	<%List<GameListDto> top5 = gldao.getLatestList(5);%>
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
<%if(pageCount != pageNo) {%>
	<a class="arrow-right" href="latestlist.jsp?page=<%=pageNo+1%>">
		<img src="<%=request.getContextPath()%>/image/right.png" width="50" height="50">
	</a>
<%} else {%>
	<a class="arrow-right" href="latestlist.jsp?page=1">
		<img src="<%=request.getContextPath()%>/image/right.png" width="50" height="50">
	</a>
<%}%>
		<div class="row-empty"></div>
        </div>
    </article>
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
	            <img width="150" height="150" src="imgDownload.do?game_img_no=<%=gldto.getGame_img_no()%>">
            </a>
                <h5 class="gameName"><span class="gameNo"><%=gameCount+=1%>.</span><%=gldto.getGame_name()%></h5>
                <h6 class="genre">장르 : <%=gldto.getGenre_type()%></h6>
            </div>
            <%}%>
        <div class="row-empty"></div>
        </div>
        <div class="row-empty"></div>
        
    </article>
<jsp:include page="/template/footer.jsp"></jsp:include>