<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommunityDao cdao = new CommunityDao();
	List<CommunityDto> list = cdao.getList();
%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<h2></h2>
	<form action="list.jsp" method="get">
	<table border="1" width="90%" align="center">
	
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
			<tr>
			<%for(CommunityDto cdto : list) { %>
				<th><%=cdto.getCommu_no()%></th>
				<td>
					<a href="<%=request.getContextPath()%>/community/content.jsp?commu_no=<%=cdto.getCommu_no()%>">
					[<%=cdto.getCommu_head()%>]<%=cdto.getCommu_title()%>
					</a>
				</td>
				<%MemberDto mdto = cdao.getWriter(cdto.getMember_no());%>
				<td><%=mdto.getMember_nick()%></td>
				<td><%=cdto.getCommu_auto()%></td>
				<td><%=cdto.getCommu_read()%></td>
			<%}%>
			</tr>
		</tbody>
		
		<tfoot>
		</tfoot>
	</table>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>