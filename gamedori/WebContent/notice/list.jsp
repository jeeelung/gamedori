
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	MemberDto user=(MemberDto)session.getAttribute("userinfo");
	int member_no;
	String member_nick;
	boolean isAdmin;
	if(user==null){
	member_no = 0;
	isAdmin = false;
	}else{		
	member_no = user.getMember_no();
	isAdmin= user.getMember_auth().equals("관리자");
	}
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
<style>
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #85BCE1;
}
.wrap {
	border-top: 3px solid #85BCE1;
	border-bottom : 3px solid #85BCE1;
}
.today-wrap {
	border-top: 3px solid #85BCE1;
	border-bottom : 3px solid #85BCE1;
	position : relative;
}
.table{
	
}
.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #85BCE1;
	/* 테두리 병합 */
	border-collapse: collapse;
}
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td,
        .table.table-border > tbody > tr > th,
        .table.table-border > tbody > tr > td,
        .table.table-border > tfoot > tr > th,
        .table.table-border > tfoot > tr > td {
            /* 칸에 테두리를 부여 */
            border:2px solid #85BCE1;
             color:#85BCE1;
            
        }
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td > a,
        .table.table-border > tbody > tr > th > a,
        .table.table-border > tbody > tr > td > a,
        .table.table-border > tfoot > tr > th > a,
        .table.table-border > tfoot > tr > td > a{
            text-decoration : none;
             color: #546583;
        }
        .pagination a {
            color:gray;
            text-decoration: none;
            display: inline-block;
            padding:0.5rem;
            min-width: 2.5rem;
            text-align: center;
            border:1px solid transparent;
        }
        .pagination a:hover,/*마우스 올라감*/
        .pagination .on {/*활성화 */
            border:1px solid gray;
            color:black;
        }
        
        .font-header {

	font-family: arcadeclassic;
	font-size: 35px;
	color: #85BCE1;
}

.font-header2 {

	font-family: arcadeclassic;
	font-size: 20px;
	color: white;
}


.font_han{
	font-family: DungGeunMo;
	font-weight:bold;
}

thead tr {
    background-color: #85BCE1;
    color: #ffffff;
  }
        
</style>    
<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">
	<article>
	<div class="font-header">
	<h3>NOTICE</h3>
	</div>
	<%if(isAdmin){ %>
		<div class="right">
				<a href="write.jsp">
					<input class="form-btn form-inline2" type="button" value="글쓰기">
				</a>
		</div>
	<%} %>
	<div class="row today-wrap"><div class="row-empty">
	</div></div>
	</article>
	
	<form action="list.jsp" method="get">
	<table class="table table-border2 table-hover">
	
		<thead>
			<tr align="center" class= "font_header2">
				<th width="10%" >No</th>
				<th  width="40%">Title</th>
				<th width="10%">Writer</th>
				<th width="10%" >Date</th>
				<th width="10%">Read</th>
			</tr>
		</thead>
		
		<tbody align="center"> 
			<% for(NoticeDto ndto : list) { %>
			<tr>	
			<%MemberDto mdto = ndao.getWriter(member_no);%>
				<td class="font_han"><%=ndto.getNotice_no()%></td>
			<td class="left">
				<a class="font_han" href="content.jsp?notice_no=<%=ndto.getNotice_no()%>">
					<%=ndto.getNotice_title()%>
				</a>
			</td>
				<%if(user!=null){ %>
				<td class="font_han"><%=user.getMember_nick()%></td>
				<%} %>
				<td class="font-han"><%=ndto.getNotice_auto()%></td>
				<td class="font-han"><%=ndto.getNotice_read()%></td>
			</tr>
			<%}%>
		</tbody>	
		<tfoot>		
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