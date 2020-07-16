
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	if((MemberDto)session.getAttribute("userinfo")!=null){
	}
	
	MemberDto user=(MemberDto)session.getAttribute("userinfo");
	
	boolean isAdmin = false;
	boolean isSearch = false;
	
	if(user != null) {
		isAdmin= user.getMember_auth().equals("관리자");
		isSearch = type != null && keyword != null;
	}
	
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
	int start = finish - (pageSize-1);
	
	// 페이지 네비게이터 계산
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + blockSize - 1;
	
	NoticeDao ndao = new NoticeDao();
	
	// 페이지 개수 
	int count;
	if(isSearch) {
		count = ndao.getCount(type, keyword);
	} else {
		count = ndao.getCount();
	}
	int pageCount = (count + pageSize -1) / pageSize;
	//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
		if(finishBlock > pageCount){
			finishBlock = pageCount;
		}
	
	// 검색 또는 목록
	List<NoticeDto> list;
	
	if(isSearch){
		list = ndao.search(type, keyword);
	} else {
		list =ndao.getList(start, finish);
		
	}
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	.ec-base-table.typeList table{
		border-top-color: #e8e8e8;
	}
	.ec-base-table table{
	position: releative;
	margin: 0;
	border: 1px solid #e8e8e8;
	border-left:0;
	border-right:0;
	color: #fff;
	line-height:L
	
	}
	
	.path li {
		float: left;
		padding: 0 0 0 12px;
		margin: 0 0 0 8px;
		color: #999;
		background: url(../image/화살표.png) no-repeat 0 10px;
	}
	
	.font-notice {
		font-family: ARCADECLASSIC;
		font-size: 30px;
		color: #20639B;
	}
	
	
	element.style{
	
	}
		
	.path ol {
		float: right;
	
	}
	.path {
		position: absolute;
		right: 0;
		z-index: 99;
		line-height: 30px;
		text-transform: lowercase;
		
	}
	ol{
	diplay: block;
	list-style-type: decimal;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	padding-inline-start: 40px;
	
	}
	div{
	diplay: block;s
	}
	
	.ec-bace-table{
		clear: both;
	}

</style>
<div align="center">
	
	<form action="list.jsp" method="get">
	<div class="ec-bace-table- typeList gBorder">
	<table border="1" >
		<thead>
		<div class="title">
		<h2>N O T I C E</h2>
		</div>
		<div class="path">
		 <ol >
		 	<li>
		 	 <a href="/gamedori/index.jsp">home</a>
		 	</li>
		 	<li title="현재 위치">
		 		<strong>notice</strong>
		 	</li>
		 </ol>
		</div>
			<tr style=" ">				
				<th scope="col">NO</th>
				<th scope="col">CONTENTS</th>
				<th scope="col">NAME</th>
				<th scope="col">DATE</th>
				<th scope="col">READ</th>
			</tr>
		</thead>
		
		<tbody align="center"> 
			<% for(NoticeDto ndto : list) { %>
			<tr>	
			<%MemberDto mdto = ndao.getWriter(ndto.getMember_no());
				System.out.println(mdto.getMember_id());
			%>
				<th><%=ndto.getNotice_no()%></th>
			<td>
				<a href="content.jsp?notice_no=<%=ndto.getNotice_no()%>">
					<%=ndto.getNotice_title()%>
				
				</a>
			</td>
			
				<td><%=mdto.getMember_nick()%></td>
				<td><%=ndto.getNotice_auto()%></td>
				<td><%=ndto.getNotice_read()%></td>
			</tr>
			<%}%>
				
		</tbody>
		<%if(isAdmin){ %>
		<tfoot>
			<tr align="right">
				<td colspan="5" align="right">
					<a href="write.jsp">
						<input type="button" value="글쓰기">
					</a>
				</td>
			</tr>
		</tfoot>
		<%} %>
	</table>
	</div>
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
	<select class="form-input form-inline" name="type">
		<option value="notice_title">제목</option>
		<option value="notice_content">내용</option>
		<option value="member_nick">글작성자</option>
	</select>
		<input type="text" name="keyword" placeholder="검색어를 입력하세요" required>
		<input type="submit" value="검색">
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>