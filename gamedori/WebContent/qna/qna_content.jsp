<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.QnaDto"%>
<%@page import="gamedori.beans.dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	QnaDao qdao = new QnaDao();
	int qna_no = Integer.parseInt(request.getParameter("qna_no"));
	// 번호에 맞는 게시물 정보 불러오기
	QnaDto qdto = qdao.get(qna_no);
	// 작성자 정보 불러오기
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	MemberDto mdto = qdao.getWriter(qdto.getMember_no());
	// 권한 확인
	boolean isAdmin = user.getMember_auth().equals("관리자");
	boolean isMine = user.getMember_id().equals(mdto.getMember_id());
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form>
	
	<div align="center"><h2>고객 지원센터</h2></div>
		<table align="center" border="1" width="60%">
			<thead>
				<tr>
					<!-- 말머리 및 제목 -->
					<th>
						[<%=qdto.getQna_head()%>]<%=qdto.getQna_title()%>
					</th>
				</tr>
				<tr>
					<!-- 작성자 및 권한 -->
					<th>
						작성자
						<%if(user != null) {%>
						<%=user.getMember_nick()%>
						 <font color="gray"><%=mdto.getMember_auth()%></font>
						
						<%} else { %>
						<font color="gray">탈퇴한 사용자</font>
						<%}%>
						
					</th>
				</tr>
				<tr>
					<!-- 작성 일 -->
					<th>
						작성 일<%=qdto.getQna_date()%>
					</th>
				</tr>
				
			</thead>
			<tbody>
				<tr>
					<!-- 게시물 내용 -->
					<td><%=qdto.getQna_content()%></td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="qna_file" multiple accept=".jpg,.png,.gif">
					</td>
				</tr>
				<tr>
					<!--답변 -->
					<td><%=qdto.getQna_answer()%></td>
				</tr>
				
			</tbody>
			
		</table>
		<br>
		<%if(!isAdmin){ %>
		<a href="qna_write.jsp">
			<input type="button" value="글쓰기">
		</a>
		<% }%>
		<%if(isAdmin){ %>
			<a href=" qna_edit.jsp?qna_no=<%=qdto.getQna_no() %>">
				<input type="button" value=" 답변하기">
			</a>
		
		<%} %>		
		<%if(isAdmin || isMine){%>
		<a href="qna_edit.jsp?qna_no=<%=qna_no%>">
			<input type="button" value="수정">
		</a>
		<a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/qna/delete.do?qna_no=<%=qna_no%>">
			<input type="button" value="삭제">
		</a>
		<%}%>
		<a href="qna_list.jsp">
			<input type="button" value="목록으로">
		</a>
		
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>