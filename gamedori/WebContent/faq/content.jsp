<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="gamedori.beans.dto.FAQFileDto"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dao.FAQFileDao"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dto.FAQDto"%>
<%@page import="gamedori.beans.dao.FAQDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	FAQDao fdao = new FAQDao();
	int faq_no = Integer.parseInt(request.getParameter("faq_no"));
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	//faq_no를 이용하여 faqdto를 얻어냄.
	FAQDto fdto = fdao.get(faq_no);
	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.get(fdto.getMember_no());
	boolean isAdmin = user.getMember_auth().equals("관리자");
	boolean isMine = user.getMember_id().equals(mdto.getMember_id());
	FAQFileDao ffdao = new FAQFileDao();
	List<FilesDto> fileList = ffdao.getList(faq_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #20639B;
}
.wrap {
	border-top: 3px solid #20639B;
	border-bottom : 3px solid #20639B;
}
.today-wrap {
	border-top: 3px solid #20639B;
	border-bottom : 3px solid #20639B;
	position : relative;
}
.table{
	
}
.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #20639B;
	/* 테두리 병합 */
	border-collapse: collapse;
}
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td,
        .table.table-border > tbody > tr > th,
        .table.table-border > tbody > tr > td,
        .table.table-border > tfoot > tr > th,
        .table.table-border > tfoot > tr > td {
            /* 칸에 테두리를 부여 */
            border:2px solid #20639B;
             color:black;         
        }
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td > a,
        .table.table-border > tbody > tr > th > a,
        .table.table-border > tbody > tr > td > a,
        .table.table-border > tfoot > tr > th > a,
        .table.table-border > tfoot > tr > td > a{
            text-decoration : none;
             color:black;
        }
</style>
<div align="center">
<form>
<article>
<div class="font-game">
	<h3>FAQ</h3>
</div>
<div class="row today-wrap"><div class="row-empty"></div>
</article>
	<!-- 테이블에 글 정보를 출력 -->
	<table class="table table-border" width="80%">
		<tbody align="left" align="top">
			<tr>
			<th width="10%">제목</th>
				<th>
					<%
						if (fdto.getFaq_head() != null) {
					%> <!-- 말머리는 있을 경우만 출력 --> [<%=fdto.getFaq_head()%>] <%}%>
					 <%=fdto.getFaq_title()%>
				</th>	
			<th width="10%">작성자</th>
				<th>
					<!-- 작성자 --> <%if (mdto != null) {%> 
					<%=mdto.getMember_nick()%>
					 <font color="gray" >[<%=mdto.getMember_auth()%>]</font>
					  <%} else {%> <font color="gray">탈퇴한 사용자</font>
					<%} %>
				</th>
			</tr>
			<tr height="500px">
			<th width="10%">내용</th>
				<td valign="top" colspan="3"><%=fdto.getFaq_content() %></td>
			</tr>
			<%if(!fileList.isEmpty()){ %>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<ul>
						<%for(FilesDto filesdto : fileList) {%>
						<li><%=filesdto.getFile_name() %> (<%=filesdto.getFile_size() %>bytes) 
						<a href="download.do?file_no=<%=filesdto.getFile_no() %>"><input type="button" value="다운로드"> 
						<!-- 다운로드 미리보기 -->
						<span class="preview-text">미리보기<img class="preview" src="dowload.do?file_no="<%=filesdto.getFile_no() %>"width="150"></span>
						</a>
						</li>
						<%} %>
						<input type="file" name="faq_file" multiple accept=".jpg, .png, .gif"> 
					</ul>
				</td>
			</tr>
			<%} %>
		</tbody>
		<!-- 각종 버튼들 구현 -->
		<tfoot>
			<tr align="center">
				<td colspan="4"><a href="write.jsp"> <input class="form-btn form-inline"  type="button" value="글쓰기"></a>
				  <%if(isAdmin || isMine){ %>
					  <a href="edit.jsp?faq_no=<%=faq_no %>"><input class="form-btn form-inline" type="button" value="수정"></a> 
					  <a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/faq/delete.do?faq_no=<%=faq_no%>">
					  <input class="form-btn form-inline" type="button" value="삭제"></a>
				  <%} %>
				<a href="list.jsp"><input class="form-btn form-inline" type="button" value="목록으로"></a><br><br>
				</td>
			</tr>
		</tfoot>
	</table>
	<br>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>