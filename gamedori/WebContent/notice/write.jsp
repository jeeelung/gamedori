<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 
	write.jsp : 게시글 작성 페이지
	- 입력 항목은 2개 : notice_title, notice_content
	- 작성자는 회원정보가 자동으로 설정
 -->
<%
MemberDto mdto = (MemberDto)session.getAttribute("userinfo");


%>
 
<jsp:include page="/template/header.jsp"></jsp:include>
<!-- 게시글 전송 폼 -->

<div align="center">
<form action="write.do" method="post" enctype="multipart/form-data">

<input type="hidden" name="notice_no" value="<%=request.getParameter("notice_no")%>">
<input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
 
	
	<h2>공지사항 작성</h2>
	
				
		<table border="1">
			<tbody>				
			
				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="notice_title" maxlength="100" size="50" required>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="left" valign="top">
						<textarea rows="20" cols="100" maxlength="4000" name="notice_content" required></textarea>
					</td>
				</tr>
				
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="notice_file" multiple accept=".jpg, .png, .gif">
					</td>
				</tr>
			</tbody>
			</tbody>
			<tfoot>
				<tr align="center" >
					<td colspan="2">
						<input type="button" value="임시저장">
						<input type="button" value="미리보기">
						<input type="submit" value="등록">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
