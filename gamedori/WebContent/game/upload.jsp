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
	function preview() {
		var fileTag = document.querySelector("input[name=game_img]");
            
		var divTag = document.querySelector(".preview-wrap");
            
		if(fileTag.files.length > 0) {
                // 선택된 파일들을 다 읽어와서 이미지 생성 후 추가
                // 미리보기 전부 삭제
                divTag.innerHTML = "";
                
                for(var i=0; i<fileTag.files.length; i++){
                    
                    var reader = new FileReader();
                    reader.readAsDataURL(fileTag.files[i]); // 읽어라
                    reader.onload = function(data) { // 읽고 나면 이미지를 생성해라
                        var imgTag = document.createElement("img");
                        imgTag.setAttribute("src", data.target.result);
                        divTag.appendChild(imgTag); // 이미지를 div위치로 넣어라(이동시켜라)
                    }
                    
                }
                
            } else {
                // 미리보기 전부 삭제
                divTag.innerHTML = "";  // innerHTML : div에 있는 모든 html 속성
            }
        }
    </script>
<%
	MemberDto mdto = (MemberDto)session.getAttribute("userinfo");
			
%>
<jsp:include page="/template/header.jsp"></jsp:include>
    <form action="upload.do" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
       <section>
            <article class="w-40">
                <div class="row-empty"></div>
                <div class="row-empty"></div>
                <!-- 게임명 작성란 -->
                <div class="row left">
                    <label for="game_name">게임명</label> <span>*</span>
                </div>
                <div class="row left">
                    <input class="form-input" type="text" id="game_name" name="game_name">
                </div>
                <div class="row-empty"></div>
                <!-- 게임방법 작성란 -->
                <div class="row left">
                    <label for="game_intro">게임 방법</label> <span>*</span>
                </div>
                <div class="row left">
                    <textarea class="form-input" name="game_intro" id="game_intro"></textarea>
                </div>
                <div class="row-empty"></div>
                <!-- 게임파일 업로드 -->
                <div class="row left">
                    <label for="game_file">게임 파일</label> <span>*</span>
                </div>
                <div class="file-wrap left">
                    <input type="file" id="game_file" name="game_file" accept=".swf">
                </div>
                <hr class="line">
                <div class="row-empty"></div>
                <!-- 게임 이미지 파일 업로드 -->
                <div class="row left">
                    <label for="game_img">게임 이미지</label> <span>*</span>
                </div>
                <div class="file-wrap row left">
                    <input type="file" id="game_img" name="game_img" accept=".jpg, .png, .gif" onchange="preview();">
                    <!-- 이미지 미리보기가 추가될 영역 -->
                <div class="preview-wrap"></div>
                </div>
                <hr class="line">
                <div class="row-empty"></div>
                <div class="row-empty"></div>
                <div class="row center">
                    <input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
                    <input class="form-btn" type="submit" value="등 록">
                    <!-- 작성자 정보 전송 -->
                </div>
            </article>
       </section>
    </form>
<jsp:include page="/template/footer.jsp"></jsp:include>