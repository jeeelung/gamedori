<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	boolean isSearch = type != null && keyword != null;
	
	CommunityDao cdao = new CommunityDao();
	List<CommunityDto> list;
	if(isSearch){
		list = cdao.search(type, keyword);
	} else {
		list = cdao.getList();
	}
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">
	<h2></h2>
	<form action="list.jsp" method="get">
	<table border="1" width="90%">
	
		<thead>
			<tr>
				<th>
					<select name="commu_head">
						<option value="">전체보기</option>
						<option>자유</option>
						<option>유머</option>
						<option>공략</option>
					</select>
				</th>
				<th width="50%">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		
		<tbody>
			<%
			System.out.println(list.size());
			for(CommunityDto cdto : list) { %>
			<tr>
				<%MemberDto mdto = cdao.getWriter(cdto.getMember_no());%>
				<th><%=cdto.getCommu_no()%></th>
				<td>
					<%if(cdto.getCommu_super_no() > 0){ %>
						<%for(int i=0; i<cdto.getCommu_depth(); i++) {%>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<%}%>
					<img src="<%=request.getContextPath()%>/image/reply.PNG"
							width="20" height="15">
					<%}%>
					<a href="<%=request.getContextPath()%>/community/content.jsp?commu_no=<%=cdto.getCommu_no()%>">
					[<%=cdto.getCommu_head()%>]<%=cdto.getCommu_title()%>
					</a>
				</td>
				<td><%=mdto.getMember_nick()%></td>
				<td><%=cdto.getCommu_auto()%></td>
				<td><%=cdto.getCommu_read()%></td>
			</tr>
			<%}%>
		</tbody>
		
		<tfoot>
			<tr align="right">
				<td colspan="5" align="right">
					<a href="write.jsp">
						<input type="button" value="글쓰기">
					</a>
				</td>
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