<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	/board/list.jsp : 게시판 목록 겸 검색 페이지
 -->

<%
	//이 페이지를 출력하기 위한 프로그래밍 처리
	//1. 준비물(입력) : 검색창의 입력값 - type, keyword (둘다 있으면 검색)
	//2. 처리
	//		- isSearch라는 변수에 검색인지 아닌지 판정하여 저장
	//		- isSearch의 값에 따라 "목록" 또는 "검색" 결과를 저장
	//3. 결과물(출력) : 게시글 리스트 - List<BoardDto>
	
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	boolean isSearch = type != null && keyword != null;
	
	////////////////////////////////////////////////////////////
	// 페이지 계산 코드
	////////////////////////////////////////////////////////////
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
	
	//////////////////////////////////////////////////////////////////
	// 페이지 네비게이터 계산 코드
	//////////////////////////////////////////////////////////////////
	int blockSize = 10;//이 페이지에는 네비게이터 블록을 10개씩 배치하겠다!
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + blockSize - 1;
	EventboardDao edao = new EventboardDao();
	
	//(주의!) 다음 버튼의 경우 계산을 통하여 페이지 개수를 구해야 출력 여부 판단이 가능
	//int count = 목록개수 or 검색개수;
	int count;
	if(isSearch){//검색
		count = edao.getCount(type, keyword); 
	}
	else{//목록
		count = edao.getCount();
	}
	int pageCount = (count + pageSize - 1) / pageSize;
	//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
	if(finishBlock > pageCount){
		finishBlock = pageCount;
	}
	
	
// 	List<BoardDto> list = 목록 or 검색;
	
%> 
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<!-- 제목 -->
	<h2>자유 게시판</h2>
	
	<!-- 테이블 -->
	<table border="1" width="90%">
		<thead>
			<tr>
				<th>번호</th>
				<th width="50%">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody align="center">
			<%-- list의 데이터를 하나하나 bdto라는 이름으로 접근하여 출력 --%>
			<%for(EventboardDto edto : list){ %>
			<tr>
				<td><%=edto.getEvent_no()%></td>
				<td align="left">
					<a href="content.jsp?board_no=<%=edto.getEvent_no()%>">
						<%=edto.getEvent_title()%>
					</a>
				</td>
				<td>
					<%if(edto.getMember_no() != null){ %>
						<%}%>
					<%} else { %>
						<font color="gray">탈퇴한 사용자</font>
					<%} %>
				</td>
				<td><%=edto.getEventboard_autotime()%></td>
				<td><%=edto.getEvent_read()%></td>
			</tr>
			<%} %>
		</tbody>
		
		<tfoot>
			<tr>
				<td colspan="5" align="right">
					<a href="write.jsp">
						<input type="button" value="글쓰기">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
	
	<!-- 네비게이터 -->
	<h4>
	
	<!-- 
		이전 버튼을 누르면 startBlock - 1 에 해당하는 페이지로 이동해야 한다
		(주의) startBlock이 1인 경우에는 출력하지 않는다
	 -->
	<%if(startBlock > 1){ %>
	
		<%if(!isSearch){ %> 
			<a href="list.jsp?page=<%=startBlock-1%>">[이전]</a>
		<%}else{ %>
			<a href="list.jsp?page=<%=startBlock-1%>&type=<%=type%>&keyword=<%=keyword%>">[이전]</a>
		<%} %>
		
	<%} %>
	
	<!-- 
		이동 숫자에 반복문을 적용 
		범위는 startBlock부터 finishBlock까지로 설정(상단에서 계산을 미리 해두었음)
	-->
	<%for(int i=startBlock; i <= finishBlock; i++){ %>
		<%if(!isSearch){ %>
		<!-- 목록일 경우 페이지 번호만 전달 -->
		<a href="list.jsp?page=<%=i%>"><%=i%></a>
		<%}else{ %>
		<!-- 검색일 경우 페이지 번호와 검색 분류(type), 검색어(keyword)를 전달 -->
		<a href="list.jsp?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
		<%} %>
	<%} %>
	
	<!-- 
		다음 버튼을 누르면 finishBlock + 1 에 해당하는 페이지로 이동해야 한다
		(주의!) 다음이 없는 경우에는 출력하지 않는다(pageCount <= finishBlock)
	 -->
	<%if(pageCount > finishBlock){ %>
		<%if(!isSearch){ %> 
			<a href="list.jsp?page=<%=finishBlock + 1%>">[다음]</a>
		<%}else{ %>
			<a href="list.jsp?page=<%=finishBlock + 1%>&type=<%=type%>&keyword=<%=keyword%>">[다음]</a>
		<%} %>
	<%} %>
	</h4>
	
	<!-- 검색창 -->
	<form action="list.jsp" method="get">
		<!-- 검색분류 -->
		<select name="type">
			<option value="board_title">제목만</option>
			<option value="board_writer">글작성자</option>
		</select>
		
		<!-- 검색어 -->
		<input type="text" name="keyword" required>
		 
		<!-- 전송버튼 -->
		<input type="submit" value="검색">
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>


