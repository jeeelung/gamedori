<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.FAQDao"%>
<%@page import="gamedori.beans.dto.FAQDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.FAQDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	/FAQ/list.jsp : 게시판 목록 겸 검색 페이지
 -->

<%
	//이 페이지를 출력하기 위한 프로그래밍 처리
	//1. 준비물(입력) : 검색창의 입력값 - type, keyword (둘다 있으면 검색)
	//2. 처리
	//		- isSearch라는 변수에 검색인지 아닌지 판정하여 저장
	//		- isSearch의 값에 따라 "목록" 또는 "검색" 결과를 저장
	//3. 결과물(출력) : 게시글 리스트 - List<FAQDto>

	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");

	boolean isSearch = type != null && keyword != null;
	int pageSize = 10;//한 페이지에 표시할 데이터 개수

	//page 번호를 계산하기 위한 코드
	// - 이상한 값은 전부다 1로 변경
	// - 멀쩡한 값은 그대로 숫자로 변환
	String pageStr = request.getParameter("page");
	int pageNo;
	try {
		pageNo = Integer.parseInt(pageStr);
		if (pageNo <= 0) {
			throw new Exception();
		}
	} catch (Exception e) {
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

	FAQDao fdao = new FAQDao();

	//(주의!) 다음 버튼의 경우 계산을 통하여 페이지 개수를 구해야 출력 여부 판단이 가능
	//int count = 목록개수 or 검색개수;
	int count;
	if (isSearch) {//검색
		count = fdao.getCount(type, keyword);
	} else {//목록
		count = fdao.getCount();
	}
	int pageCount = (count + pageSize - 1) / pageSize;
	//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
	if (finishBlock > pageCount) {
		finishBlock = pageCount;
	}

	// 	List<FAQDto> list = 목록 or 검색;
	List<FAQDto> list;
	if (isSearch) {
		list = fdao.search(type, keyword, start, finish);
	} else {
		list = fdao.getList(start, finish);
	}
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	MemberDao mdao = new MemberDao();
	boolean isAdmin;
	boolean isMine;
	if(user==null){
		isAdmin = false;
		isMine = false;
	}else {
	isAdmin = user.getMember_auth().equals("관리자");
	isMine = user.getMember_id().equals(user.getMember_id());		
	}
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
	border-top: 3px solid #20639B;
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
            border:2px solid #20639B;
             color:dodgerblue;
            
        }
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td > a,
        .table.table-border > tbody > tr > th > a,
        .table.table-border > tbody > tr > td > a,
        .table.table-border > tfoot > tr > th > a,
        .table.table-border > tfoot > tr > td > a{
            text-decoration : none;
             color:dodgerblue;
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
        
</style>

<div align="center">

	<!-- 제목 -->
	<article>
	<div class="font-game">
	<h3>F A Q</h3>
	</div>
	<div class="row today-wrap"><div class="row-empty"></div>
	</article>
	<div class="right">
	<%if(isAdmin && isMine){ %>
	<a href="write.jsp"><input class="form-btn form-inline" type="button" value="글쓰기">
	</a>
	<%} %>
	</div>
	<!-- 테이블 -->
	<table class="table table-border table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th width="70%">제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody align="">
			<%-- list의 데이터를 하나하나 fdto라는 이름으로 접근하여 출력 --%>
				<%
					for (FAQDto fdto : list) {
				%>
			<tr>
				<td><%=fdto.getFaq_no()%></td>
				<td class="left">
					 <%if (fdto.getFaq_head() != null) {%> 
					 <!-- 말머리는 있을 경우만 출력 --> 
					 <font color="gray"> 
					[<%=fdto.getFaq_head()%>]
					</font>
					<%}%> 
 						<!-- 게시글 제목 --> 
 					<a href="<%=request.getContextPath()%>/faq/content.jsp?faq_no=<%=fdto.getFaq_no()%>"> 
 						<%=fdto.getFaq_title()%></a>
				</td>
					<%MemberDto mdto = fdao.getWriter(fdto.getMember_no());%>
				<td>
					<%if (mdto.getMember_nick() != null) {%> <%=mdto.getMember_nick()%> 
					<%} else {%> <font color="gray">탈퇴한 사용자</font> 
					<%}%>
				</td>
			</tr>
				<%}%>
		</tbody>
	<tfoot>
</tfoot>
</table>
<div class="right">
<%if(isAdmin && isMine){ %>
<a href="write.jsp">
<input class="form-btn form-inline" type="button" value="글쓰기">
</a>
<%} %>
</div>
	<!-- 네비게이터 -->
	<div class="row center pagination">

		<!-- 
		이전 버튼을 누르면 startBlock - 1 에 해당하는 페이지로 이동해야 한다
		(주의) startBlock이 1인 경우에는 출력하지 않는다
	 	-->
		<%if (startBlock > 1) {%>
		<%if (!isSearch) {%>
		<a href="list.jsp?page=<%=startBlock - 1%>">&lt;</a>
		<%} else {%>
		<a href="list.jsp?page=<%=startBlock - 1%>&type=<%=type%>&keyword=<%=keyword%>">&lt;</a>
			<%}%>
		<%}%>

		<!-- 
		이동 숫자에 반복문을 적용 
		범위는 startBlock부터 finishBlock까지로 설정(상단에서 계산을 미리 해두었음)
	-->
		<%for (int i = startBlock; i <= finishBlock; i++) {%>
		<%
			String prop;
			if(i == pageNo) {
				prop = "class='on'";
			}
			else{
				prop = "";
			}
		%>
		<%if (!isSearch) {%>
		<!-- 목록일 경우 페이지 번호만 전달 -->
		<a href="list.jsp?page=<%=i%>"<%=prop %>><%=i%></a>
		<%} else {%>
		<!-- 검색일 경우 페이지 번호와 검색 분류(type), 검색어(keyword)를 전달 -->
		<a href="list.jsp?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>"<%=prop %>><%=i%></a>
			<%}%>
		<%}%>

		<!-- 
		다음 버튼을 누르면 finishBlock + 1 에 해당하는 페이지로 이동해야 한다
		(주의!) 다음이 없는 경우에는 출력하지 않는다(pageCount <= finishBlock)
	 -->
		<%
			if (pageCount > finishBlock) {
		%>
		<%
			if (!isSearch) {
		%>
		<a href="list.jsp?page=<%=finishBlock + 1%>">&gt;</a>
		<%} else {%>
		<a href="list.jsp?page=<%=finishBlock + 1%>&type=<%=type%>&keyword=<%=keyword%>">&gt;</a>
		<%
				}
			}
		%>
	</div>

	<!-- 검색창 -->
	<div class="center">
	<form action="list.jsp" method="get">
		<!-- 검색분류 -->
		<select class="form-input form-inline" name="type">
			<option value="faq_title">제목만</option>
			<option value="member_nick">닉네임</option>
		</select>
		<!-- 검색어 -->
		<input class="form-input form-inline" type="text" name="keyword" required>

		<!-- 전송버튼 -->
		<input class="form-btn form-inline" type="submit" value="검색">
	</form>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>