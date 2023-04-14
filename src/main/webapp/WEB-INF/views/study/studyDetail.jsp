<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <head>
 <title>구디다이어트</title>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <c:import url="../template/common_css.jsp"></c:import>
 <link href="/resources/css/star.css" rel="stylesheet"/>
     <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
 
 <style>
 * {
font-family: "IBM Plex Sans KR";
}
 
 
 
.my-hr2 {
	border: 0;
	height: 2px;
	background: #ccc;
}

  .my-table tr:nth-child(even) {
    background-color: #39487c28; /* 짝수 줄 배경색 */
  }
  
  .my-table tr:nth-child(odd) {
    background-color: #ffffff; /* 홀수 줄 배경색 */
  }
  
}


</style>

 </head>
 <body>
  <c:import url="../template/header.jsp"></c:import>
 
	<div class="container px-4 px-lg-5">
            <!-- Heading Row-->
            <div class="row gx-4 gx-lg-5 align-items-center my-5">
            	<c:forEach items="${dto.studyBoardFileDTOs}" var="fileDTO">
                	<div class="col-lg-7"><img class="img-fluid rounded mb-4 mb-lg-0" src="../resources/upload/study/${fileDTO.fileName}" alt="..." /></div>
                </c:forEach>
                <div class="col-lg-5">
                    <h2 class="font-weight-light">${dto.studyName}</h2>
                    <h3 class="font-weight-light">${dto.studyCost}원</h3>
                    <hr class="my-hr2">
            		<div class="text-center">
                    <h6><strong>스터디 일정안내</strong></h6>
                   	스터디 기간: ${dto.studyStartPeriod}~${dto.studyEndPeriod}
                    <br>반배정 문자 일괄 발송
                 	<c:if test="${sessionMember.roleDTO.roleName eq 'ADMIN'}"> 
                    <br>문의:010-0000-0000
                    </c:if>
                    </div>
                    <br>
				<c:choose>
					<c:when test="${sessionMember eq null}">
						<a href="#" class="btn btn-primary" data-toggle="modal" data-target="#loginModal">장바구니에 담기</a>
					</c:when> 
					<c:when test="${sessionMember ne null and sessionMember.studyNum eq null}">
						<form action="/cart/cartAdd" method="post">
							<input type="hidden" name="studyNum" value="${dto.studyNum}">
							<input type="hidden" name="cartPrice" value="${dto.studyCost}">		
							<button class="btn btn-primary" type="submit" data-stock-cart="${dto.studyStock}" id="submitbtn"></button>
						</form>
					</c:when>
					<c:when test="${dto.studyStock==0 or empty dto.studyStock}">
						<div>
						<button class="btn btn-secondary" style="width: 100%;">품절상품 입니다.</button></div>
					</c:when>
				</c:choose>

				<form action="./studyUpdate" id="frm">
					<input type="hidden" name="studyNum" value="${dto.studyNum}">
					<c:forEach items="${dto.studyBoardFileDTOs}" var="fileDTO">
						<input type="hidden" name="fileNum" value="${fileDTO.fileNum}">
					</c:forEach>
					<c:if test="${sessionMember.roleDTO.roleName eq 'ADMIN'}"> 
						<button id="update" type="submit" class="btn btn-primary">스터디 수정하기</button>
						<button id="delete" type="button" class="btn btn-primary">스터디 삭제하기</button>
					</c:if>
				</form>
                </div>
            </div>
            <!-- Call to Action-->
            
            <div class="col-12 w-100 text-center">
			        <div class="row">
			        <div class="col-md-4">
			          <div class="nav-link" id="studyQnaInfo" style="cursor: pointer">상세정보</div>
			        </div>
			        <div class="col-md-4">
			         <div class="nav-link" id="studyReviewList" data-review-studyNum="${dto.studyNum}" style="cursor: pointer">구매평(${review})</div>
			        </div>
			        <div class="col-md-4">
			          <div class="nav-link" id="studyQnaList" data-study-studyNum="${dto.studyNum}" style="cursor: pointer">Q&amp;A(${qna})</div>
			        </div>
			        <hr class="my-hr2">
			        </div>
  			</div>
  			
  			<div class="my-5" id="studyListResult">
  				<img class="img-fluid rounded mb-4 mb-lg-0" src="/resources/images/studyDetailinfomation.jpg" alt="..." />
  				<img class="img-fluid rounded mb-4 mb-lg-0" src="/resources/images/studyDetailinfomation2.jpg" alt="..." />
  			</div>
  	</div>

  <!-- Modal -->
  <div class="modal fade" id="contentsModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	  <div class="modal-content">
		<div class="modal-header">
		  <h1 class="modal-title fs-5" id="exampleModalLabel">리뷰 쓰기</h1>
		  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body">
			
				<div class="form-floating">
					<textarea class="form-control" placeholder="Leave a comment here" id="contents"></textarea>
					<label for="contents">Comments</label>
				</div>
						<form class="mb-3" name="myform" id="myform" method="post">
							<fieldset>
								<span class="text-bold">별점을 선택해주세요</span> 
									<input type="radio" name="reviewStar" value="5" id="rate1" class="star">
									<label for="rate1">★</label> 
									<input type="radio" name="reviewStar" value="4" id="rate2" class="star">
									<label for="rate2">★</label> 
									<input type="radio" name="reviewStar" value="3" id="rate3" class="star">
									<label for="rate3">★</label> 
									<input type="radio" name="reviewStar" value="2" id="rate4" class="star">
									<label for="rate4">★</label> 
									<input type="radio" name="reviewStar" value="1" id="rate5" class="star">
									<label for="rate5">★</label>
							</fieldset>
						</form>					
		</div>
		<div class="modal-footer">
		  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closeModal">Cancel</button>
		  <button type="button" class="btn btn-primary" id="contentsConfirm" data-comment-num="">확인</button>
		</div>
	  </div>
	</div>
  </div>

 
 <!-- loader -->
 <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>



 
 <script>
		$('#contents').summernote({
			
				  callbacks: {
				    onImageUpload: function(file) {
				      // upload image to server and create imgNode...
				  	/* uploadFile(files) */
						const formData = new FormData();
						//<input type="file"
						formData.append('files', file[0])
						$.ajax({
							type:"POST",
							url:"summerFile",
							data:formData,
							//header
							cache:false,
							processData:false,
							contentType:false,
							enctype:'multipart/form-data',
							success:function(img){
								console.log("Image => ", img)
								// img = '<img src="'+img+'">'
								// $("#contents").summernote('pasteHTML', img);
								$("#contents").summernote('insertImage', img);
								 
							},
							error:function(){
								console.log('Image upload Fail')
							}
						});
				    }
				  }
		});//
		
		  function uploadFile(file){
				console.log("file", file);
				console.log("fileName => ", file[0].name);
				//<form>
				const formData = new FormData();
				//<input type="file"
				formData.append('files', file[0])
				$.ajax({
					type:"POST",
					url:"summerFile",
					data:formData,
					//header
					cache:false,
					processData:false,
					contentType:false,
					enctype:'multipart/form-data',
					success:function(img){
						console.log("Image => ", img)
						// img = '<img src="'+img+'">'
						// $("#contents").summernote('pasteHTML', img);
						$("#contents").summernote('insertNode', img);
						 
					},
					error:function(){
						console.log('Image upload Fail')
					}
				});
			  }
		  const frm = document.getElementById('frm');
		  const del = document.getElementById('delete');
		  
		  del.addEventListener('click',function(){
		    swal({
		      title: '정말 삭제 하시겠습니까?',
		      icon: 'warning',
		      buttons: ['아니요', '예']
		    }).then((result) => {
		      if (result) {
		        frm.setAttribute("action", "./studyDelete");
		        frm.setAttribute("method","post");
		        frm.submit();
		      }
		    });
		  });
	</script>
     
    <div class="modal fade" id="loginModal" tabindex="-1"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginModalLabel">로그인이 필요합니다</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body text-center">로그인 후 이용해주세요.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<a href="/member/login" class="btn btn-primary">로그인</a>
			</div>
		</div>
	</div>
</div>

<c:import url="../template/footer.jsp"></c:import>
<c:import url="../template/common_js.jsp"></c:import>
<script src="/resources/js/studyBoard.js"></script>
 </body>
</html>