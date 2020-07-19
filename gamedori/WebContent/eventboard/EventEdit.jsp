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

thead tr {
    background-color: #85BCE1;
    color: #ffffff;
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
.table.table-border > thead > tr > th,
        .table.table-border > thead > tr > td > a,
        .table.table-border > tbody > tr > th > a,
        .table.table-border > tbody > tr > td > a,
        .table.table-border > tfoot > tr > th > a,
        .table.table-border > tfoot > tr > td > a{
            text-decoration : none;
             color: #546583;
        }
        .pagination a {
            color:gray;
            text-decoration: none;
            display: inline-block;
            padding:0.5rem;
            min-width: 2.5rem;
            text-align: center;
            border:1px solid transparent;
        }
        .pagination a:hover,/*마우스 올라감*/
        .pagination .on {/*활성화 */
            border:1px solid gray;
            color:black;
        }
        
</style>  

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center">
	
	<h5 class="font-header">게시글 수정</h5>
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
