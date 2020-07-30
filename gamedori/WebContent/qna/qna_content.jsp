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
<style>
.div {font-family: arcadeclassic;}
.font-game {
<<<<<<< HEAD
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
.preview-wrap > img {
   width:100px;
   height:100px;
   display:inline-block;
 }
</style>
<script>
   function preview() {
      var fileTage = document.querySelector("input[name=f]");
      var divTag = document.querySelelctor(".preview-wrap");
      if(fileTag.files.length > 0){
         divTag.innerHTML = "";
          for(var i=0; i < fileTag.files.length; i++){
                 var reader = new FileReader();
                 reader.onload = function(data){
                     //img 생성 후 data.target.result 설정하여 추가
                     var imgTag = document.createElement("img");
                     imgTag.setAttribute("src", data.target.result);
                     divTag.appendChild(imgTag);
                 };
                 reader.readAsDataURL(fileTag.files[i]);
             }
             
         }else{
             //미리보기 전부 삭제
             divTag.innerHTML = "";
         }
   }
</script>
<div>
	<form>
	<article>
	<div class="font-game" align="left"><h2>고객 지원센터</h2></div>
		<table class="table table-border" width="80%">
			<tbody align="left" align="top">
			<tr>
				<th width="10%">분류</th>
				<td><%if(qdto.getQna_head() != null){ %>
					<!-- 말머리는 있을 경우만 출력 -->
						[<%=qdto.getQna_head()%>]
					<%} %>
					</td>
				</tr>
				<tr>
					<!-- 작성자 및 권한 -->
					<th width="10%">
						작성자
					</th>	
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
				<tr height="500px">
					<th width="10%">내용</th>
					<td valign="top" colspan="3" class="left"><%=qdto.getQna_content()%></td>
				</tr>
				<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
				<%if(!fileList.isEmpty()){%>
				<tr>
					<th >첨부파일</th>
					<td colspan="3">
						첨부파일 목록
						<ul>
							<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
							<%for(FilesDto fdto : fileList){%>
							<li>
								<%=fdto.getFile_name()%>
								(<%=fdto.getFile_size()%> bytes)
								<!-- 다운로드 버튼을 누른다면 해당 파일을 다운로드 할 수 있도록 링크 -->
																							
								<a href="download.do?file_no=<%=fdto.getFile_no()%>">
									<input type="button" value="다운로드">
								<span class="preview-text">미리보기<img class="preview" src="download.do?file_no="<%=fdto.getFile_no() %>"width="150"></span>
								</a>
							</li>
							<%}%>
							<input type="file" name="qna_file" multiple accept=".jpg, .png, .gif">
						</ul>
					</td>
				</tr>
				<%} %>
				<%if(!qdto.getQna_answer().equals("null")){ %>
				<th colspan="5">문의하신 내용에 대한 답변입니다.</th>
				<tr height="500px">
					<td valign="top" colspan="3" class="left"><%=qdto.getQna_answer()%></td>
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