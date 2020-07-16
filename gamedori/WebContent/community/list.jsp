<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
    
    <style>
.font-header {

	font-family: arcadeclassic;
	font-size: 35px;
	color: #20639B;
}

.font_han{
	font-family: DungGeunMo;
}

thead tr {
    background-color: #85BCE1;
    color: #ffffff;
  }


    </style>
    
    
    
<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	String head = request.getParameter("head");
	
	boolean isHead = head != null;
	boolean isSearch = type != null && keyword != null;
	
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
	if(isSearch) {
		count = cdao.getCount(type, keyword);
	} else if(isHead){
		count = cdao.getCount(head);
	} else {
		count = cdao.getCount();		
	}
	int pageCount = (count + pageSize -1) / pageSize;
	
	if(finishBlock > pageCount) {
		finishBlock = pageCount;	
	}
	// 검색 또는 목록
	List<CommunityDto> list;
	
	if(isSearch){
		list = cdao.search(type, keyword, start, finish);
	} else if(isHead){
		list = cdao.headSort(head, start, finish);
	} else {
		list = cdao.getList(start, finish);
	}
	
	
	
%>

<script>
	function headSort() {
    	var headvalue = document.querySelector("select[name=commu_head]").value;
    	<%if(isSearch) {%>
    		location.href = "list.jsp?type="<%=type%>"&keyword="<%=keyword%>"&head="+headvalue;
    	<%} else {%>
    		location.href = "list.jsp?head="+headvalue;
    	<%}%>
	}
</script>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<article class="w-90">
<div align="center">

	<!-- 계산한 데이터를 확인하기 위해 출력 -->
	<h5 class="font-header">
	자유게시판
	</h5>
	
	<h2></h2>
	<form action="list.jsp" method="get">
	<table border="1" width="60%" class=" table table1-stripe table-border  table-hover">
	
		<thead>
			<tr align="center">
				<th>
					<select name="commu_head" onchange="headSort();">
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
				<td class="left">
					<%if(cdto.getCommu_depth() > 0){ %>
						<%for(int i=0; i<cdto.getCommu_depth(); i++) {%>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<%}%>
					<img src="<%=request.getContextPath()%>/image/reply.PNG"
							width="20" height="15">
					<%}%>
					<a href="<%=request.getContextPath()%>/community/content.jsp?commu_no=<%=cdto.getCommu_no()%>">
					[<%=cdto.getCommu_head()%>]<%=cdto.getCommu_title()%>
						</a>
					[<%=cdto.getCommu_replycount() %>]
					
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
						<input class="form-btn form-inline" type="button" value="글쓰기">
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
		<input class="form-btn form-inline" type="submit" value="검색">
	</form>
</div>
</article>
<jsp:include page="/template/footer.jsp"></jsp:include>