<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	int notice_no = Integer.parseInt(request.getParameter("notice_no"));

	NoticeDao ndao = new NoticeDao();
	NoticeDto ndto = ndao.get(notice_no);
	
	
	//첨부파일 불러오는 코드 
	NoticeFileDao bfdao = new NoticeFileDao();
	List<NoticeFileDto> fileList = nfdao.getList(notice_no);




%>     

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	<h2>공지사항 상세보기</h2>

	<!-- 테이블에 글 정보를 출력 -->
	<table border="1" width="60%">
		<tbody>
			<tr>
				<td>
					<font size="6">										
					<%=ndto.getNotice_title()%>
					</font>
				</td>
			</tr>
			<tr>
				<td>
					<!-- 작성자 -->
				<%=ndto.getMember_no()%>
				</td>
			</tr>
			<tr>
				<td>
					<%=ndto.getNotice_date()%>
					조회 <%=ndto.getNotice_read()%>
				</td>
			</tr>
			
			<!-- 게시글 내용 영역 -->
			<tr height="300">
				<td valign="top">
					<%=ndto.getNotice_content()%>
				</td>  
			</tr>
				</tbody>
					</table>
					
				</td>
			</tr>
			
			<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
			<%if(!fileList.isEmpty()){ %>
			<tr>
				<td>
					첨부파일 목록
					<ul>
						<%for(BoardFileDto bfdto : fileList){ %>
						<li>
						<%=bfdto.getBoard_file_name()%>
						(<%=bfdto.getBoard_file_size()%> bytes)
						<!-- 다운로드 버튼을 누른다면 해당 파일을 다운로드 할 수 있도록 링크 -->
						<a href="download.do?board_file_no=<%=bfdto.getBoard_file_no()%>">다운로드</a>
						
						<!-- 다운로드 주소를 img 태그로 지정하면 미리보가 가능 -->
						<img src="download.do?board_file_no=<%=bfdto.getBoard_file_no()%>" width="50" height="50">
						
						</li>
						<%} %>
					</ul>
				</td>
			</tr>
			<%} %>
			
			<!-- 댓글 작성 영역 -->
			<tr>
				<td align="right">
					<form action="reply_insert.do" method="post">
						<input type="hidden" name="reply_origin" value="<%=notice_no%>">
						<textarea name="reply_content" rows="4" cols="80" placeholder="댓글 작성"></textarea>
						<br>
						<input type="submit" value="등록">
					</form>
				</td>
			</tr>
			
		</tbody>
		<!-- 각종 버튼들 구현 -->
		<tfoot>
			<tr>
				<td colspan="2" align="right">
					<a href="write.jsp">
					<input type="button" value="글쓰기">
					</a>
					
					<a href="write.jsp?notice_no=<%=notice_no%>">
					<input type="button" value="답글">
					</a>
															
					<a href="edit.jsp?notice_no=<%=notice_no%>">
					<input type="button" value="수정">
					</a>
					
					<a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/notice/delete.do?notice_no=<%=notice_no%>">
					<input type="button" value="삭제">
					</a>
									
					<a href="list.jsp">
					<input type="button" value="목록">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
