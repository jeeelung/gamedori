<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/template/header.jsp"></jsp:include>
    
    <div align="center">
    
    <h2>이벤트 게시글 작성</h2>
    
    
    <form action="Eventwrite.do" method="post"></form>
    
    <table border="1">
    
    	<tr>
					<th>제목</th>
					<td>
						<!-- 제목은 일반 입력창으로 구현 -->
						<input type="text" name="Event_title" size="70" required>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<!-- 내용은 textarea로 구현 -->
						<textarea name="Event_content" required rows="15" cols="72"></textarea>
					</td>  
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="작성">
					</td>
				</tr>
			</tfoot>
    
    </table>
    
    
    </div>
    
    
     <jsp:include page="/template/footer.jsp"></jsp:include>