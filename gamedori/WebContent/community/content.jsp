<%@page import="gamedori.beans.dto.ReplyDto"%>
<%@page import="gamedori.beans.dao.ReplyDao"%>
<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="gamedori.beans.dto.CommunityFileDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.CommunityFileDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	CommunityDao cdao = new CommunityDao();
	int commu_no = Integer.parseInt(request.getParameter("commu_no"));
	CommunityDto cdto = cdao.get(commu_no);
	// 조회수 계산
	//	- session에 memory라는 저장소 정보를 추출한다 (없을 수도 있으므로)
	Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");

	//	- memory가 없을 경우에는 "게시물을 아예 처음 읽는 경우"이므로 저장소 생성
	if (memory == null) {
		memory = new HashSet<>();
	}

	// 	- memory에 현재 글 번호를 저장
	boolean isFirst = memory.add(commu_no);
	//	System.out.println(memory);
	session.setAttribute("memory", memory);

	// Board_no를 이용하여 조회수를 증가시킨다
	// 반드시 BoardDto 를 가져오기 전에 증가시켜야 함
	MemberDto user = (MemberDto) session.getAttribute("userinfo");
	if (isFirst) {
		cdao.plusReadCount(commu_no, user.getMember_no()); // 내 글에는 조회수가 올라가면 안되므로 아이디를 함께 전달
	}

	// 번호에 맞는 게시물 정보 불러오기

	// 작성자 정보 불러오기
	//System.out.println(cdto);
	MemberDto mdto = cdao.getWriter(cdto.getMember_no());

	// 첨부파일 목록을 구해오는 코드
	CommunityFileDao cfdao = new CommunityFileDao();
	List<FilesDto> fileList = cfdao.getList(commu_no);
	
	
	ReplyDao rdao= new ReplyDao();
	List<ReplyDto> replyList = rdao.getList(commu_no);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<div align="center">
		<h2>게시글 상세보기</h2>
		<table border="1" width="900">
			<thead align="left">
				<tr>
					<!-- 말머리 및 제목 -->
					<th><h2>
							[<%=cdto.getCommu_head()%>]
							<%=cdto.getCommu_title()%>
						</h2></th>
				</tr>
				<tr>
					<!-- 작성자 및 권한 -->
					<th>
					작성자 
					<%	if (mdto != null) {%> 
					<%=mdto.getMember_nick()%> 
					<font color="gray"><%=mdto.getMember_auth()%></font> 
					<%} else {%> 
					<font color="gray">탈퇴한 사용자</font> 
					<%}%>
					</th>
				</tr>
				<tr>
					<td><%=cdto.getCommu_auto()%> 조회 
					<%=cdto.getCommu_read()%>
					</td>
				</tr>
			</thead>
			<tbody align="left" valign="top">
				<tr height="400">
					<!-- 게시물 내용 -->
					<td><%=cdto.getCommu_content()%></td>
				</tr>
				<!-- 첨부파일 출력 영역 : 첨부파일이 있는 경우만 출력 -->
				<%if (!fileList.isEmpty()) {%>
				<tr height="100">
					<td>첨부파일 목록
						<ul>
							<!-- ol은 순서가 있는거 / ul은 순서가 없는거 -->
							<%for (FilesDto fdto : fileList) {%>
							<li><a href="download.do?file_no=<%=fdto.getFile_no()%>">
									<%=fdto.getFile_name()%>
							</a> (<%=fdto.getFile_size()%> bytes) <img
								src="download.do?file_no=<%=fdto.getFile_no()%>" width="50"
								height="50"></li>
							<%}%>
						</ul>
					</td>
				</tr>
				<%}%>


			</tbody>

			<!-- 댓글 목록 영역 -->
			
			
			<tr>
				<td>
				<table width="99%">
				<tbody>
				<%for(ReplyDto rdto : replyList){%>
				<tr>
				<td>
				<%MemberDto userNick = cdao.getWriter(cdto.getMember_no()); %>
				<div><%=mdto.getMember_nick() %></div>
				<div><%=rdto.getReply_content() %></div>
				<div><%=rdto.getReply_date() %></div>
				</td>
				<td width="15%">
				수정|
				<a href="reply_delete.do?reply_no=<%=rdto.getReply_no()%>&origin_no=<%=rdto.getOrigin_no()%>">
				삭제
				</a>
				</td>
				</tr>
				
				<%}  %>
				</tbody>
				</table>	
				</td>

			</tr>
			</tbody>
			</table>
			<!-- 댓글 작성 영역 -->
			
			<tr>
				<td align="right">
					<form action="reply_insert.do" method="post">
						<input type="hidden" name="origin_no" value="<%=commu_no%>">
						<textarea name="reply_content" rows="4" cols="122"
							placeholder="댓글작성"></textarea>
						<br> <input type="submit" value="등록">
					</form>
				</td>
			</tr>

			<tfoot>
				<tr align="center">
					<td><br> <a href="write.jsp"> <input type="button"
							value="글쓰기">
					</a> <a href="write.jsp?commu_super_no=<%=commu_no%>"> <input
							type="button" value="답글">
					</a> <%
					if(user != null) {
						boolean isAdmin = user.getMember_auth().equals("관리자");
						boolean isMine = user.getMember_id().equals(mdto.getMember_id());
 						if (isAdmin || isMine) {
					 %> <a href="edit.jsp?commu_no=<%=commu_no%>">
							<input type="button" value="수정">
					</a> <a
						href="<%=request.getContextPath()%>/member/check.jsp?
						go=<%=request.getContextPath()%>/community/delete.do?commu_no=<%=commu_no%>">
							<input type="button" value="삭제">
					</a> <%
 	}
					}
 %> <a href="list.jsp"> <input type="button" value="목록으로">
					</a> <br>
					<br></td>
				</tr>
			</tfoot>
		</table>
		<br>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>