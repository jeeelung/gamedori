<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	EventboardDao edao = new EventboardDao();
	int event_no = Integer.parseInt(request.getParameter("event_no"));
	
	// 번호에 맞는 게시물 정보 불러오기
	
	
	// 조회수 계산
//	- session에 memory라는 저장소 정보를 추출한다 (없을 수도 있으므로)
	Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
//	- memory가 없을 경우에는 "게시물을 아예 처음 읽는 경우"이므로 저장소 생성
	if(memory == null){
		memory = new HashSet<>();
	}
	
// 	- memory에 현재 글 번호를 저장
	boolean isFirst = memory.add(event_no);
//	System.out.println(memory);
	session.setAttribute("memory", memory);
	
	// event_no를 이용하여 조회수를 증가시킨다
	// 반드시 BoardDto 를 가져오기 전에 증가시켜야 함
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	if(isFirst){
		edao.plusReadcount(event_no, user.getMember_no());	// 내 글에는 조회수가 올라가면 안되므로 아이디를 함께 전달
	}
	EventboardDto edto = edao.get(event_no);
	// 작성자 정보 불러오기
	System.out.println(edto);
	MemberDto mdto = edao.getWriter(edto.getMember_no());
	
	// 권한 확인
	boolean isAdmin = user.getMember_auth().equals("관리자");
	boolean isMine = user.getMember_id().equals(mdto.getMember_id());
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form>
		<h2>게시글 상세보기</h2>
		<table align="center">
			<thead>
				<tr>
					<!-- 제목 -->
					<th>
					<%=edto.getEvent_title()%>
					</th>
				</tr>
				<tr>
					<!-- 작성자 및 권한 -->
					<th>
						작성자
						<%if(mdto != null) {%>
						<%=mdto.getMember_nick()%> <font color="gray"><%=mdto.getMember_auth()%></font>
						<%} else {%>
						<font color="gray">탈퇴한 사용자</font>
						<%}%>
					</th>
				</tr>
				<tr>
					<td>
					<%=edto.getEventboard_autotime() %>
					조회 
					<%=edto.getEvent_read() %>
						
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<!-- 게시물 내용 -->
					<td><%=edto.getEvent_content() %></td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="event_file" multiple accept=".jpg,.png,.gif">
					</td>
				</tr>
			</tbody>
			
		</table>
		<br>
		<a href="EventBoardWrite.jsp">
			<input type="submit" value="글쓰기">
		</a>
		<a href="EventBoardWrite.jsp?super_no=<%=event_no%>">
			<input type="button" value="답글">
		</a>
		<%if(isAdmin || isMine){%>
		<a href="EventEdit.jsp?event_no=<%=event_no%>">
			<input type="submit" value="수정">
		</a>
		<a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/eventboard/delete.do?event_no=<%=event_no%>">
			<input type="submit" value="삭제">
		</a>
		<%}%>
		<a href="event_list.jsp">
			<input type="submit" value="목록으로">
		</a>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>