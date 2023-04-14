<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어트</title>

	<style type="text/css">
		.redResult{
			color: red;
		}
		.blueResult{
			color: blue;
		}
/* 		.member__input-guide-area_set{ */
/* 			color: gray; */
/* 			font-size: 12px; */
/* 		} */
	</style>

<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous"> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"> -->
<c:import url="../template/common_css.jsp"></c:import>
</head>
<body>
<c:import url="../template/header.jsp"></c:import>




<input type="hidden" id="originId" name="id" value="${sessionScope.sessionMember.id}">



<div class="container-fluid">
	<div class="row">


<%-- <c:import url="./memberHeader.jsp"></c:import> --%>
<div class="col-2 mx-1 mb-3">
<h3 class="h3" style="margin-left:15px;"> 마이페이지 </h3>
<ul class="nav flex-column" >
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
<div class="mt-3"><h2 class="usermodify-title">회원정보</h2></div>

	<table class="table">
		<tbody>
			<tr>
				<td class="col-3">아이디</td>
				<td class="col-9">${sessionMember.id }</td>
			</tr>
			<tr>
				<td class="col-3">이메일</td>
				<td class="col-9">${sessionMember.email }</td>
			</tr>

			<tr>
			</tr>
		</tbody>	
	</table>
	
	




<c:if test="${sessionMember.loginType eq 'general'}">
<form action="" id="pwUpdateForm">
	    <table class=" table " >    
			<tbody>

			<tr>
				<th nowrap="nowrap" scope="row"> <div style="padding">비밀번호 변경</div> </th>
				
				<td ><div class="usermodify-password">
	<table class="table usermodify-input-table">
		<tbody>		
			<tr>
			    <th class="col-2">현재 비밀번호</th>
			    <td class="col-10">
			        <input type="password" class="password-change1" id="password-change1"><div class="member__input-guide-area_set member__input-guide-area1"></div>
			    </td>
			</tr>
			<tr>
			    <th>새 비밀번호</th>
			    <td>
			        <input type="password" class="password-change2" id="password-change2"><div class="member__input-guide-area_set member__input-guide-area2"></div>
			    </td>
			</tr>
			<tr>
			    <th>비밀번호 다시 입력</th>
			    <td>
			        <input type="password" class="password-change3"><div class="member__input-guide-area_set member__input-guide-area3"></div>
			    </td>
			</tr>
			<tr>
				<td>
				    <button type="button" class="password-submit">비밀번호 변경</button>
				</td>
			</tr>
						</tbody></table>
					</div></td>
			</tr>
	    </tbody>
	</table>
</form>
</c:if>

</div>

<div class="col-2"></div>
<!-- container, row -->
	</div>
</div>





<!-- <section class="vh-200" style="background-color: #eee;"> -->
<!--   <div class="container-fluid"> -->
<!--     <div class=" justify-content-center align-items-center"> -->
<!--       <div class=""> -->
<!--             <div class="row justify-content-center"> -->
<!--               <div class="col-md-10"> -->
              
              
              
              
<!-- 	<div class="card" style="width: 70%;"> -->
<!-- 		<div class="card-body"> -->
<!--     <h1 class="usermodify-title">회원정보 수정</h1> -->

<!--     <table class="usermodify-table table table-striped"> -->
<!--         <tbody> -->
            



<!-- <tr> -->
<!--     <th scope="row">아이디(이메일)</th> -->
<!--     <td><div class="usermodify-email"> -->
<!-- 	<input type="hidden" id="originEmail" value="gmdiaal@gmail.com"> -->
<!-- 	<input type="hidden" id="regEmail" value="gmdiaal@gmail.com"> -->
<!-- 	<input type="hidden" id="emailDupCheck" value="N"> -->
<!--     <input type="hidden" id="changeEmail" value=""> -->

<!--     <strong class="usermodify-email-current-mail">gmdiaal@gmail.com</strong> -->
<!--     <button type="button" class="usermodify-email-change-btn">이메일 변경</button> -->
<!--     <button type="button" class="usermodify-email-change-cancel" style="display: none;">이메일 변경취소</button> -->

