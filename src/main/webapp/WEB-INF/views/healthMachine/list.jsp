<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>리스트</title>

<c:import url="../template/common_css.jsp"></c:import>
<c:import url="../template/header.jsp"></c:import>
 <link href="../resources/css/mlist.css" rel="stylesheet" type="text/css" />
<style>


.str1{
color:tomato;
position:absolute;
margin-top:0;
text-align:right;
}


</style>


</head>

<body>
	<div class="container">
	 <div class="row justify-content-center mb-5 pb-3">
 	 <div class="col-md-12 heading-section ftco-animate text-center" style="line-height:5%">
 	 <h3 class="mb-1"><br>홈트용품 & 액세서리</h3><br><br>
 	</div></div></div>
	
	
			<div>
				<c:if test="${sessionMember.roleDTO.roleName eq 'ADMIN'}">
					<a href="./add" class="btn btn-primary">운동기구 추가하기</a>
				</c:if>
			</div>
			
			 <header class="bg-dark py-4">
            <div class="container  my-3">
                <div class="text-center text-white">
                <img class="bg-dark" src="../resources/images/machinemain.png">
                  
                   
                </div>
            </div>
        </header>
        
	<section class="ftco-section" id="boxx">
	<section class="one">
	<div class="container row" id="first">
				<div class="first-cate"> 
				<p></p>
				<h3 class="cate-h">카테고리</h3> 
				<p class="cate-p"><a href="./list">전체</a></p>
				<p class="cate-p"><a href="./list?categoryNum=2">근력향상</a></p>
				<p class="cate-p"><a href="./list?categoryNum=3">스트레칭&균형</a></p>
				<p class="cate-p"><a href="./list?categoryNum=21">헬스소품&보호대</a></p>
				<p class="cate-p"><a href="./list?categoryNum=22">요가&필라테스</a></p>
				<p class="cate-p"><a href="./list?categoryNum=23">유산소</a></p>
				<p class="cate-p"><a href="./list?categoryNum=999">기타</a></p>
				</div>
				</div>
	<div class="container" id="second">
		<section class="ftco-section">
			<div class="container">
				<div class="row">
				<c:forEach items="${list}" var="dto">
				<div class="col-3 mb-3">
					<div class="classes w-70 ftco-animate">
						<a href="./detail?machineNum=${dto.machineNum}" class="img w-70 mb-2"
							style="background-image: url(/resources/images/${dto.healthMachineImgDTOs[0].fileName});"></a>
						<div class="text w-70 text-left">
							<p></p>
							<div class="row">
							<h5>
								<a href="./detail?machineNum=${dto.machineNum}">${dto.machineName}</a>
							</h5>
							<strong class="str1">
							<c:choose>
								<c:when test="${dto.machineScore lt 0.5}">
									<td class="td1">☆☆☆☆☆</td>
								</c:when>
								<c:when test="${dto.machineScore lt 1.5}">
									<td class="td1">★☆☆☆☆</td>
								</c:when>
								<c:when test="${dto.machineScore lt 2.5}">
									<td class="td1">★★☆☆☆</td>
								</c:when>
								<c:when test="${dto.machineScore lt 3.5}">
									<td class="td1">★★★☆☆</td>
								</c:when>
								<c:when test="${dto.machineScore lt 4.5}">
									<td class="td1">★★★★☆</td>
								</c:when>
								 <c:when test="${dto.machineScore lt 5.5}">
									<td class="td1">★★★★★</td>
								</c:when>
								<c:otherwise>
								        <td> </td>
								    </c:otherwise> 
						</c:choose>
						</strong>
						</div>
							<div class="priceBox">
							<span class="sale-price">${dto.salePrice}원</span> 
							
							<span class="ori-price" id="price">
							<strike style="color:tomato; margin-left:10px;">${dto.price}원</strike>
							</span>
							<p class="underline"></p>
							</div>
						
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			</div>
			</section>
			</div>
			</section>
			
	</section>
       
 

	<%-- <div class="container-fluid">
		<div class="row mb-4 mt-4 md-7">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>NUM</th>
						<th>category</th>
						<th>machinename</th>
						<th>score</th>
						<th>price</th>

						<th>saleprice</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.machineNum }</td>
							<td>${dto.categoryNum }</td>
							<td><a href="./detail?machineNum=${dto.machineNum }">${dto.machineName }</a></td>
							<td>${dto.machineScore }</td>
							<td>${dto.price }</td>
							<td>${dto.salePrice }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div> --%>
	
	<c:import url="../template/common_js.jsp"></c:import>
	<c:import url="../template/footer.jsp"></c:import>
</body>
</html>