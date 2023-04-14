fo
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 수정페이지</title>
<c:import url="../template/common_css.jsp"></c:import>
<c:import url="../template/header.jsp"></c:import>
<style>
body {
font-family: 'IBM Plex Sans KR', sans-serif;
}
.boxxx {
	width: 100%;
          overflow: hidden;
          margin: 20px auto;
          padding-left:2%;
          padding-bottom: 4%;
          padding-top: 2%;
          background-color: #fff;
}

.boxx {
          width: 100%;
          overflow: hidden;
          margin: 10px auto;
          padding-bottom: 4%;
          padding-top: 2%;
          background-color: #fff;
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
        width: 40%;
        padding: 0 1% 0 0;
      } /* 화면을 3분할하기 위해 width에 40% 적용 */
      
      .second {
        width: 30%;
        padding: 0 1% 0 0;
      } /* 화면을 3분할하기 위해 width에 30% 적용 */
      
       .third {
        width: 30%;
        padding: 0;
      } /* 화면을 3분할하기 위해 width에 30% 적용 */
      
      #third {
        width: 30%;
        padding: 0;
      } /* 화면을 3분할하기 위해 width에 30% 적용 */
      
      
      .boxone {
      	width: 25%;
      	padding: 0 1% 0 0;
      
      }
      .boxtwo {
        width: 25%;
        padding: 0 1% 0 0;
      }
      
      .boxthree {
        width: 25%;
        padding: 0 1% 0 0;
      }
      
      .boxfour {
        width: 25%;
      }
         
      .form-label {
      	font-weight:700;
      	font-size: 17px;
      }
      
      #optionAdd{
      	padding-left: 3%;
      }
               
</style>
</head>

