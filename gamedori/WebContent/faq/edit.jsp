<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.FAQFileDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.FAQDto"%>
<%@page import="gamedori.beans.dao.FAQDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	edit.jsp : 게시글 수정 페이지
	- 구조는 write.jsp와 동일하지만 차이가 있다면 글 정보가 미리 표시되어 있어야 한다
	- 정보를 표시해줘야 하기 때문에 PK(FAQ_no)가 필요하다
-->
<%
	MemberDto mdto = (MemberDto) session.getAttribute("userinfo") ;
	int faq_no = Integer.parseInt(request.getParameter("faq_no"));
	FAQDao fdao = new FAQDao();
	FAQDto fdto = fdao.get(faq_no);
	FAQFileDao ffdao = new FAQFileDao();
	List<FilesDto> fileList = ffdao.getList(faq_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.div {
	font-family: arcadeclassic;
}

.font-game {
	font-family: arcadeclassic;
	font-size: 30px;
	color: #20639B;
}

.wrap {
	border-top: 3px solid #20639B;
	border-bottom: 3px solid #20639B;
}

.today-wrap {
	border-top: 3px solid #20639B;
	border-bottom: 3px solid #20639B;
	position: relative;
}

.table {
	
}

.table.table-border {
	/* 테이블에 테두리를 부여*/
	border: 3px solid #20639B;
	/* 테두리 병합 */
	border-collapse: collapse;
}

.table.table-border>thead>tr>th, .table.table-border>thead>tr>td, .table.table-border>tbody>tr>th,
	.table.table-border>tbody>tr>td, .table.table-border>tfoot>tr>th,
	.table.table-border>tfoot>tr>td {
	/* 칸에 테두리를 부여 */
	border: 2px solid #20639B;
	color: black;
}

.table.table-border>thead>tr>th, .table.table-border>thead>tr>td>a,
	.table.table-border>tbody>tr>th>a, .table.table-border>tbody>tr>td>a,
	.table.table-border>tfoot>tr>th>a, .table.table-border>tfoot>tr>td>a {
	text-decoration: none;
	color: black;
}

.faq_head {
	border: 2px solid dodgerblue;
}

textarea {
	display: incline-block;
	postion: absolute;
	align: left;
	resize: none;
	width: 100%;
	height: 478px;
	border-width: 0px;
}

textarea:focus {
	border-width: 0px;
}

.preview-wrap>img {
	width: 100px;
	height: 100px;
	display: inline-block;
}
</style>
    <script>
        function preview(){
            var fileTag = document.querySelector("input[name=f]");
        
					var divTag = document.querySelector(".preview-wrap");

						if (fileTag.files.length > 0) {
							//선택된 파일들을 다 읽어와서 이미지 생성 후 추가
							//미리보기 전부 삭제
							divTag.innerHTML = "";

							for (var i = 0; i < fileTag.files.length; i++) {
								var reader = new FileReader();
								reader.onload = function(data) {
									//img 생성 후 data.target.result 설정하여 추가
									var imgTag = document.createElement("img");
									imgTag.setAttribute("src",
											data.target.result);
									divTag.appendChild(imgTag);
								};
								reader.readAsDataURL(fileTag.files[i]);
							}

						} else {
							//미리보기 전부 삭제
							divTag.innerHTML = "";
						}
					}
				</script>
<div>
<article>
<div class="font-game">
	<h3>FAQ 수정</h3>
</div>
<div class="row today-wrap"><div class="row-empty"></div></div>
</article>	
	
	<!-- 게시글 전송 폼 -->
	<form action="edit.do" method="post" enctype="multipart/form-data">
		
		<!-- 수정이 가능하도록 PK를 숨김 첨부한다 -->
		<input type="hidden" name="faq_no" value="<%=faq_no%>">
		
		<table class="table table-border" width="80%">
		<thead>
				<tr>
					<th>말머리</th>
					<td class="left">
						<!-- 말머리는 select로 구현 -->
						<select name="faq_head" class="faq_head">
							<option value="">말머리 선택</option>
							<option value="게임문의">게임문의</option>
							<option value="회원문의">회원문의</option>
						</select>
					</td>
				</tr>		
		</thead>
			<tbody align="top">
				<tr>
					<th width="10%">제목</th>
					<td class="left">
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="faq_title" size="70" maxlength="100" required
								value="<%=fdto.getFaq_title()%>">
					</td>
				</tr>
				<tr height="500px">
					<th width="10%">내용</th>
					<td class="left">
						<!-- 내용은 textarea로 구현 -->
						<textarea name="faq_content" required 
							rows="20" cols="100" maxlength="4000" ><%=fdto.getFaq_content()%></textarea>
					</td>
				</tr>
				<tr>
				<th>첨부파일</th>
				<td colspan="3">
				<ul>
				<%for(FilesDto filesdto : fileList){ %>
				<li>
					<%=filesdto.getFile_name() %>(<%=filesdto.getFile_size() %> bytes)
					 <a href="<%=request.getContextPath() %>/faq/fileDelete.do?file_no=<%=filesdto.getFile_no()%>&faq_no=<%=faq_no %>">
				<input type="hidden" name="faq_no" value="<%=faq_no%>">
					  <input type="button" value="삭제">
					 </a>
				</li>
					<%} %>
				<input type="file" name="faq_file" multiple accept=".jpg, .png, .gif" onchange="preview();">
				</ul>
				</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="2">
						<input class="form-btn form-inline" type="submit" value="수정">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>