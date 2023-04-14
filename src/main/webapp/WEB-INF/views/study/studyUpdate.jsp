<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 스터디 수정</title>
<c:import url="../template/common_css.jsp"></c:import>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.btn {
font-family: "IBM Plex Sans KR";}

</style>
</head>
<body>
<c:import url="../template/header.jsp"></c:import>

<div class="container-fluid essbox">
	<div class="row justify-content-center">
		<h1 class="col-md-7 my-5 text-center">온라인 스터디 수정</h1>
	</div>	
	
	<div class="row justify-content-center">
		<form class="col-md-7" action="./studyUpdate" method="post" enctype="multipart/form-data" id="frm">
			<input type="hidden" name="studyNum" value="${dto.studyNum}">
			<c:forEach items="${dto.studyBoardFileDTOs}" var="fileDTO">
                <input type="hidden" name="fileNum" value="${fileDTO.fileNum}">
            </c:forEach>
			
			<div class="mb-3">
				<label for="studyName" class="form-label">스터디 이름</label> 
				<input type="text" name="studyName" class="form-control essential" id="studyName" placeholder="온라인 스터디 입력" value="${dto.studyName}">
			</div>
	
			<div class="mb-3">
				<label for="studyCost" class="form-label">스터디 가격</label>
				<input type="text" name="studyCost" class="form-control essential" id="studyCost" placeholder="스터디 가격 입력" value="${dto.studyCost}">
			</div>
			
			<div class="mb-3">
				<label for="studyStartPeriod" class="form-label">스터디 시작일</label>
			<input type="date" class="form-control essential"  name="studyStartPeriod" id="studyStartPeriod" value="${dto.studyStartPeriod}">
			<label class="form-label" id="studyStartResult" for="studyStartPeriod"></label>
			</div>
			
			<div class="mb-3">
				<label for="studyEndPeriod" class="form-label">스터디 종료일</label>
			<input type="date" name="studyEndPeriod" id="studyEndPeriod"  class="form-control essential" value="${dto.studyEndPeriod}">
			<label class="form-label" id="studyEndResult" for="studyEndPeriod"></label>
			</div>
			
			<div class="mb-3">
				<label for="studyStock" class="form-label">스터디 재고</label>
				<input type="text" name="studyStock" class="form-control essential" id="studyStock" placeholder="스터디 재고 입력" value="${dto.studyStock}">
				
			</div>
			
				<div id="fileList">
					<div class="input-group mb-3" id="f1">
						<input type="file" class="form-control essential" name="addFiles">
					</div>
				</div>
				<div class="mb-3 my-5">
					<button class="btn btn-outline-primary" id="submitbtn"
						type="button">등록하기</button>
				</div>

		</form>
	</div>
</div>
	<script>
	$("#fileList").on("click",".dels",function(e){
	    // let id = $(this).attr('data-dels-id');
	    // $("#"+id).remove();
	    $(this).parent().remove();
	})
	</script>
	<script src="/resources/js/essential.js"></script>
	<script type="text/javascript" src="/resources/js/studyDateCheck.js"></script>	
	<c:import url="../template/common_js.jsp"></c:import>
	<c:import url="../template/footer.jsp"></c:import>
</body>
</html>