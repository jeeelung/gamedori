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
<style>
.font-header {

	font-family: arcadeclassic;
	font-size: 35px;
	color: #85BCE1;
}

.font-header2 {

	font-family: arcadeclassic;
	font-size: 20px;
	color: white;
}


.font_han{
	font-family: DungGeunMo;
}

  
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #85BCE1;
}
.wrap {
	border-top: 3px solid #85BCE1;
	border-bottom : 3px solid #85BCE1;
}
.today-wrap {
	border-top: 3px solid #85BCE1;
	border-bottom : 3px solid #85BCE1;
	position : relative;
}
.table{
	
}
.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #85BCE1;
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
            border:2px solid #85BCE1;
             color:#85BCE1;
            
        }
        
</style>  

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center"class="font-game">
	<h5 class="font-header">공지사항 게시글 수정</h5>

	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post" enctype="multipart/form-data">
	
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden"name="notice_no"value="<%=notice_no%>">

		<table class="table table-border table-hover">
			<tbody>
				<tr>
					<th class="font_han">제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text"class="invisible" name="notice_title"size="70" required
						value="<%=ndto.getNotice_title()%>">
						
					</td>
				</tr>
				<tr>
					<th class="font_han">내용</th>
					<td align="left" valign="top">
						<textarea class="invisible" rows="20" cols="100" maxlength="4000" name="notice_content" required><%=ndto.getNotice_content()%></textarea>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th class="font_han">첨부파일</th>
					<td>
						<input class="font_file form-inline" type="file" name="notice_file" multiple accept=".jpg,.png,.gif">
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
									<input class="form-btn form-inline2" type="button" value="삭제">
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
						<input class="form-btn form-inline2" type="submit" value="수정">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
