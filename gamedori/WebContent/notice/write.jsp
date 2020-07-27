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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
.div {font-family: arcadeclassic;}
.font-game {
	font-family: arcadeclassic;
	font-size: 20px;
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
            border:1px solid #85BCE1 !important;
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
	width:"30%";
}


.invisible{
clear:none;
border: 0px none;
float: none;
background-color: transparent; 
}


</style> 
<jsp:include page="/template/header.jsp"></jsp:include>
<!-- 게시글 전송 폼 -->

<div align="center" class="font-game">
<form action="write.do" method="post" enctype="multipart/form-data">

<input type="hidden" name="notice_no" value="<%=request.getParameter("notice_no")%>">
<input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
 
	
	<div font-size="15">공지사항 작성</div>
	
				
		<table width="70%" class="table table-border table-hover">
			<tbody>				
			
				<tr>
					<th class="font_han">제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input class="invisible" type="text" name="notice_title"  maxlength="100" size="100" required>
					</td>
				</tr>
				<tr>
					<th class="font_han">내용</th>
					<td align="left" valign="top" class="invisible">
						<textarea rows="20" cols="100" maxlength="4000" name="notice_content" required></textarea>
					</td>
				</tr>
				
				<!-- 첨부파일 -->
				<tr>
					<th class="font_han">첨부파일</th>
					<td>
						<input class="font_file form-inline " type="file" name="notice_file" multiple accept=".jpg, .png, .gif">
					</td>
				</tr>
			</tbody>
			</tbody>
			<tfoot>
				<tr align="center" >
					<td colspan="2">
						<input class="form-btn form-inline2" type="button" value="임시저장">
						<input class="form-btn form-inline2" type="button" value="미리보기">
						<input class="form-btn form-inline2" type="submit" value="등록">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
