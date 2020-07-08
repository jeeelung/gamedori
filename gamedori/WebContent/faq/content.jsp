<%@page import="gamedori.beans.dto.FAQFileDto"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dao.FAQFileDao"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dto.FAQDto"%>
<%@page import="gamedori.beans.dao.FAQDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	FAQDao fdao = new FAQDao();
	
	int faq_no = Integer.parseInt(request.getParameter("faq_no"));
	FAQDto fdto = fdao.get(faq_no);
	MemberDto mdto = fdao.getWriter(fdto.getMember_no());
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>FAQ</h2>

	<!-- 테이블에 글 정보를 출력 -->
	<table align="center">
		<thead>
			<tr>
				<th>
					<%
						if (fdto.getFaq_head() != null) {
					%> <!-- 말머리는 있을 경우만 출력 --> [<%=fdto.getFaq_head()%>] <%}%> <%=fdto.getFaq_title()%></th>
			</tr>
			<tr>
				<th>
					<!-- 작성자 --> <%if (mdto != null) {%> <%=mdto.getMember_nick()%> <font color="gray"><%=mdto.getMember_auth() %></font> 
					<%} else {%>
					<font color="gray">탈퇴한 사용자</font><%} %>
				</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=fdto.getFaq_content() %></td>
			</tr>
			<tr>
			<th>첨부파일</th>
				<td>
				<input type="file" name="faq_file" multiple accept=".jpg, .png, .gif">
				</td>
			</tr>
		</tbody>
		<!-- 각종 버튼들 구현 -->
		<tfoot>
			<tr align="center">
				<td colspan="2">
				<input type="button" value="임시저장">
				<input type="button" value="미리보기">
				<input type="submit" value="확인">
				</td>
			</tr>
		</tfoot>
	</table>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>