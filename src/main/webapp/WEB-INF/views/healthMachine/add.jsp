<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="../template/common_css.jsp"></c:import>
<c:import url="../template/header.jsp"></c:import>
</head>
<style>
body {
	font-family: "IBM Plex Sans KR", sans-serif;
}
</style>
<body>

	<div class="container-fluid">
		<div class="essbox">
			<div class="row justify-content-center">
				<h1 class="col-md-7 my-5 text-center">홈트용품 등록</h1>
			</div>
			<div class="col-md-7 mx-auto">
				<form action="./add" method="POST" enctype="multipart/form-data"
					id="frm">
					<div class="mb-3" id="categoryList">
						<label for="categoryNum" class="form-label">카테고리</label> <select
							class="form-select" id="categorySelect" name="categoryDTOs">

							<c:forEach items="${category }" var="dto">

								<option value="${dto.categoryNum}">${dto.categoryName}</option>
							</c:forEach>
						</select>
					</div>
					<div id="categorybtn">
						<button type="button" class="btn btn-primary" id="categoryAdd">카테고리추가</button>

					</div>

					<div class="mb-3">
						<label for="machineName" class="form-label">용품이름</label> <input
							type="text" class="form-control essential" name="machineName">
					</div>

					<div class="mb-3">
						<label for="price" class="form-label">가격</label> <input
							type="text" class="form-control essential" name="price"
							placeholder="필수입력창 입니다." required>
					</div>
					<div class="mb-3">
						<label for="salePrice" class="form-label">할인가격</label><br>
						<input type="text" class="form-control essential" id="red-point"
							name="salePrice">
					</div>
					<div id="optionList">
						<div class="mb-3 was-validated " id=option1>
							<label for="option1" class="form-label">필수옵션명</label> <input
								type="text" class="form-control essential" name="option1"
								placeholder="필수입력창 입니다." required>
						</div>



					</div>
					<button id="optionAdd" type="button"
						class="btn btn-primary col-md-2">필수옵션추가등록</button>

					<button id="optionDelete" type="button"
						class="btn btn-danger col-md-2">필수옵션등록삭제</button>

					<div id="fileList">
						<br>
						<label for="Files" class="form-label">썸네일 이미지</label> <input
							type="file" class="form-control essential" name='Files'
							id="thumnailFile">
						<!-- <button type="button" class="btn btn-primary col-md-2" id="fileAdd">fileadd</button> -->
					</div>
				</form>
				<br>
				<button type="button" id="submitbtn"
					class="btn btn-outline-primary col col-md-2 offset-md-10">등록
				</button>
			</div>
		</div>
	</div>
	<c:import url="../template/common_js.jsp"></c:import>
	<script src="/resources/js/healthMachineAdd.js"></script>

	<script src="/resources/js/essential.js"></script>
	<c:import url="../template/footer.jsp"></c:import>
</body>
</html>