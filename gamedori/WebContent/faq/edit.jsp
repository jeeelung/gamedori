<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.FAQFileDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.FAQDto"%>
<%@page import="gamedori.beans.dao.FAQDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	edit.jsp : 게시글 수정 페이지
	- 구조는 write.jsp와 동일하지만 차이가 있다면 글 정보가 미리 표시되어 있어야 한다
	- 정보를 표시해줘야 하기 때문에 PK(FAQ_no)가 필요하다
-->
<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo") ;
	int faq_no = Integer.parseInt(request.getParameter("faq_no"));
	FAQDao fdao = new FAQDao();
	FAQDto fdto = fdao.get(faq_no);
	FAQFileDao ffdao = new FAQFileDao();
	List<FilesDto> fileList = ffdao.getList(faq_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>FAQ 수정</h2>
	
	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden" name="faq_no" value="<%=faq_no%>">
		
		<table border="1">
		<thead>
		<tr>
		<td>
		</td>
		</tr>
		</thead>
			<tbody>
				<tr>
					<th>말머리</th>
					<td>
						<!-- 말머리는 select로 구현 -->
						<select name="faq_head">
							<option value="">말머리 선택</option>
							<option value="게임문의">게임문의</option>
							<option value="회원문의">회원문의</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="faq_title" size="50" maxlength="100" required
								value="<%=fdto.getFaq_title()%>">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="faq_content" required 
							rows="20" cols="100" maxlength="4000" ><%=fdto.getFaq_content()%></textarea>
					</td>  
				
				<th>첨부파일</th>
				<td>
				<input type="file" name="faq_file" multiple accept=".jpg, .png, .gif">
				<%for(FilesDto filesdto : fileList){ %>
					<%=filesdto.getFile_name() %>(<%=filesdto.getFile_size() %> bytes)
					 <a href="<%=request.getContextPath() %>/faq/fileDelete.do?file_no=<%=filesdto.getFile_no()%>&faq_no=<%=faq_no %>">
					  <input type="button" value="삭제">
					 </a>
					<%} %>
				</td>
				</tr>
				
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>












