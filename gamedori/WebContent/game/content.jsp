<%@page import="gamedori.beans.dto.GameWriterDto"%>
<%@page import="gamedori.beans.dao.GameWriterDao"%>
<%@page import="gamedori.beans.dao.GameDao"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="gamedori.beans.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base.css">
    <style>
        .line {
            border: 1px solid black;
        }
        .content {
            width: 100%;
            text-align: center;
            margin: auto;
        
        }
        .h-170 {
            height: 170px;
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
	<section class="content">
		<article class="w-70">
			<div class="row-empty"></div>
			<div class="row-empty"></div>
			<div class="line">
				<h3><%=gdto.getGame_name()%></h3>
            </div>
			<div class="row-empty"></div>
			<div class="row">
				<embed width="80%" height="500" src="download.do?game_no=<%=game_no%>" quality="high" align="middle">
				</embed>
			</div>
        </article>
        <article class="w-70">
           <div class="row line h-170">
               <h3>추천게임란</h3>
           </div>
			<div class="row-empty"></div>
			<div class="row-empty"></div>
        </article>
	</section>
<jsp:include page="/template/footer.jsp"></jsp:include>