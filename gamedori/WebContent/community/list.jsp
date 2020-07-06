<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<h2></h2>
	<form action="list.jsp" method="get">
	<table border="1" width="90%" align="center">
	
		<thead>
			<tr>
				<th>
					<select name="board_head">
						<option>전체보기</option>
						<option>정보</option>
						<option>유머</option>
						<option>공지</option>
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
				<th>번호</th>
				<td>[말머리]제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
		</tbody>
		
		<tfoot>
		</tfoot>
	</table>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>