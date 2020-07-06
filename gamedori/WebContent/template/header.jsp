<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>semi-gamedori</title>
</head>
<body>
	<div align="center">
		<table border="1" width="1000">
			<tbody>
				<!-- 상단(header) 영역 -->
				<tr height="100">
					<td align="center">
						<h1>Gamedori</h1>
					</td>
				</tr>
				<!-- 메뉴(navigation) 영역 -->	
				<tr>
					<td>
						<jsp:include page="/template/menu.jsp"></jsp:include>
					</td>
				</tr>
				<!-- 본문(section) 영역 -->
				<tr height="350">
					<td valign="top">	<!-- top, middle, bottom -->