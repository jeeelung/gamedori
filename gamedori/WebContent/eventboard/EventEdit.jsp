<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.EventFileDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>

<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	
-->
<%
	MemberDto mdto= (MemberDto)session.getAttribute("userinfo");
	int event_no = Integer.parseInt(request.getParameter("event_no"));
	EventboardDao edao = new EventboardDao();
	EventboardDto edto = edao.get(event_no);
	
	EventFileDao efdao = new EventFileDao();
	List<FilesDto> fileList = efdao.getList(event_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h2>게시글 수정</h2>
<!-- enctype="multipart/form-data" -->
	<!-- 게시글 전송 폼 -->
	<form action="eventedit.do" method="post" enctype="multipart/form-data">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden" name="event_no" value="<%=event_no%>">
		
		<table border="1">
			<tbody>
				<tr>
					<th>제목</th>
					<td>
					
						<input type="text" name="event_title" size="70" required
								value="<%=edto.getEvent_title()%>">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						
						<textarea name="event_content" required 
							rows="15" cols="72"><%=edto.getEvent_content()%></textarea>
					</td>  
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="event_file" multiple accept=".jpg,.png,.gif">
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<ul>
							<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
							<%for(FilesDto fdto : fileList){%>
							<li>
								<%=fdto.getFile_name()%>
								(<%=fdto.getFile_size()%> bytes)
								<a href="<%=request.getContextPath()%>/eventboard/filedelete.do?file_no=<%=fdto.getFile_no()%>&event_no=<%=event_no%>">
									<input type="button" value="삭제">
								</a>
							</li>
							<%}%>
						</ul>
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
