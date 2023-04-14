<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<c:import url="../template/common_css.jsp"></c:import>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"> -->
<style type="text/css">


/* orderController getOrderList ViewName */
body {
            min-height: 100vh;
            background-size: cover;
            font-family: 'Lato', sans-serif;
            color: rgba(116, 116, 116, 0.667);
/*             background: linear-gradient(140deg , #fff , 50% , #BA68C8);     */
        }
        .container-fluid {
            margin-top: 50px ;
        }
        p {
            font-size: 14px;
            margin-bottom: 7px;
        }
        .small {
            letter-spacing: 0.5px !important;
        }
        .card-1 {
            box-shadow: 2px 2px 10px 0px rgb(190, 108, 170);
        }
        hr {
            background-color: rgba(248, 248, 248, 0.667);
        }
        .bold {
            font-weight: 500;
        }
        .change-color {
            color: #AB47BC !important;
        }
        .card-2 {
            box-shadow: 1px 1px 3px 0px rgb(112, 115, 139);
        }
        .fa-circle.active {
            font-size: 8px;
            color: #AB47BC;
        }
        .fa-circle {
            font-size: 8px;
            color: #aaa;
        }
        .rounded {
            border-radius: 2.25rem !important;
        }
        .progress-bar {
            background-color: #AB47BC !important;
        }
        .progress {
            height: 5px !important;
            margin-bottom: 0;
        }
        .invoice {
            position: relative;
            top: -70px;
        }
        .Glasses {
            position: relative;
            top: -12px !important;
        }
        .card-footer {
            background-color: #AB47BC;
            color: #fff;
        }
        h2 {
            color: rgb(78, 0, 92);
            letter-spacing: 2px !important;
        }
        .display-3 {
            font-weight: 500 !important;
        }
        @media (max-width: 479px) {
            .invoice {
                position: relative;
                top: 7px;
            }
            .border-line {
                border-right: 0px solid rgb(226, 206, 226) !important;
            }
        }
        @media (max-width: 700px) {
            h2 {
                color: rgb(78, 0, 92);
                font-size: 17px;
            }
            .display-3 {
                font-size: 28px;
                font-weight: 500 !important;
            }
        }
        .card-footer small {
            letter-spacing: 7px !important;
            font-size: 12px;
        }
        .border-line {
            border-right: 1px solid rgb(226, 206, 226)
        }
</style>
</head>
<body>
	<c:import url="../template/header.jsp"></c:import>

<div class="calendar"></div>
<input type="date" id="startDate" name="startDate"/>~<input type="date" id="endDate" name="endDate" />
<button type="button" onclick="javascript:datedate()">날짜검색</button>


	<div class="container-fluid">
		<div class="row">
<%-- 			<c:import url="../member/memberHeader.jsp"></c:import> --%>

<div class="col-2 mx-1 mb-3" style="box-shadow: 2px 2px 10px 0px rgb(190, 108, 170); ">
<ul class="nav flex-column">
  <li class="nav-item">
    <a class="nav-link active mt-1" aria-current="page" href="/order/list">주문/배송</a>
  </li>
   <li class="nav-item">
    <a class="nav-link" href="/member/update">개인정보</a>
  </li> 
  <li class="nav-item">
    <a class="nav-link" href="/member/delivery">배송지 설정</a>
  </li>
  <c:if test="${sessionMember.roleDTO.roleName eq 'ADMIN'}">
  <li><a class="nav-link" href="/member/manage">회원관리</a></li>
  </c:if>
</ul>
</div>


			<div class="col-8">
				<div class="row ajaxOut"><!-- ajaxOut -->




					

					

					
					
				</div><!-- ajaxOut -->
			</div>

<div class="col-2"></div>
		</div>
	</div>


	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#deleteModal">회원탈퇴</button>

	<!-- Modal -->

	<div class="modal fade" id="deleteModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable mx-auto">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">회원탈퇴</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body margin-bottom-xxxl">
					<div>가입된 회원정보가 모두 삭제됩니다. 작성하신 게시물은 삭제되지 않습니다.</div>
					<div>탈퇴 후 같은 계정으로 재가입 시 기존에 가지고 있던 적립금은 복원되지 않으며, 사용 및 다운로드했던
						쿠폰도 사용 불가능합니다.</div>
					<div>회원 탈퇴를 진행하시겠습니까?</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="memberDeleteBtnModal" onclick="javascript:modalMemberDelete()">탈퇴하기</button>
					<button type="button" class="btn btn-secondary" id="modalClose"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>







	
	<script src="/resources/js/member/memberDelete.js"></script>

	<c:import url="../template/footer.jsp"></c:import>
	<c:import url="../template/common_js.jsp"></c:import>

	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/order/orderList.js"></script>

</body>
</html>