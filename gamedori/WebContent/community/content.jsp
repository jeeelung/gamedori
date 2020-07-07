<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommunityDao cdao = new CommunityDao();
	int commu_no = Integer.parseInt(request.getParameter("commu_no"));
	CommunityDto cdto = cdao.get(commu_no);
	MemberDto mdto = cdao.getWriter();
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form>
		<h2>게시글 상세보기</h2>
		<table align="center">
			<thead>
				<tr>
					<!-- 말머리 및 제목 -->
					<th>
						[<%=cdto.getCommu_head()%>]<%=cdto.getCommu_title()%>
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
			</thead>
			<tbody>
				<tr>
					<!-- 게시물 내용 -->
					<th><%=cdto.getCommu_content()%></th>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="commu_file" multiple accept=".jpg,.png,.gif">
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center" >
					<td colspan="2">
						<input type="button" value="임시저장">
						<input type="button" value="미리보기">
						<input type="submit" value="확인">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>