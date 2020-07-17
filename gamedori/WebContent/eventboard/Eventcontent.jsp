<%@page import="gamedori.beans.dto.event_participateDto"%>
<%@page import="gamedori.beans.dao.event_participateDao"%>
<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="gamedori.beans.dao.EventFileDao"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.MemberDao"%>
<%@page import="gamedori.beans.dto.EventboardDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.EventboardDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">   
 <style>
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 50px;
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
	border: 1px solid #85BCE1;
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
            border:1px solid #85BCE1 !important;
             color:#546583;
            
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
        
        
        
</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<script language="event">

</script>
    
    
<%
EventboardDao edao = new EventboardDao();
int event_no = Integer.parseInt(request.getParameter("event_no"));
event_participateDao epdao =new event_participateDao();
EventboardDto edto = edao.get(event_no);
//조회수 계산 
//세션에 메모리 불러오기
Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
// 없으면 저장소 만들기
if(memory==null){
	memory = new HashSet<>();
}
//메모리 저장소에 이벤트글 번호 넣고
boolean isFirst = memory.add(event_no);
session.setAttribute("memory", memory);
//mdto에서 유저 인포 가져오고
//내글이면 조회수 막아야 하니 멤버 번호를 준다
MemberDto user= (MemberDto) session.getAttribute("userinfo");
if(isFirst){
	edao.plusReadcount(event_no, user.getMember_no());
}

// 작성자 정보 불러오기
//System.out.println(cdto);
MemberDto mdto = edao.getWriter(edto.getMember_no());


// 권한 확인


// 첨부파일 목록을 구해오는 코드
	EventFileDao efdao = new EventFileDao ();
	List<FilesDto> fileList = efdao.getList(event_no);

%>




<div align="center">
<form>
	<article>
	<h5 class="font-header">Event Content!</h5>
	<div class="row today-wrap"><div class="row-empty"></div>
	</article>
	<table class="table table-border" width="80%">
		<tbody align="left" align="top">
			<tr>
				<!-- 말머리 및 제목 -->
			
				<th width="10%">제목</th>
					 <th width="30%">
					 <%=edto.getEvent_title()%>
				</th>
				<th width="15%">작성자</th>
				<!-- 작성자 및 권한 -->
				<th>
					<%if(mdto != null) {%>
						<%=mdto.getMember_nick()%>
						<font color="gray"><%=mdto.getMember_auth()%></font>
					<%} else {%>
					<font color="gray">탈퇴한 사용자</font>
					<%}%>
				</th>
				
				<th width="5%">시간 </th>
					 <th><%=edto.getEvent_auto() %>
					</th>
				<th width="5%"> 조회</th>
				<th> <%=edto.getEvent_read() %></th>
				
			</tr>
		

			<tr height="500px">
			<th width="10%">내용</th>
				<!-- 게시물 내용 -->
				<td valign="top" colspan="10" class="left"><%=edto.getEvent_content() %></td>
			</tr>
			<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
			<%if(!fileList.isEmpty()) {%>
			<tr height="100">
				<td>
					첨부파일 			
					</td>
					<td align="left" colspan="50">
					<ul>
						<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
						<%for(FilesDto fdto : fileList){%>
						<li align="left" >
							<%=fdto.getFile_name()%>
							(<%=fdto.getFile_size()%> bytes)
							<!-- 다운로드 버튼을 누른다면 해당 파일을 다운로드 할 수 있도록 링크 -->
							<a href="download.do?file_no=<%=fdto.getFile_no()%>">
							<input class="form-btn form-inline2" type="button" value="다운로드">
							</a>
							</td>
						</li>
						<%}%>
					</ul>
				</td>
			</tr>
			<%}%>
		</tbody>
		<tfoot >
			<tr align="center">
				<td colspan= "10">
					<br>
				
			
					
				<%if(user !=null){
					boolean isMine = user.getMember_id().equals(mdto.getMember_id());
					if(user != null){
				%>
					<a href = "event.do?event_no=<%=event_no%>">
					<input class="form-btn form-inline2" type = "button" value= "이벤트 참여">
					</a>
					
					<a href="event_list.jsp">
						<input class="form-btn form-inline2" type="button" value="목록으로">
					</a>
					<%} %>
					
					
					<%} %>
					<%if(user != null) {
						boolean isAdmin = user.getMember_auth().equals("관리자");
					
 						if (isAdmin) { %>
 					<a href="EventBoardWrite.jsp">
						<input type="button" value="글쓰기">
					</a>
				
 						
					<a href="EventEdit.jsp?event_no=<%=event_no%>">
						<input type="button" value="수정">
					</a>
					<a href="<%=request.getContextPath()%>/member/check.jsp?
					go=<%=request.getContextPath()%>/eventboard/delete.do?event_no=<%=event_no%>">
						<input type="button" value="삭제">
					</a>
					<%} %>
				<%}%>
					
					<br><br>
				</td>
			</tr>
		</tfoot>
	</table>
	<br>
	
</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>