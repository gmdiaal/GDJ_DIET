<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>구디다이어트</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<c:import url="../template/common_css.jsp"></c:import>

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

</head>

<body>
	<c:import url="../template/header.jsp"></c:import>

	<div class="container-fluid">
		<div class="essbox">
			<div class="row justify-content-center">
				<h1 class="col-md-7 text-center my-5">Q&amp;A 상품문의</h1>
			</div>

			<div class="row justify-content-center">
				<form class="col-md-7" action="./add" method="post" id="frm">
					<input type="hidden" class="essential" name="machineNum"
						value="${pager.machineNum}" id="machineNum">
					<div class="mb-3">
						<label for="writer" class="form-label">작성자</label>
						<c:if test="${not empty sessionMember}">
							<input type="text" name="writer" class="form-control essential"
								id="writer" value="${sessionMember.id}" readonly>
						</c:if>
						<c:if test="${empty sessionMember}">
							<input type="text" name="writer" class="form-control essential"
								id="writer" value="${sessionMember.id}" disabled>
						</c:if>
					</div>

					<div class="mb-3">
						<label for="title" class="form-label">제목</label> <input
							type="text" name="title" class="form-control essential"
							id="title" placeholder="제목 입력">
					</div>

					<div class="mb-3">
						<label for="contents" class="form-label">상세내용</label>
						<textarea name="contents" class="form-control " id="contents"
							placeholder="설명입력" rows="7"></textarea>
					</div>

					<div class="mb-3">
						<button class="btn btn-primary" id="submitbtn" type="button">글쓰기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	
	<script src="/resources/js/essential.js"></script>
	<c:import url="../template/common_js.jsp"></c:import>
	<c:import url="../template/footer.jsp"></c:import>
	<script>
		$('#contents').summernote();
	</script>
</body>
</html>