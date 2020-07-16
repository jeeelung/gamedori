<%@page import="gamedori.beans.dto.AnswerFileDto"%>
<%@page import="gamedori.beans.dao.AnswerFileDao"%>
<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.QnaFileDao"%>
<%@page import="gamedori.beans.dto.QnaFileDto"%>
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
	
	QnaFileDao qfdao = new QnaFileDao();
	List<FilesDto> fileList = qfdao.getList(qna_no);
	
	AnswerFileDao afdao = new AnswerFileDao();
	List<FilesDto> afileList =afdao.getList(qna_no);
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form>
	
	<div align="left"><h2>고객 지원센터</h2></div>
		<table align="left" border="1" width="100%" text align="left">
			<thead>
			<tr>
				<th>분류</th>
				<td><%if(qdto.getQna_head() != null){ %>
					<!-- 말머리는 있을 경우만 출력 -->
						[<%=qdto.getQna_head()%>]
					<%} %>
					</td>
				</tr>
				<tr>
					<!-- 작성자 및 권한 -->
					<td>
						작성자
					</td>	
					<td colspan="3">	<%if(user != null) {%>
						<%=user.getMember_nick()%>
						 <font color="gray"><%=mdto.getMember_auth()%></font>
						<%} else { %>
						<font color="gray">탈퇴한 사용자</font>
						<%}%> 
					</td>
					</tr>
				<tr>
					<td>작성 일</td>
					<td><%=qdto.getQna_date()%></td>
				</tr>
				
				<tr>
					<td>이메일</td>
					<td>
						 <%=qdto.getQna_email()%>
					</td>
				</tr>
				</thead>
			<tbody>
			<tr>
			<th>제목</th>
			<td><%=qdto.getQna_title() %></td>
			</tr>
				<tr>
					<td>문의내용</td>
					<!-- 게시물 내용 -->
					<th>내용</th>
					<td><%=qdto.getQna_content()%></td>
				</tr>
				<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
				<%if(!fileList.isEmpty()){%>
				<tr>
					<th colspan="5"	>첨부파일</th>
				</tr>							
				<tr height="100">
					<th>
						첨부파일 목록
						</th>
						<td>
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
				<%if(!qdto.getQna_answer().equals("null")){ %>
				<th colspan="5">문의하신 내용에 대한 답변입니다.</th>
				<tr>
					<td colspan="5" height="100px" ><%=qdto.getQna_answer()%></td>
				</tr>
				<%} %>
				
				<%if(!afileList.isEmpty()){%>
				<tr>
					<th colspan="5"	>첨부파일</th>
				</tr>							
				<tr height="100">
					<th>
						첨부파일 목록
						</th>
						<td>
						<ul>
							<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
							<%for(FilesDto afdto : fileList){%>
							<li>
								<%=afdto.getFile_name()%>
								(<%=afdto.getFile_size()%> bytes)
								<!-- 다운로드 버튼을 누른다면 해당 파일을 다운로드 할 수 있도록 링크 -->
								
								<a href="download.do?file_no=<%=afdto.getFile_no()%>">
									<input type="button" value="다운로드">
								</a>
							</li>
							<%}%>
						</ul>
					</td>
				</tr>
				<%} %>
			</tbody>
		</table>
		<br>
		<%if(!isAdmin){ %>
		<a href="qna_write.jsp">
			<input type="button" value="글쓰기">
		</a>
		<% }%>
		<%if(isAdmin){ %>
			<a href=" qna_answer.jsp?qna_no=<%=qdto.getQna_no() %>">
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