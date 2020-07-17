<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.QnaFileDao"%>
<%@page import="gamedori.beans.dto.QnaDto"%>
<%@page import="gamedori.beans.dao.QnaDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	edit.jsp : 게시글 수정 페이지
	- 구조는 write.jsp와 동일하지만 차이가 있다면 글 정보가 미리 표시되어 있어야 한다
	- 정보를 표시해줘야 하기 때문에 PK(board_no)가 필요하다
-->

<%
	int qna_no = Integer.parseInt(request.getParameter("qna_no"));
	QnaDao qdao = new QnaDao();
	QnaDto qdto = qdao.get(qna_no);
	QnaFileDao qfdao = new QnaFileDao();
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	List<FilesDto> fileList = qfdao.getList(qna_no);
	
	// 권한 확인
	boolean isAdmin = user.getMember_auth().equals("관리자");
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>문의글 답변</h2>
	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post" enctype="multipart/form-data">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<%if(qdto.getQna_head()==null){ %>
		<input type="hidden" name="qna_head" value=""> 
		<%} %>
		<input type="hidden" name="qna_head" value="<%=qdto.getQna_head()%>"> 
		<input type="hidden" name="qna_title" value="<%=qdto.getQna_title()%>"> 
		<input type="hidden" name="qna_content" value="<%=qdto.getQna_content()%>"> 
		<input type="hidden" name="qna_email" value="<%=qdto.getQna_email()%>"> 
		<input type="hidden" name="qna_no" value="<%=qna_no%>">
		
		<table border="1">
			<tbody>
					<tr>
						<th>분류</th>
					<td>	<%if(qdto.getQna_head() != null){ %>
					<!-- 말머리는 있을 경우만 출력 -->
					[<%=qdto.getQna_head()%>]
					</td>
			<%} %>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
								<%=qdto.getQna_title()%>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td width ="50" height="100">
					<%if(qdto.getQna_content()==null){ %>
								정성을 다해 답변하시오.
						<%}else{%>
						<%=qdto.getQna_content()%>
					<%} %>			
						</td>  
				</tr>
				<tr>
					<th>이메일</th>
					<td>
								<%=qdto.getQna_email()%>
					</td>
				</tr>
				<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
				<%if(!fileList.isEmpty()){%>
				<tr>
					<th colspan="5">첨부파일</th>
				</tr>							
				<tr height="100" >
					<td colspan="5">
						첨부파일 목록
						<ul>
							<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
							<%for(FilesDto fdto : fileList){%>
							<li>
								<%=fdto.getFile_name()%>
								(<%=fdto.getFile_size()%> bytes)
								<!-- 다운로드 버튼을 누른다면 해당 파일을 다운로드 할 수 있도록 링크 -->
								
								<a href="download.do?file_no=<%=fdto.getFile_no()%>">
									<input type="button" value="다운로드">
								</a>
							</li>
							<%}%>
						</ul>
					</td>
				</tr>
				<%} %>
				<tr>
					<th>답변</th>
					<td>
						<textarea name="qna_answer" required 
							rows="15" cols="72"><%=qdto.getQna_answer() %></textarea>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="qna_file" multiple accept=".jpg, .png, .gif">
					</td>
				</tr>
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="답변하기">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>