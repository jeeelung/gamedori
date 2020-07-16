<%@page import="gamedori.beans.dto.NoticeFileDto"%>
<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.NoticeFileDao"%>
<%@page import="gamedori.beans.dto.NoticeDto"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dao.NoticeDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NoticeDao ndao = new NoticeDao();
	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
	
	// 조회수 계산
//	- session에 memory라는 저장소 정보를 추출한다 (없을 수도 있으므로)
	Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
//	- memory가 없을 경우에는 "게시물을 아예 처음 읽는 경우"이므로 저장소 생성
	if(memory == null){
		memory = new HashSet<>();
	}
	
// 	- memory에 현재 글 번호를 저장
	boolean isFirst = memory.add(notice_no);
//	System.out.println(memory);
	session.setAttribute("memory", memory);
	
	// Board_no를 이용하여 조회수를 증가시킨다
	// 반드시 BoardDto 를 가져오기 전에 증가시켜야 함
	MemberDto user = (MemberDto)session.getAttribute("userinfo");
	if(isFirst){
		ndao.plusReadCount(notice_no, user.getMember_no());	// 내 글에는 조회수가 올라가면 안되므로 아이디를 함께 전달
	}
	// 번호에 맞는 게시물 정보 불러오기
	NoticeDto ndto = ndao.get(notice_no);
	
	// 작성자 정보 불러오기
	//System.out.println(cdto);
	MemberDto mdto = ndao.getWriter(ndto.getMember_no());
	
	
	// 권한 확인
	boolean isMine = user.getMember_id().equals(mdto.getMember_id());
	boolean isAdmin = user.getMember_auth().equals("관리자");
	
	// 첨부파일 목록을 구해오는 코드
		NoticeFileDao nfdao = new NoticeFileDao();
		List<FilesDto> fileList = nfdao.getList(notice_no);
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	@font-face {
		font-family: ARCADECLASSIC;
		src: url("../font/ARCADECLASSIC.ttf");
	}

</style>
<div align="center">
	<form >
		<h2 >게시글 상세보기</h2>
		<table border="1" width="900" >
			<thead align="left">
				<tr>
					<!-- 제목 -->
					<th><h2>
						<%=ndto.getNotice_title()%>
					</h2></th>
				</tr>
				<tr>
					<!-- 작성자 및 권한 -->
					<th>
						작성자
						<%if(mdto != null) {%>
							<%=mdto.getMember_nick()%>
							<font color="gray"><%=mdto.getMember_auth()%></font>
						<%} else {%>
						<font color="gray">탈퇴한 사용자</font>
						<%}%>
					</th>
				</tr>
				<tr>
					<td>
						<%=ndto.getNotice_auto()%>
						<%=ndto.getNotice_read()%>
					</td>
				</tr>
			</thead>
			<tbody align="left" valign="top">
				<tr height="400">
					<!-- 게시물 내용 -->
					<td><%=ndto.getNotice_content()%></td>
				</tr>
				<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
				<%if(!fileList.isEmpty()) {%>
				<div class="row" style="min-height10px;">
				<tr height="100">
					<td>
						첨부파일 목록
						<ul>
							<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
							<%for(FilesDto fdto : fileList){%>
							<li>
								<%=fdto.getFile_name()%>
								(<%=fdto.getFile_size()%> bytes)
								<img src="download.do?file_no=<%=fdto.getFile_no()%>" width="50" height="50">
								<!-- 다운로드 버튼을 누른다면 해당 파일을 다운로드 할 수 있도록 링크 -->
								<a href="download.do?file_no=<%=fdto.getFile_no()%>">
									<input class="form-btn form-inline" type="button" value="다운로드">
								</a>
							</li>
							<%}%>
						</ul>
						</div>
					</td>
				</tr>
				<%}%>
			</tbody>
			<tfoot>
				<tr align="center">
					<td>
						<br>
						<a href="write.jsp">
							<input class = "form-btn form-inline" type="button" value="글쓰기">
						</a>
						
					<%if(isAdmin || isMine){%>
						<a href="edit.jsp?notice_no=<%=notice_no%>">
							<input class = "form-btn form-inline" type="button" value="수정">
						</a>
						<a href="<%=request.getContextPath()%>/member/check.jsp?
						go=<%=request.getContextPath()%>/notice/delete.do?notice_no=<%=notice_no%>">
							<input class = "form-btn form-inline" type="button" value="삭제">
						</a>
					<%}%>
						<a href="list.jsp">
							<input class = "form-btn form-inline" type="button" value="목록으로">
						</a>
						<br><br>
					</td>
				</tr>
			</tfoot>
		</table>
		<br>
		
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>