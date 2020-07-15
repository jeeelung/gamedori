
<%@page import="java.util.ArrayList"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
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
    </style>


<% 

String type = request.getParameter("type");
String keyword=request.getParameter("keyword");


boolean isSearch= type != null && keyword !=null;


EventboardDao edao = new EventboardDao();
List<EventboardDto> list;

//페이지 네비게이터 계산코드
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

int finish= pageNo* pageSize;
int start = finish-(pageSize -1);

int blockSize = 5;
int startBlock = (pageNo-1)/blockSize*blockSize +1;
int finishBlock=startBlock + blockSize -1;

//페이지 개수
int count;
if(isSearch){
	
	count = edao.getCount(type, keyword);
}

else{
	
	count=edao.getCount();
}
int pageCount = (count+pageSize -1)/pageSize;






if(finishBlock > pageCount){
	finishBlock = pageCount;
}

if(isSearch){
	list=edao.search(type, keyword, start, finish);
}
else{
	list= edao.getList(start, finish);
}
%>
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

<article class="w-90">


	<!-- 제목 -->
	<div>
		<h1 class="font-header">Event Board</h1>
	</div>
	
	<!-- 글쓰기 버튼 -->
	<div class="row right">
		<a href="EventBoardWrite.jsp">
			<input class="form-btn form-inline" type="button" value="글쓰기">
		</a>
	</div>
	
	<!-- 글 목록 -->
	<div class="row">
	
		<!-- 테이블 -->
		<table border="1" width="90%" class=" table table1-stripe table-border  table-hover" >
			<thead>
				<tr aling="center" >
					<th class= "font_han">번호</th>
					<th class= "font_han" width="40%">제목</th>
					<th class= "font_han">작성자</th>
					<th class= "font_han" >작성일</th>
					<th class= "font_han" >조회수</th>
				</tr>
			</thead>
			<tbody align="center">
				<%-- list의 데이터를 하나하나 edto라는 이름으로 접근하여 출력 --%>
				<%for(EventboardDto edto : list){ %>
				<tr>
				
					<td class= "font_han"><%=edto.getEvent_no()%></td>
					<td class="left">
					
					
					
					<!-- 게시글 제목 -->
					<a href="Eventcontent.jsp?event_no=<%=edto.getEvent_no() %>">
					<%=edto.getEvent_title() %>
					</a>
					
						
					</td>
					<%MemberDto mdto = edao.getWriter(edto.getMember_no()); %>
					<td class= "font_han" ><%=mdto.getMember_nick() %></td>
					<td class= "font_han" ><%=edto.getEvent_date() %></td>
					<td class= "font_han" ><%=edto.getEvent_read() %></td>
					
				</tr>
				<%} %>
			</tbody>
		
		<tfoot>
			<tr>
				<td colspan="5" align="right">
					<a href="EventBoardWrite.jsp">
						<input type="button" value="글쓰기">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
	
	<!-- 페이지 네비게이터 -->
	<h6 align="center">
	<!-- 이전 -->
	<%if(startBlock >1){ %>
	<%if(!isSearch){ %>
	<a class = "arrow-left"  href = "event_list.jsp?page=<%=startBlock -1 %>">[이전]</a>
	<%}else{ %>
	<a href = "event_list.jsp?page=<%=startBlock -1 %>& type=<%=type %> & keyword=<%=keyword %>">다음</a>
	<%} %>
	<%} %>
	
	<%for(int i=startBlock; i<=finishBlock; i++) {%>
	
	<% if(!isSearch){%>
	<a href="event_list.jsp?page=<%=i %>"><%=i %></a>
	<% }else{%>
	<a href="event_list.jsp?page=<%=i%> & type=<%=type %> & keyword=<%=keyword %>"><%=i %></a>
	<%} %>
	<%} %>
	
	<%if(pageCount > finishBlock){ %>
	<%if(!isSearch){ %>
	<a class="arrow-right" href = "event_list.jsp?page=<%=finishBlock +1 %>">[다음]</a>
	<%}else{ %>
	<a href = "event_list.jsp?page=<%=finishBlock +1 %>& type=<%=type %> & keyword=<%=keyword %>">다음</a>
	<%} %>
	<%} %>
	</h6>
	<!-- 검색창 -->
	<div class="row center">
	
		<form action="event_list.jsp" method="get">
			<!-- 검색분류 -->
			<select class="form-input form-inline1" name="type" style= "backgroun">
				<option value="event_title">제목</option>
			
			</select>
			
			<!-- 검색어 -->
			<input class="form-input form-inline1" type="text" name="keyword" 
			 required>
			 
			<!-- 전송버튼 -->
			<input class="form-btn form-inline" type="submit" value="검색">
		</form>
		
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>