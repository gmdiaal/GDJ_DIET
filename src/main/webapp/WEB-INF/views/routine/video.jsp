<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String number = request.getParameter("number"); %>
<html>
  <head>
    
    <title>이달의 루틴 ${dto.startDay.date}일차</title>
    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <c:import url="../template/common_css.jsp"></c:import>  
    <link rel="stylesheet" href="/resources/css/video.css">
    
  </head>
  <body>
  <c:import url="../template/header.jsp"></c:import>

			
	   <section class="ftco-section">
          <div class="col-md-12 ftco-animate text-center">
            <h1 class="mb-3 bread" id='days' data-day-days='${dto.startDay.date}'>루틴 ${dto.startDay.date}일차</h1>
            <p class="breadcrumbs"><span class="mr-2"><a href="/exercise/routine">이달의 루틴</a></span> <span>${dto.startDay.date}일차</span></p>
            <h4><a href="/healthMachine/detail?machineNum=${dto.machineNum}" style="color:#2c396b;">필요한 홈트용품</a>
            <a href="/healthMachine/detail?machineNum=${dto.machineNum}" style="color:tomato;"> ✔ </a><mark><a href="/healthMachine/detail?machineNum=${dto.machineNum}" style="color:#2c396b;">${dto.healthMachineDTO.machineName}</a></mark></h4>
            <form action="./delete" id="frm">
            <c:if test="${sessionMember.roleDTO.roleName eq 'ADMIN'}">
            	<input type="hidden" name="num" value="${dto.num}">
				<button id="delete" type="button" class="btn btn-primary">루틴 삭제하기</button>
			</c:if>
			</form>
          </div>
 	  </section>
  
	  
<div class = "container-fluid">
	<div class = "row mx-auto ">
		<div class="form-group">            	
				<div class="video-container" id="videoId" data-video-id='${dto.videoId}'>
				<div id="player"></div>
			    
       			</div>
        </div>
	</div>
</div>

<section class="ftco-section">
          <div class="col-md-12 ftco-animate text-center">
            <h1 class="mb-3 bread">루틴 ${dto.startDay.date}일차</h1> 
            <img id=thumbsup src="../resources/images/thumbsup.png" width="200px" height="200px" alt="">
          </div>
</section>
	




<script src="/resources/js/video.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  
<c:import url="../template/footer.jsp"></c:import> 
<script src="../resources/js/boardForm.js"></script>
<c:import url="../template/common_js.jsp"></c:import>   
  </body>
</html>