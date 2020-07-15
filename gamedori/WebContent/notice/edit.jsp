<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.NoticeFileDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo");
	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
	NoticeDao ndao = new NoticeDao();
	NoticeDto ndto = ndao.get(notice_no);

	NoticeFileDao nfdao = new NoticeFileDao();
	List<FilesDto> fileList = nfdao.getList(notice_no);
	
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>공지사항 게시글 수정</h2>

	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post" enctype="multipart/form-data">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden"name="notice_no"value="<%=notice_no%>">

		<table border="1">
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="notice_title"size="70" required
						value="<%=ndto.getNotice_title()%>">
						
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="left" valign="top">
						<textarea rows="20" cols="100" maxlength="4000" name="notice_content" required><%=ndto.getNotice_content()%></textarea>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="notice_file" multiple accept=".jpg,.png,.gif">
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
								<a href="<%=request.getContextPath()%>/notice/fileDelete.do?
								file_no=<%=fdto.getFile_no()%>&notice_no=<%=notice_no%>">
									<input type="button" value="삭제">
								</a>
							</li>
							<%}%>
						</ul>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center" >
					<td colspan="2">
						<input type="submit" value="수정">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
