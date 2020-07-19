<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 
파일을 업로드 하기 위한 form 구성 
- GET으로 전송하면 파일명이 전송된다
- POST로 전송해도 파일명만 전송된다.
	- POST로 설정한 뒤에 인코딩 방식(enctype)까지 지정해야 한다.
	- multipart/form-data로 변경하면 전송 방식이 파일에 적합하게 변경된다.
-->
<h1>파일 업로드 화면</h1>
<!-- <form action="upload.do" method="post"  enctype="multipart/form-data"> -->
<form action="upload.do" method="post"  enctype="multipart/form-data">
	<input type="text" name="uploader">
	<br><br>
	<!-- multiple 이라는 옵션을 주면 파일을 여러개 보낼 수 있다 -->
	<input type="file" name="f" multiple accept=".jpg , .gif , .png">
	<br><br>
	<input type="submit" value="업로드">
</form>
