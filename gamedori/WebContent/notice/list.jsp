<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>

<%@page import="gamedori.beans.dao.NoticeDao"%>
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
	
	
%>
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<!-- 계산한 데이터를 확인하기 위해 출력 -->
	<h3>
		type = <%=type%>,
		keyword = <%=keyword%>,
		isSearch = <%=isSearch%>
	</h3>
	
	
	<!-- 제목 -->
	<h2>공지사항</h2>
	
	<!-- 테이블 -->
	<table border="1" width="90%">
		<thead>
			<tr>
				<th>번호</th>
				<th width="40%">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			
				
			</tr>
		</thead>
		<tbody align="center">
			
				<td align="left">
				
					<!-- 
						답글은 띄어쓰기 구현
						- 답글인 경우는 super_no > 0 , depth > 0 
					-->
			
				</td>
							
						</tbody>
		
		<tfoot>
			<tr align="center">
				<td colspan="8" align="center">
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
	
	
	<!-- 
		이동 숫자에 반복문을 적용 
		범위는 startBlock부터 finishBlock까지로 설정(상단에서 계산을 미리 해두었음)
	-->
	
	
	<!-- 
		다음 버튼을 누르면 finishBlock + 1 에 해당하는 페이지로 이동해야 한다
		(주의!) 다음이 없는 경우에는 출력하지 않는다(pageCount <= finishBlock)
	 -->
	
	
	<!-- 검색창 -->
	<form action="list.jsp" method="get">
		<!-- 검색분류 -->
		<select name="type">
			<option value="notice_title">제목만</option>
			<option value="board_writer">글작성자</option>
		</select>
		
		<!-- 검색어 -->
		<input type="text" name="keyword" required>
		 
		<!-- 전송버튼 -->
		<input type="submit" value="검색">
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
    