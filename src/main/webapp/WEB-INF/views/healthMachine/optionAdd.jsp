<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션추가 관리자페이지</title>
<c:import url="../template/common_css.jsp"></c:import>
<c:import url="../template/header.jsp"></c:import>
<style>
body {
	font-family: 'IBM Plex Sans KR', sans-serif;
}

.boxxx {
	width: 100%;
	border-radius: 0.25rem;
	border: 3px #2c396b double;
	
}

.boxx {
	width: 100%;
	overflow: hidden;
	margin: 10px auto;
	padding-bottom: 4%;
	padding-top: 2%;
	background-color: #fff;
	overflow: visible;
}

.container {
	position: relative;
	padding: 3% auto;
} /*폭을 일정하게 담기 위한 css*/
.one {
	display: flex;
	clear: both;
	
} /* container div중 하나를 선택하기 위한 id태그*/
.first {
	width: 50%;
	padding: 0 2%;
	
} /* 화면을 이분할하기 위해 width에 50% 적용 */
.second {
	width: 50%;
	padding: 0 2%;
	
} /* 화면을 이분할하기 위해 width에 50% 적용 */
.form-label {
	font-weight: 700;
	font-size: 20px;
}

.btn {
margin-bottom:3%;
}
</style>
</head>
<body>

	<div class="container-fluid">
		<div class="essbox">
			<div class="row mb-4 mt-4 md-7">
				<h4 class="col-md-5 mx-auto text-center pb-3">제품옵션추가 등록</h4>
			</div>
			<div class="boxxx col-md-6 mx-auto">
				<div class="row col-md-12 mx-auto">
					<form action="./optionAdd" method="POST"
						enctype="multipart/form-data" id="frm">
						<div class="row text-center" id="optionSelect"
							data-machineNum="${dto.machineNum}">
							<input type="hidden" name="machineNum" value="${dto.machineNum}">

							<div class="boxx">
								<label for="optName1" class="form-label">옵션1
									${dto.option1}</label>
								<section class="one">
									<div class="first">
										<div class="dropdown" id="opt1" data-optName="${dto.option1}">
											<input type="text"
												class="form-control optInput text-center essential"
												name="optName1" placeholder="${dto.option1}작성">
										<div class="dropdown-menu">
											<ul style="list-style: none" id="optSelect1">
												<c:forEach items="${optList1}" var="option">
													<li class="dropdown-item cursor-pointer" id="op1"
														data-id="${option.optId1}" data-name="${option.optName1}">${option.optName1}</li>
												</c:forEach>
											</ul>
										</div>
										</div>
									</div>
										<div class="second">
										<input type="text"
											class="form-control optInputId text-center essential"
											name="optId1" placeholder="영문명">
									</div>
								</section>
							</div>

							<c:if test="${not empty dto.option2}">
								<p class="underline" style="border-bottom: 2px dotted;"></p>
								<div class="boxx">
									<label for="optName2" class="form-label">옵션2
										${dto.option2}</label>
									<section class="one">
										<div class="first">
											<div class="dropdown" id="opt2" data-optName="${dto.option2}">
												<input type="text"
													class="form-control optInput text-center essential"
													name="optName2" placeholder="${dto.option2}작성">
											<div class="dropdown-menu">
												<ul style="list-style: none" id="optSelect2">
													<c:forEach items="${optList2}" var="option">
														<li class="dropdown-item cursor-pointer" id="op2"
															data-id="${option.optId2}" data-name="${option.optName2}">${option.optName2}</li>
													</c:forEach>
												</ul>
											</div>
											</div>
										</div>
											<div class="second">
											<input type="text"
												class="form-control optInputId text-center essential"
												name="optId2" placeholder="영문명">
										</div>
									</section>
								</div>
							</c:if>
							<c:if test="${not empty dto.option3}">
							<p class="underline" style="border-bottom: 2px dotted;"></p>
								<div class="boxx">
									<label for="optName3" class="form-label">옵션3
										${dto.option3}</label>
									<section class="one">
										<div class="first">
											<div class="dropdown" id="opt3"
												data-optName="${dto.option3 }">
												<input type="text"
													class="form-control optInput text-center essential"
													name="optName3" placeholder="${dto.option3}작성">
											
											<div class="dropdown-menu">
												<ul style="list-style: none" id="optSelect3">
													<c:forEach items="${optList3}" var="option">
														<li class="dropdown-item cursor-pointer" id="op3"
															data-id="${option.optId3}" data-name="${option.optName3}">${option.optName3}</li>
													</c:forEach>
												</ul>
											</div>
											</div>
										</div>
											<div class="second">
											<input type="text" class="form-control optInputId text-center essential"
												name="optId3" placeholder="영문명">
										</div>
										
									</section>
								</div>
							</c:if>
							<c:if test="${not empty dto.option4}">
								<div class="boxx">
									<label for="optName4" class="form-label">옵션4
										${dto.option4}</label>
									<section class="one">
										<div class="first">
											<div class="dropdown" id="opt4"
												data-optName="${dto.option4 }">
												<input type="text" class="form-control optInput essential"
													name="optName4" placeholder="${dto.option4}작성">
											
										
											<div class="dropdown-menu">
												<ul style="list-style: none" id="optSelect4">
													<c:forEach items="${optList4}" var="option">
														<li class="dropdown-item cursor-pointer" id="op4"
															data-id="${option.optId4}" data-name="${option.optName4}">${option.optName4}</li>
													</c:forEach>
												</ul>
												</div>
										</div>
											</div>
											<div class="second">
											<input type="text" class="form-control optInputId essential text-center"
												name="optId4" placeholder="영문명">
										</div>
									</section>
								</div>
							</c:if>
							<p class="underline" style="border-bottom: 2px dotted;"></p>

							<div class="mb-3 col-4">
								<label for="stock" class="form-label">재고</label> <input
									type="text" class="form-control essential" name="stock">
							</div>
						</div>



						<button type="button" id="submitbtn"
							class="btn btn-outline-primary col col-md-2 offset-md-10">등록하기
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<c:import url="../template/common_js.jsp"></c:import>
	<script src="/resources/js/essential.js"></script>
	<script src="/resources/js/healthMachineAdd.js"></script>
	<c:import url="../template/footer.jsp"></c:import>
</body>
</html>