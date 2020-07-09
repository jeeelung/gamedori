<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.QnaDao"%>
<%@page import="gamedori.beans.dto.QnaDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
	//이 페이지를 출력하기 위한 프로그래밍 처리
	//1. 준비물(입력) : 검색창의 입력값 - type, keyword (둘다 있으면 검색)
	//2. 처리
	//		- isSearch라는 변수에 검색인지 아닌지 판정하여 저장
	//		- isSearch의 값에 따라 "목록" 또는 "검색" 결과를 저장
	//3. 결과물(출력) : 게시글 리스트 - List<QnaDto>
	
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	boolean isSearch = type != null && keyword != null;
	
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
	
	
	QnaDao qdao = new QnaDao();
	
	//(주의!) 다음 버튼의 경우 계산을 통하여 페이지 개수를 구해야 출력 여부 판단이 가능
	//int count = 목록개수 or 검색개수;
	int count;
	if(isSearch){//검색
		count = qdao.getCount(type, keyword); 
	}
	else{//목록
		count = qdao.getCount();
	}
	int pageCount = (count + pageSize - 1) / pageSize;
	//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
	if(finishBlock > pageCount){
		finishBlock = pageCount;
	}
	
	
// 	List<QnaDto> list = 목록 or 검색;
	List<QnaDto> list;
	if(isSearch){
		list = qdao.search(type, keyword, start, finish); 
	}
	else{
		list = qdao.getList(start, finish); 
	}
%> 
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	
	<!-- 제목 -->
	<h2>문의 게시판</h2>
	
	<!-- 테이블 -->
	<table border="1" width="90%">
		<thead>
			<tr>
				<th>번호</th>
				<th width="40%">제목</th>
				<th>작성자</th>
				<th>이메일</th>
				<th>작성일</th>
			
			</tr>
		</thead>
		<tbody align="center">
			<%for(QnaDto qdto : list){ %>
		<% MemberDto mdto=qdao.getWriter(qdto.getMember_no());%>	
			<tr>
				<td><%=qdto.getQna_no()%></td>
				<td align="left">
				
					<%if(qdto.getQna_depth() > 0){ %>
						<%for(int i=0; i < qdto.getQna_depth(); i++){ %>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<%} %>
					
						<img src="<%=request.getContextPath()%>/image/reply.png"
							width="20" height="15">
					<%} %>
				
					<%if(qdto.getQna_head() != null){ %>
						<!-- 말머리는 있을 경우만 출력 -->
						<font color="gray">
						[<%=qdto.getQna_head()%>]
						</font>
					<%} %>
					
					<!-- 게시글 제목 -->
					<a href="qna_content.jsp?qna_no=<%=qdto.getQna_no()%>">
						<%=qdto.getQna_title()%>
					</a>
					
				</td>
				<td>
						<%if(mdto != null) {%>
						<%=mdto.getMember_nick()%> <font color="gray"><%=mdto.getMember_auth()%></font>
						<%} else {%>
						<font color="gray">탈퇴한 사용자</font>
						<%}%>
				</td>
				<td><%=qdto.getQna_email()%></td>
				<td><%=qdto.getQna_date()%></td>
			</tr>
			<%} %>
				
			
		</tbody>
		
		<tfoot>
			<tr>
				<td colspan="8" align="right">
					<a href="qna_write.jsp">
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
			<a href="qna_list.jsp?page=<%=startBlock-1%>">[이전]</a>
		<%}else{ %>
			<a href="qna_list.jsp?page=<%=startBlock-1%>&type=<%=type%>&keyword=<%=keyword%>">[이전]</a>
		<%} %>
		
	<%} %>
	
	<%for(int i=startBlock; i <= finishBlock; i++){ %>
		<%if(!isSearch){ %>
		<!-- 목록일 경우 페이지 번호만 전달 -->
		<a href="qna_list.jsp?page=<%=i%>"><%=i%></a>
		<%}else{ %>
		<!-- 검색일 경우 페이지 번호와 검색 분류(type), 검색어(keyword)를 전달 -->
		<a href="qna_list.jsp?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
		<%} %>
	<%} %>
	
	<%if(pageCount > finishBlock){ %>
		<%if(!isSearch){ %> 
			<a href="qna_list.jsp?page=<%=finishBlock + 1%>">[다음]</a>
		<%}else{ %>
			<a href="qna_list.jsp?page=<%=finishBlock + 1%>&type=<%=type%>&keyword=<%=keyword%>">[다음]</a>
		<%} %>
	<%} %>
	</h4>
	
	<!-- 검색창 -->
	<form action="qna_list.jsp" method="get">
		<!-- 검색분류 -->
		<select name="type">
			<option value="board_title">제목</option>
			<option value="board_writer">작성자</option>
		</select>
		
		<!-- 검색어 -->
		<input type="text" name="keyword" required>
		 
		<!-- 전송버튼 -->
		<input type="submit" value="검색">
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
