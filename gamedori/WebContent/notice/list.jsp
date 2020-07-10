<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>

<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 
	/board/list.jsp : 게시판 목록 겸 검색 페이지
 -->

<%
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
	NoticeDao ndao = new NoticeDao();

	//(주의!) 다음 버튼의 경우 계산을 통하여 페이지 개수를 구해야 출력 여부 판단이 가능
	//int count = 목록개수 or 검색개수;
	int count;
	if (isSearch) {//검색
		count = ndao.getCount(type, keyword);
	} else {//목록
		count = ndao.getCount();
	}
	int pageCount = (count + pageSize - 1) / pageSize;
	//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
	if (finishBlock > pageCount) {
		finishBlock = pageCount;
	}

	//	List<BoardDto> list = 목록 or 검색;
	List<NoticeDto> list;
	if (isSearch) {
		list = ndao.search(type, keyword);
	} else {
		list = ndao.getList();
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">

	<!-- 계산한 데이터를 확인하기 위해 출력 -->
	<h5>
		pageStr =
		<%=pageStr%>, pageNo =
		<%=pageNo%>, start =
		<%=start%>
		finish =
		<%=finish%>
		<%-- 	pageCount = <%=pageCount%> --%>
		startBlock =
		<%=startBlock%>
		finishBlock =
		<%=finishBlock%>
	</h5>

	<h2>공지사항</h2>
	<form action="list.jsp" method="get">
		<table border="1" width="90%">

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
				
					<%
						for (NoticeDto ndto : list) {
					%>
					<tr>
						<%
							MemberDto mdto = ndao.getWriter(ndto.getMember_no());
						%>
						<th><%=ndto.getNotice_no()%></th>
						<td><img src="<%=request.getContextPath()%>/image/reply.PNG"
							width="20" height="15"> <!-- 제목 --> <a
							href="content.jsp?notice_no=<%=ndto.getNotice_no()%>"> <%=ndto.getNotice_title()%>
						</a></td>
						<td><%=mdto.getMember_nick()%></td>
						<td><%=ndto.getNotice_auto()%></td>
						<td><%=ndto.getNotice_read()%></td>
					</tr>
					<%
						}
					%>

				</tbody>

				<tfoot>
					<tr>
						<td colspan="8" align="right"><a href="write.jsp"> <input
								type="button" value="글쓰기">
						</a></td>
					</tr>
				</tfoot>
			</table>
			<!-- 검색창 -->
			<select name="type">
				<option value="commu_title">제목만</option>
				<option value="commu_content">내용만</option>
				<option value="member_no">글작성자</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어를 입력하세요" required>
			<input type="submit" value="검색">
			</form>
			</div>
			<jsp:include page="/template/footer.jsp"></jsp:include>