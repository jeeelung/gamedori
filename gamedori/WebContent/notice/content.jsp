<%@page import="gamedori.beans.dto.NoticeFileDto"%>
<%@page import="java.util.List"%>
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
