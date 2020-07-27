<%@page import="gamedori.beans.dto.QnaDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<!-- 
	write.jsp : 게시글 작성 페이지
	- 입력 항목은 3개 : board_head, board_title, board_content
	- 작성자는 회원정보가 자동으로 설정
	
	- 첨부파일을 추가할 수 있도록 구현(이미지만 허용)
 -->
 
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
 <%
 		MemberDto mdto=(MemberDto)session.getAttribute("userinfo");
 		boolean isAdmin = mdto.getMember_auth().equals("관리자");
 		QnaDto qdto=new QnaDto();
 %>
  <script>
        function preview(){
            var fileTag = document.querySelector("input[name=f]");
            
            var divTag = document.querySelector(".preview-wrap");
            
            if(fileTag.files.length > 0){
                //선택된 파일들을 다 읽어와서 이미지 생성 후 추가
                //미리보기 전부 삭제
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
                
            }
            else{
                //미리보기 전부 삭제
                divTag.innerHTML = "";
            }
        }
    </script>
		<div>
		<article>
		<div class="font-game">
	<h2>문의글 작성</h2>
	</div>
	<!-- 게시글 전송 폼 -->
	<div class="row today-wrap"><div class="row-empty"></div>
	<form action="write.do" method="post" enctype="multipart/form-data">
		<table class="table table-border" width="80%">
						<input type="hidden" name="qna_no" value="<%=request.getParameter("qna_no")%>">
						<input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
						<input type="hidden" name="qna_answer" value="<%=qdto.getQna_answer() %>">
		
		<thead>

				<tr>
					<th>말머리</th>
					<td>
						<!-- 말머리는 select로 구현 -->
						<select name="qna_head">
							<option value="">말머리 선택</option>
							<option value="회원">회원</option>
							<option value="게임">게임</option>
							<option value="포인트">포인트</option>
						</select>
					</td>
				</tr>

				<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="qna_title" size="70" required>
					</td>
				</tr>
				<tr>
					</thead>
					<tbody>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="qna_content" required rows="15" cols="72"></textarea>
					</td>  
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="qna_email" size="70" required>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="qna_file" multiple accept=".jpg, .png, .gif">
					</td>
				</tr>
				
				<%if(isAdmin){ %>
				<tr>
					<th>답변</th>
					 <td>
						<textarea name="qna_answer" required rows="15" cols="72"></textarea>
					</td>
				</tr>
				<%}%>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="문의하기">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
