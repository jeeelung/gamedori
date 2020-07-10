<%@page import="gamedori.beans.dto.GameWriterDto"%>
<%@page import="gamedori.beans.dao.GameWriterDao"%>
<%@page import="gamedori.beans.dao.GameDao"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base.css">
<style>
        .preview-wrap > img{
            width: 100px;
            height: 100px;
            display: inline-block;
        }
        #game_img, .preview-wrap {
            display: inline;
        }
        
        .priview-wrap {
            border-bottom: black;
        }
        
        label + span {
            color: red;
        }
        
</style>
<script>

</script>
<%
	int game_no = Integer.parseInt(request.getParameter("game_no"));
	GameWriterDao gdao = new GameWriterDao();
	GameWriterDto gdto = gdao.get(game_no);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
	<section>
		<article class="w-40">
			<div class="row">
				<h3><%=gdto.getGame_name()%></h3>
			</div>
			<div>
				<embed width="550" height="300" src='20.swf' quality="high" align="middle">
			</div>
		</article>
	</section>
<jsp:include page="/template/footer.jsp"></jsp:include>