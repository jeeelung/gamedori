<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>GAMEDORI</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base.css">
    <style>
        main {
            width: 1100px;
            margin: auto;
        }
        .menu {
            text-align: center;
        }
        
        .font-game {
            font-family: ARCADECLASSIC;
            font-size: 70px;   
        }
        .foot {
            color: gray;
            text-align: center;
        }
        .intro {
            color: black;
            font-weight: 900;
            text-align: center;
        }
    </style>
</head>
<body>

    <main class="center">
        <header>
            
            <div class="row center">
                <a href="<%=request.getContextPath()%>/index.jsp"><img class="logo" src="<%=request.getContextPath()%>/image/logo.png"></a>
            </div>
        </header>

        <nav>
        	<jsp:include page="/template/menu.jsp"></jsp:include>
        </nav>
        	<section>