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
	MemberDto mdto = qdao.getWriter(qdto.getMember_no());
	
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	// 권한 확인
	boolean isAdmin = user.getMember_auth().equals("관리자");
	boolean isMine = user.getMember_id().equals(mdto.getMember_id());
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form>
		<h2>게시글 상세보기</h2>
		<table align="center">
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
						<%if(mdto != null) {%>
						<%=mdto.getMember_nick()%> <font color="gray"><%=mdto.getMember_auth()%></font>
						<%} else {%>
						<font color="gray">탈퇴한 사용자</font>
						<%}%>
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
			</tbody>
			
		</table>
		<br>
		<a href="write.jsp">
			<input type="submit" value="글쓰기">
		</a>
		<a href="write.jsp?qna_super_no=<%=qna_no%>">
			<input type="button" value="답글">
		</a>
		<%if(isAdmin || isMine){%>
		<a href="edit.jsp?qna_no=<%=qna_no%>">
			<input type="submit" value="수정">
		</a>
		<a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/qna/delete.do?qna_no=<%=qna_no%>">
			<input type="submit" value="삭제">
		</a>
		<%}%>
		<a href="list.jsp">
			<input type="submit" value="목록으로">
		</a>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>