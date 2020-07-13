<%@page import="gamedori.beans.dto.FilesDto"%>
<%@page import="java.util.List"%>
<%@page import="gamedori.beans.dao.CommunityFileDao"%>
<%@page import="org.apache.catalina.util.Introspection"%>
<%@page import="gamedori.beans.dto.CommunityDto"%>
<%@page import="gamedori.beans.dao.CommunityDao"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo");
	int commu_no = Integer.parseInt(request.getParameter("commu_no"));
	CommunityDao cdao = new CommunityDao();
	CommunityDto cdto = cdao.get(commu_no);
	
	CommunityFileDao cfdao = new CommunityFileDao();
	List<FilesDto> fileList = cfdao.getList(commu_no);
%>
<script>
	window.onload = function() {
    var head = document.querySelector("select[name=commu_head]");
    head.value = '<%=cdto.getCommu_head()%>';
	}
</script>
<jsp:include page="/template/header.jsp"></jsp:include>
<div>
	<form action="edit.do" method="post" enctype="multipart/form-data">
		<table align="center">
			<thead>
				<tr>
					<td>
						<%if(request.getParameter("commu_super_no") != null) {%>
						<input type="hidden" name="commu_super_no" value="<%=request.getParameter("commu_super_no")%>">
						<%}%>
						<input type="hidden" name="commu_no" value="<%=commu_no%>">
					</td>
				</tr>
				<tr>
					<th>말머리</th>
					<td>
						<Select name="commu_head">
							<option>자유</option>
							<option>공략</option>
							<option>유머</option>
						</Select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input  type="text" name="commu_title" maxlength="100" size="50" required value="<%=cdto.getCommu_title()%>">
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>내용</th>
					<td align="left" valign="top">
						<textarea rows="20" cols="100" maxlength="4000" name="commu_content" required><%=cdto.getCommu_content()%></textarea>
					</td>
				</tr>
				<!-- 첨부파일 -->
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="commu_file" multiple accept=".jpg,.png,.gif">
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
								<a href="<%=request.getContextPath()%>/community/fileDelete.do?
								file_no=<%=fdto.getFile_no()%>&commu_no=<%=commu_no%>">
									<input type="button" value="삭제">
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
						<input type="submit" value="수정">
					</td>
				</tr>
			</tfoot>
		</table>
		
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>