<body>
	<div class="container-fluid">
	<div class="essbox">
		<div class="row mb-4 mt-4 md-7">
			<h1 class="col-md-5 mx-auto text-center pb-3">제품 수정</h1>
		</div>
			<form action="./update" method="POST" enctype="multipart/form-data" id="frm">
		<div class="row col-md-7 mx-auto">
				<input type="hidden" value="${dto.machineNum}" id="machineNum"
					name="machineNum">
				<div class="mb-3" id="categoryList">
					<label for="categoryNum" class="form-label">카테고리</label>

					<c:forEach items="${dto.categoryDTO }" var="category">
						<div class="input-group mb-1">
							<input type="text" class="form-control"
								value="${category.categoryName }" readonly="readonly"
								disabled="disabled"> <input type="hidden"
								class="form-control" value="${category.categoryNum }"
								readonly="readonly" name="categoryDTOs">
							<button class="btn btn-outline-danger categoryDel" type="button"
								data-category-num="${category.categoryNum }">X</button>
						</div>
					</c:forEach>
				</div>
				<div id="categorybtn">
					<button type="button" class="btn btn-primary" id="categoryAdd">카테고리추가</button>
					<!-- <button type="button" class="btn btn-danger" id="categoryDelete">카테고리 삭제</button> -->
				</div>
				<input type="hidden" value="${dto.machineNum}" id="machineNum">
				<div class="boxx">
				<section class="one">
				<div class="first">
				<div class="mb-3">
					<label for="machineName" class="form-label">제품명</label> <input
						type="text" class="form-control essential" name="machineName"
						value="${dto.machineName }">
				</div>
				</div>
				<div class="second">
				<div class="mb-3">
					<label for="price" class="form-label">가격</label> <input type="text"
						class="form-control essential" name="price" value="${dto.price }">
				</div>
				</div>
				<div class="third">
				<div class="mb-3">
					<label for="salePrice" class="form-label">할인가격</label> <input
						type="text" class="form-control essential" name="salePrice"
						value="${dto.salePrice }">
				</div>
				</div>
				</section>
				</div>
				<div class="boxxx">
			<section class="one">
				<div id="optionList" class="boxone">
					<div class="mb-3" id=option1>
						<label for="option1" class="form-label options">옵션1 이름</label> 
						<input type="text" class="form-control essential" name="option1" value="${dto.option1 }">
					</div>
					</div>
					<c:if test="${not empty dto.option2 }">
					<div class="boxtwo">	
						<div class="mb-3" id=option2>
							<label for="option2" class="form-label options">옵션2 이름</label> 
							<input type="text" class="form-control essential" name="option2" value="${dto.option2 }">
							</div>
						</div>
					</c:if>
					<c:if test="${not empty dto.option3 }">
					<div class="boxthree">
						<div class="mb-3" id=option3>
							<label for="option3" class="form-label options">옵션3 이름</label> 
							<input type="text" class="form-control essential" name="option3" value="${dto.option3 }">
							</div>
						</div>
					</c:if>
					<c:if test="${not empty dto.option4 }">
					<div class="boxfour">
						<div class="mb-3" id=option4>
							<label for="option4" class="form-label options">옵션4 이름</label> 
							<input type="text" class="form-control essential" name="option4" value="${dto.option4 }">
							</div>
						</div>
					</c:if>
				</section>
				</div>
				</div>
				<div class="row col-6 mx-auto">
				<button id="optionAdd" type="button" class="btn btn-primary col-md-2">새옵션추가</button>
				<p></p>
				<button id="optionDelete" type="button" class="btn btn-danger col-md-2">추가옵션삭제</button>
				</div>
				<div class="mb-3 imageList">
					<div id="thumnailFile">
						<c:if test="${not empty dto.healthMachineImgDTOs[0]}">
							<div class="input-group mb-3 my-3 thumnail">
								<div class="input-group-text">
									<input class="form-check-input mt-0 deleteCheck"
										type="checkbox" id="thumnailCheck"
										value="${dto.healthMachineImgDTOs[0].fileNum}" name="fileNum">
								</div>
								<input type="text" disabled
									value="${dto.healthMachineImgDTOs[0].oriName}"
									class="form-control">
							</div>
						</c:if>
						<input type="hidden" value="${dto.healthMachineImgDTOs[0].fileNum }" name="thumnailNum">
					</div>
					<button class="btn btn-outline-primary col-md-2" type="button" id="thumnailbtn">썸네일</button>
					<br>
					<div id="fileList">
						<c:if test="${not empty dto.healthMachineImgDTOs[1]}">
							<c:forEach items="${dto.healthMachineImgDTOs}" var="images" begin="1">
								<div class="input-group mb-3 my-3 fileList">
									<div class="input-group-text">
										<input class="form-check-input mt-0 deleteCheck" type="checkbox" value="${images.fileNum}" name="fileNum">
									</div>
									<input type="text" disabled value="${images.oriName}" class="form-control">
								</div>
							</c:forEach>
						</c:if>
					</div>
					<button type="button" class="btn btn-primary col-md-2" id="fileAdd">파일추가</button>
				</div>
				<br>
				<div class="mb-3" id="realMachineList">
				</div>

				<button type="button" id="submitbtn" class="btn btn-outline-primary col col-md-2 offset-md-10">수정등록</button>
			</form>
			<div class="text-center" id="optionSelect"
				data-machineNum="${dto.machineNum}">
				<div class="dropdown" id="opt1" data-optName="${dto.option1 }">

					<button class="btn dropdown-toggle" id="optbtn1">${dto.option1}을
						선택해 주세요</button>
					<div class="dropdown-menu">
						<ul style="list-style: none;" id='optSelect1'>

						</ul>
					</div>
				</div>
				<div class="dropdown" id="opt2" data-optName="${dto.option2 }"></div>
				<div class="dropdown" id="opt3" data-optName="${dto.option3 }"></div>
				<div class="dropdown" id="opt4" data-optName="${dto.option4 }"></div>
			</div>
		</div>
	</div>
	<c:import url="../template/common_js.jsp"></c:import>
	<script src="/resources/js/healthMachineUpdate.js"></script>
	<script src="/resources/js/essential.js"></script>
	<script>
		
		setParam('Files');
	</script>
	<c:import url="../template/footer.jsp"></c:import>
</body>
</html>