<%@page import="gamedori.beans.dao.PointHistoryDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String type = request.getParameter("type");
String keyword = request.getParameter("keyword");

MemberDto user = (MemberDto) session.getAttribute("userinfo");

boolean isMine = user.getMember_id().equals(user.getMember_id());
boolean isSearch = type != null && keyword != null;
boolean isAdmin = user.getMember_auth().equals("관리자");
String auth = user.getMember_auth();
int member_no = user.getMember_no();
// 페이지 계산 코드

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

// 페이지 네비게이터 계산 코드

int blockSize = 10;//이 페이지에는 네비게이터 블록을 10개씩 배치하겠다!
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int finishBlock = startBlock + blockSize - 1;

MemberDao mdao = new MemberDao();

//(주의!) 다음 버튼의 경우 계산을 통하여 페이지 개수를 구해야 출력 여부 판단이 가능
//int count = 목록개수 or 검색개수;
int count;
if (isSearch) {//검색
	count = mdao.getCount(type, keyword);
} else {//목록
	count = mdao.getCount();
}
int pageCount = (count + pageSize - 1) / pageSize;
//만약 finishBlock이 pageCount보다 크다면 수정해야 한다
if (finishBlock > pageCount) {
	finishBlock = pageCount;
}

List<MemberDto> list;
if (isSearch) {
	list = mdao.search(type, keyword,start,finish);
} else {
	list = mdao.list(start, finish);
}
%>
 
 
<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<!-- 제목 -->
	<h2>회원 검색</h2>
	
	<!-- 검색창 -->
	<form action="member_list.jsp" method="get">
		<!-- 분류 선택창 -->
		<select name="type">
			<option value="member_id">아이디</option>
			<option value="member_nick">닉네임</option>
			<option value="member_auth">권한</option>
		</select>
		
		<!-- 검색어 입력창 -->
		<input type="text" name="keyword" required placeholder="검색어">
		
		<!-- 검색 버튼 -->
		<input type="submit" value="검색">
		
	</form>
	
	<hr>
	
	<h4>총 <%=mdao.getCount()%> 명의 회원이 있습니다</h4>
	
	<!-- 결과 -->
	<%if(list.isEmpty()){ %>
	<h5>검색 결과가 존재하지 않습니다</h5>
	<%}else{ %>
	<table border="1" width="650">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>권한</th>
				<th>핸드폰 번호</th>
				<th>포인트</th>
				<th>가입일</th>
				<th>최종 로그인</th>
			</tr>
		</thead>
		<tbody align="center">
			<%for(MemberDto mdto : list){ %>
			<tr>
				<td><%=mdto.getMember_id()%></td>
				<td><%=mdto.getMember_name() %>
				<td><%=mdto.getMember_nick()%></td>
				<td><%=mdto.getMember_auth()%></td>
				<td><%=mdto.getMember_phone() %></td>
				<td><%=mdto.getMember_point() %></td>
				<td><%=mdto.getMember_join_date() %></td>
				<%if(mdto.getMember_login_date()!=null){%>
				<td><%=mdto.getMember_login_date() %></td>
				<%}else{ %>
					<%=System.out.print("　") %>
					<%} %>
			</tr>
			<%} %>
		</tbody>
	</table>
	<%} %>
	<!-- 
		이전 버튼을 누르면 startBlock - 1 에 해당하는 페이지로 이동해야 한다
		(주의) startBlock이 1인 경우에는 출력하지 않는다
	 -->
		<%
			if (startBlock > 1) {
		%>

		<%
			if (!isSearch) {
		%>
		<a href="member_list.jsp?page=<%=startBlock - 1%>">[이전]</a>
		<%
			} else {
		%>
		<a
			href="member_list.jsp?page=<%=startBlock - 1%>&type=<%=type%>&keyword=<%=keyword%>">[이전]</a>
		<%
			}
		%>

		<%
			}
		%>

		<%
			for (int i = startBlock; i <= finishBlock; i++) {
		%>
		<%
			if (!isSearch) {
		%>
		<!-- 목록일 경우 페이지 번호만 전달 -->
		<a href="member_list.jsp?page=<%=i%>"><%=i%></a>
		<%
			} else {
		%>
		<!-- 검색일 경우 페이지 번호와 검색 분류(type), 검색어(keyword)를 전달 -->
		<a href="member_list.jsp?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>"><%=i%></a>
		<%
			}
		%>
		<%
			}
		%>

		<%
			if (pageCount > finishBlock) {
		%>
		<%
			if (!isSearch) {
		%>
		<a href="member_list.jsp?page=<%=finishBlock + 1%>">[다음]</a>
		<%
			} else {
		%>
		<a
			href="member_list.jsp?page=<%=finishBlock + 1%>&type=<%=type%>&keyword=<%=keyword%>">[다음]</a>
		<%
			}
		%>
		<%
			}
		%>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>