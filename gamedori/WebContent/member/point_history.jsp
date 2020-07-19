<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="gamedori.beans.dao.PointHistoryDao"%>
<%@page import="gamedori.beans.dto.PointHistoryDto"%>
<%@page import="gamedori.beans.dao.PointDao"%>
<%@page import="gamedori.beans.dto.PointDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.QnaDao"%>
<%@page import="gamedori.beans.dto.QnaDto"%>
<%@page import="java.util.List"%>
<%
	//이 페이지를 출력하기 위한 프로그래밍 처리
	//1. 준비물(입력) : 검색창의 입력값 - type, keyword (둘다 있으면 검색)
	//2. 처리
	//		- isSearch라는 변수에 검색인지 아닌지 판정하여 저장
	//		- isSearch의 값에 따라 "목록" 또는 "검색" 결과를 저장
	//3. 결과물(출력) : 게시글 리스트 - List<QnaDto>
	
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	MemberDto user=(MemberDto)session.getAttribute("userinfo");
	
	boolean isSearch = type != null && keyword != null;
	boolean isAdmin = user.getMember_auth().equals("관리자");
	String auth = user.getMember_auth();
	int member_no = user.getMember_no();
	// 페이지 계산 코드
	int pageSize = 10;//한 페이지에 표시할 데이터 개수
	
	//page 번호를 계산하기 위한 코드
	// - 이상한 값은 전부다 1로 변경
	// - 멀쩡한 값은 그대로 숫자로 변환
	String pageStr = request.getParameter("page");
	int pageNo;
	try{
		pageNo = Integer.parseInt(pageStr);
		if(pageNo <= 0){
			throw new Exception();
		}
	}
	catch(Exception e){ 
		pageNo = 1;
	}
	
	//시작 글 순서와 종료 글 순서를 계산
	int finish = pageNo * pageSize;
	int start = finish - (pageSize - 1);
	
	// 페이지 네비게이터 계산 코드
	int blockSize = 10;//이 페이지에는 네비게이터 블록을 10개씩 배치하겠다!
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + blockSize - 1;
	
	
	PointDao pdao = new PointDao();
	PointHistoryDao phdao=new PointHistoryDao();
	//(주의!) 다음 버튼의 경우 계산을 통하여 페이지 개수를 구해야 출력 여부 판단이 가능
	//int count = 목록개수 or 검색개수;
	int count;
	if(isSearch){//검색
		count = phdao.getCount(type, keyword,member_no,auth); 
	}
	else{//목록
		count = phdao.getCount();
	}
	int pageCount = (count + pageSize - 1) / pageSize;
	//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
	if(finishBlock > pageCount){
		finishBlock = pageCount;
	}
	PointHistoryDto phdto = new PointHistoryDto();
	
	
	
// 	List<PointDto> list = 목록 or 검색;
	List<Map<String,Object>> list = new ArrayList<>();
	
	if(isSearch){
		//list = phdao.search(type, auth,keyword,auth,start, finish); 
	}
	else{
		list = phdao.getListForNormal(member_no,start ,finish);  	
	}
 %>
 
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
</style>
<div align="center">
	<!-- 제목 -->
	<h2>포인트 유형</h2>
	<!-- 테이블 -->
	<table border="1" width="90%">
		<thead>
			<tr>
				<th>NO</th>
				<th>TYPE</th>
				<th>POINT SCORE</th>
				<th>POINT DATE</th>
			</tr>
		</thead>
		<tbody align="center">
			<%for(Map<String,Object> pdto : list){ %>
			<tr>
				<td><%=pdto.get("point_his_no")%></td>
				<td>
					<%=pdto.get("point_type")%>
				</td>
				<td><%=pdto.get("point_score")%></td>
				<td><%=pdto.get("point_his_date")%></td>
			</tr>
			<%} %>
		</tbody>
		<tfoot>
		</tfoot>
	</table>
	</div>
	<h4>	
	<!-- 
		이전 버튼을 누르면 startBlock - 1 에 해당하는 페이지로 이동해야 한다
		(주의) startBlock이 1인 경우에는 출력하지 않는다
	 -->
	<% if(startBlock > 1){ %>
	
		<%if(!isSearch){ %> 
			<a href="MemberPointList.jsp?page=<%=startBlock-1%>">[이전]</a>
		<%}else{ %>
			<a href="MemberPointList.jsp?page=<%=startBlock-1%>&type=<%=type%>&keyword=<%=keyword%>">[이전]</a>
		<%} %>
		
	<%} %>
	
	<%for(int i=startBlock; i <= finishBlock; i++){ %>
		<%if(!isSearch){ %>
		<!-- 목록일 경우 페이지 번호만 전달 -->
		<a href="MemberPointList.jsp?page=<%=i%>"><%=i%></a>
		<%}else{ %>
		<!-- 검색일 경우 페이지 번호와 검색 분류(type), 검색어(keyword)를 전달 -->
		<a href="MemberPointList?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
		<%} %>
	<%} %>
	
	<%if(pageCount > finishBlock){ %>
		<%if(!isSearch){ %> 
			<a href="MemberPointList.jsp?page=<%=finishBlock + 1%>">[다음]</a>
		<%}else{ %>
			<a href="MemberPointList.jsp?page=<%=finishBlock + 1%>&type=<%=type%>&keyword=<%=keyword%>">[다음]</a>
		<%} %>
	<%} %>
	</h4>
	
	<!-- 검색창 -->
	<form action="MemberPointList.jsp" method="get">
		<!-- 검색분류 -->
		<select name="type">
			<option value="point_type">유형</option>
			<option value="point_score">포인트 점수</option>
		</select>
		
		<!-- 검색어 -->
		<input type="text" name="keyword" required>
		 
		<!-- 전송버튼 -->
		<input type="submit" value="검색">
	</form>
<script>
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>
