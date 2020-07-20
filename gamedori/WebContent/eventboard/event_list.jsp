
<%@page import="java.util.ArrayList"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">

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

MemberDto user = (MemberDto)session.getAttribute("userinfo");

%>
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

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

<div align="center">

	<!-- 제목 -->
	<article>
	<div class="font-header">
	<h3>Check Our Event</h3>
	</div>
	<div class="row today-wrap"><div class="row-empty"></div>
	</article>
	<div class="right">
	<%if(user != null) {
						boolean isAdmin = user.getMember_auth().equals("관리자");
					
 						if (isAdmin) { %>
		<a href="EventBoardWrite.jsp">
			<input class="form-btn form-inline" type="button" value="글쓰기">
		</a>
	<%} %>
	<%} %>
	</div>
	
	<!-- 글 목록 -->

	
		<!-- 테이블 -->
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
				<%-- list의 데이터를 하나하나 edto라는 이름으로 접근하여 출력 --%>
				<%for(EventboardDto edto : list){ %>
				<tr>
				
					<td class= "font_han"><%=edto.getEvent_no()%></td>
					<td class="left">
					
					
					
					<!-- 게시글 제목 -->
					<a class= "font_han" href="Eventcontent.jsp?event_no=<%=edto.getEvent_no() %>">
					<%=edto.getEvent_title() %>
					</a>
					
						
					</td>
					<%MemberDto mdto = edao.getWriter(edto.getMember_no()); %>
					<td class= "font_han" ><%=mdto.getMember_nick() %></td>
					<td class= "font_han" ><%=edto.getEvent_auto() %></td>
					<td class= "font_han" ><%=edto.getEvent_read() %></td>
					
				</tr>
				<%} %>
			</tbody>
		
		<tfoot>
			<tr>
				<td colspan="5" align="center">
				<%if(user != null) {
						boolean isAdmin = user.getMember_auth().equals("관리자");
					
 						if (isAdmin) { %>
					<a  href="EventBoardWrite.jsp">
						<input class="form-btn form-inline2" type="button" value="글쓰기">
					</a>
				<%} %>
	<%} %>
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
			<input class="form-input form-inline1" type="text" name="keyword" placeholder="검색어를 입력하시요" 
			 required>
			 
			<!-- 전송버튼 -->
			<input class="form-btn form-inline3" type="submit" value="검색">
		</form>
		
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>