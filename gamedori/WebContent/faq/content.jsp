<%@page import="gamedori.beans.dto.FilesDto"%>
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
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	//faq_no를 이용하여 faqdto를 얻어냄.
	FAQDto fdto = fdao.get(faq_no);
	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.get(fdto.getMember_no());
	boolean isAdmin = user.getMember_auth().equals("관리자");
	boolean isMine = user.getMember_id().equals(mdto.getMember_id());
	FAQFileDao ffdao = new FAQFileDao();
	List<FilesDto> fileList = ffdao.getList(faq_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
<form>
	<h2>FAQ</h2>
	<!-- 테이블에 글 정보를 출력 -->
	<table border="1" width="60%">
		<tbody align="left" align="top">
			<tr>
			<th>제목</th>
				<th>
					<%
						if (fdto.getFaq_head() != null) {
					%> <!-- 말머리는 있을 경우만 출력 --> [<%=fdto.getFaq_head()%>] <%}%>
					 <%=fdto.getFaq_title()%>
				</th>	
			</tr>
			<tr>
			<th>작성자</th>
				<th>
					<!-- 작성자 --> <%if (mdto != null) {%> 
					<%=mdto.getMember_nick()%>
					 <font color="gray" ><%=mdto.getMember_auth() %></font>
					  <%} else {%> <font color="gray">탈퇴한 사용자</font>
					<%} %>
				</th>
			</tr>
			<td>내용</td>
				<td valign="top"><%=fdto.getFaq_content() %></td>
			</tr>
			<%if(!fileList.isEmpty()){ %>
			<tr>
				<th>첨부파일</th>
				<td>
					<ul>
						<%for(FilesDto filesdto : fileList) {%>
						<li><%=filesdto.getFile_name() %> (<%=filesdto.getFile_size() %>bytes) 
						<a href="download.do?file_no=<%=filesdto.getFile_no() %>"><input type="button" value="다운로드"> 
						<input type="file" name="faq_file" multiple accept=".jpg, .png, .gif"> 
						</a>
						</li>
						<%} %>
					</ul>
				</td>
			</tr>
			<%} %>
		</tbody>
		<!-- 각종 버튼들 구현 -->
		<tfoot>
			<tr align="center">
				<td><a href="write.jsp"> <input type="button" value="글쓰기"></a>
				  <%if(isAdmin || isMine){ %>
					  <a href="edit.jsp?faq_no=<%=faq_no %>"><input type="button" value="수정"></a> 
					  <a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/faq/delete.do?faq_no=<%=faq_no%>">
					  <input type="button" value="삭제"></a>
				  <%} %>
				<a href="list.jsp"><input type="button" value="목록으로"></a><br><br>
				</td>
			</tr>
		</tfoot>
	</table>
	<br>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>