<!--     <form class="usermodify-email-change-auth" action="/login/checkEmailDuplication.pang" method="POST" style="display: none;"> -->
<!--         <input data-errmsg="이미 가입된 메일주소입니다. 다른 이메일을 입력하여 주세요." data-target="usermodify-email-change-errmsg" class="usermodify-email-tf" type="text" value="gmdiaal@gmail.com"> -->
<!--         <button type="submit" class="usermodify-email-change-auth-send">인증메일 전송</button> -->
<!--         <div class="form-err usermodify-email-change-errmsg" style="display: none;"></div> -->
<!--     </form> -->

<!--     <form class="usermodify-email-change-form" action="/member/modify/sendEmail.pang" method="POST" style="display: none;"> -->
<!--         <input type="password" class="usermodify-email-change-tf"> -->
<!--         <button type="submit" class="usermodify-email-change-submit">비밀번호 확인</button> -->
<!--         <span class="usermodify-email-change-msg">안전한 변경을 위해 쿠팡 비밀번호를 입력해주세요.</span> -->
<!--     </form> -->

<!--     <div class="usermodify-email-change-done"> -->
<!--         <div class="usermodify-email-change-done-msg"> -->
<!--             회원님은 현재 이메일주소를 변경하여, 신청하신 이메일(<strong class="usermodify-email-change-done-email"></strong>)로 인증메일이 발송되었습니다. -->
<!--             <br> -->
<!--             이메일 확인 후 <strong>회원정보 수정 인증</strong> 버튼을 클릭하시면 이메일 변경이 완료되며, 변경하신 이메일주소로 로그인 하실 수 있습니다. -->
<!--         </div> -->
<!--         <div class="usermodify-email-change-done-foot"> -->
<!--             <button type="button" class="usermodify-email-change-done-cancel">이메일 변경취소</button> -->
<!--             <button type="button" class="usermodify-email-change-resend">인증메일 재전송</button> -->
<!--         </div> -->
<!--     </div> -->
<!-- 	</div> -->
<!-- 	</td> -->
<!-- </tr> -->



        
<!-- <tr> -->
<!-- 	<th scope="row">비밀번호변경</th> -->
<!-- 	<td><div class="usermodify-password"> -->
<!-- 		<table class="usermodify-input-table"><tbody> -->
		
<!-- <tr> -->
<!--     <th>현재 비밀번호</th> -->
<!--     <td> -->
<!--         <input type="password" class="password-change1"><div class="member__input-guide-area_set member__input-guide-area1"></div> -->
<!--     </td> -->
<!-- </tr> -->
<!-- <tr> -->
<!--     <th>새 비밀번호</th> -->
<!--     <td> -->
<!--         <input type="password" class="password-change2"><div class="member__input-guide-area_set member__input-guide-area2"></div> -->
<!--     </td> -->
<!-- </tr> -->
<!-- <tr> -->
<!--     <th>비밀번호 다시 입력</th> -->
<!--     <td> -->
<!--         <input type="password" class="password-change3"><div class="member__input-guide-area_set member__input-guide-area3"></div> -->
<!--     </td> -->
<!-- </tr> -->


<!-- <tr> -->
<!--     <td></td> -->
<!-- <td> -->
<!--     <button type="button" class="password-submit">비밀번호 변경</button> -->
<!-- </td> -->
<!-- </tr> -->
<!-- 			</tbody></table> -->
<!-- 		</div></td> -->
<!-- </tr> -->
            
            
            
            
<!--             <tr> -->
<!--                 <th scope="row">배송지</th> -->
<!--                 <td>배송지 주소 관리는 <a href="#" id="deliveryAddressPopUp"><strong>[배송지 관리]</strong></a>에서 수정, 등록 합니다.</td> -->
<!--             </tr> -->
<!--             <tr> -->
<!--                 <td> -->


<!--                 </td> -->
<!--             </tr> -->
<!--         </tbody> -->
<!--     </table> -->
<!--     <div class="usermodify-secession"> -->
<!--         탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요. -->
<!--         <a class="usermodify-secession-btn" href="secession.pang">회원탈퇴</a> -->
<!--     </div> -->
<!--     <div class="usermodify-foot"> -->
<!--         <button type="button" class="usermodify-cancel">나가기</button> -->
<!--     </div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
<!-- </section> -->

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
<c:import url="../template/common_js.jsp"></c:import>
<script src="/resources/js/member/memberUpdate.js"></script>
<c:import url="../template/footer.jsp"></c:import>
<!-- <script src="/resources/js/member/memberAgree.js"></script> -->

</body>
</html>