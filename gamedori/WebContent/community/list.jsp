<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	String head = request.getParameter("commu_head");
	
	boolean isHead = head != null;
	boolean isSearch = type != null && keyword != null;
	boolean isList = !isHead && !isSearch;
	
	// 페이지 번호 계산 코드
	int pageSize = 10;
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
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + 9;
	
	CommunityDao cdao = new CommunityDao();
	
	// 페이지 개수 
	int count;
	if(isHead && !isSearch) {
		count = cdao.getCount(head);
	} else if(!isHead && isSearch){
		count = cdao.getCount(type, keyword);
	} else if(isHead && isSearch) {
		count = cdao.getCount(head, type, keyword);
	} else {
		count = cdao.getCount();
	}
	
	int pageCount = (count + pageSize -1) / pageSize;
	
	if(finishBlock > pageCount) {
		finishBlock = pageCount;	
	}
	// 검색 또는 목록
	List<CommunityDto> list;
	
	if(isHead && !isSearch) {
		list = cdao.search(head, start, finish);	
	} else if(!isHead && isSearch){
		list = cdao.search(type, keyword, start, finish);			
	} else if(isHead && isSearch) {
		list = cdao.search(head, type, keyword, start, finish);
	} else {
		list = cdao.getList(start, finish);
	}
	
%>

<script>
	function sendForm(){
		document.querySelector("form").submit();
	}
	
	//a는 전송된 값이 선택되어 있도록 유지
	window.onload = function(){
		var head = document.querySelector("[name=commu_head]");
		var type = document.querySelector("[name=type]");
		var keyword = document.querySelector("[name=keyword]");
		if(head.value === null){
			head.value = "";
		} else {			
			head.value = "<%=request.getParameter("commu_head")%>";
		}
		type.value = "<%=request.getParameter("type")%>";
		keyword.value = "<%=request.getParameter("keyword")%>";
	};
</script>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">

	<!-- 계산한 데이터를 확인하기 위해 출력 -->
	<%-- <h5>
	pageStr = <%=pageStr%>, 
	pageNo = <%=pageNo%>,
	start = <%=start%>
	finish = <%=finish%>
	pageCount = <%=pageCount%>
	startBlock = <%=startBlock%>
	finishBlock = <%=finishBlock%>
	</h5> --%>
	
	<h2></h2>
	<form action="list.jsp" method="get">
	<table border="1" width="90%">
	
		<thead>
			<tr>
				<th>
					<select name="commu_head" onchange="sendForm();">
						<option value="">전체보기</option>
						<option>자유</option>
						<option>유머</option>
						<option>공략</option>
					</select>
				</th>
				<th width="50%">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		
		<tbody>
			<% for(CommunityDto cdto : list) { %>
			<tr>
				<%MemberDto mdto = cdao.getWriter(cdto.getMember_no());%>
				<th><%=cdto.getCommu_no()%></th>
				<td>
					<%if(cdto.getCommu_super_no() > 0){ %>
						<%for(int i=0; i<cdto.getCommu_depth(); i++) {%>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<%}%>
					<img src="<%=request.getContextPath()%>/image/reply.PNG"
							width="20" height="15">
					<%}%>
					<a href="<%=request.getContextPath()%>/community/content.jsp?commu_no=<%=cdto.getCommu_no()%>">
					[<%=cdto.getCommu_head()%>]<%=cdto.getCommu_title()%>
					</a>
				</td>
				<td><%=mdto.getMember_nick()%></td>
				<td><%=cdto.getCommu_auto()%></td>
				<td><%=cdto.getCommu_read()%></td>
			</tr>
			<%}%>
		</tbody>
		
		<tfoot>
			<tr align="right">
				<td colspan="5" align="right">
					<a href="write.jsp">
						<input type="button" value="글쓰기">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
	<!-- 네비게이터 -->
	<h6>
<%if(startBlock > 1) {%>
	<%if(!isSearch) { %>
		<a href="list.jsp?page=<%=startBlock-1%>">[이전]</a>
	<%} else {%>
		<a href="list.jsp?page=<%=startBlock-1%>&type=<%=type%>&keyword=<%=keyword%>">[이전]</a>
	<%}%>
<%}%>

	<%for(int i=startBlock; i<=finishBlock; i++) { %>
		<%if(!isSearch) {%>
			<a href="list.jsp?page=<%=i%>"><%=i%></a>
		<%} else {%>
			<a href="list.jsp?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
		<%}%>
	<%}%>
<%if(pageCount > finishBlock) {%>	
	<%if(!isSearch) { %>
		<a href="list.jsp?page=<%=finishBlock+1%>">[다음]</a>
	<%} else {%>
		<a href="list.jsp?page=<%=finishBlock+1%>&type=<%=type%>&keyword=<%=keyword%>">[다음]</a>
	<%}%>
<%}%>
	</h6>
	<!-- 검색창 -->
	<select name="type">
		<option value="commu_title">제목만</option>
		<option value="commu_content">내용만</option>
		<option value="member_nick">글작성자</option>
	</select>
		<input type="text" name="keyword" placeholder="검색어를 입력하세요" required>
		<input type="submit" value="검색">
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>