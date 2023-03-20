<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

	<style type="text/css">
		.redResult{
			color: red;
		}
		.blueResult{
			color: blue;
		}
	</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body>

<section class="vh-100" style="background-color: #eee;">
  <div class="container-fluid ">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-lg-12 col-xl-11 ">
            <div class="row justify-content-center">
              <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
        <div class="card text-black" style="border-radius: 25px;">
          <div class="card-body">

                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign up</p>

                <form class="mx-1 mx-md-4" action="./join" method="post">

                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" id="id" name="id" class="form-control" placeholder="아이디"/>
                           <label class="form-label" id="idLabel" for="id"></label>
					<div class="hstack gap-3" id="emailDiv">
                      <input type="email" id="email" name="email" class="col form-control" placeholder="이메일"/>
<!--                       <button type="button" class="col-2 btn btn-secondary text-nowrap">인증</button> -->
					</div>
                    

<div id="verification_div" class="hstack gap-3">
  <input class="col form-control" id="verification_val" type="text" placeholder="인증번호">
  <button type="button" id="verification_submit" onclick="javascript:verificationSubmit()" class="col-2 btn btn-secondary text-nowrap">제출</button>
  <div class="vr "></div>
  <button type="button" id="verification_re" onclick="javascript:verificationRe()" class="col-2 btn btn-outline-danger text-nowrap">다시</button>
</div>


                      <input type="password" id="password" name="pw" class="form-control" placeholder="비밀번호"/>
                      <label class="form-label" for="Password" id="passwordLabel"></label>
                      <input type="password" id="passwordCheck" class="form-control" placeholder="비밀번호 확인"/>
                      <label class="form-label" id="passwordCheckLabel" for="passwordCheck"></label>
                    </div>
                  </div>
                  
                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" id="name" name="names" class="form-control" placeholder="이름"/>
<!--                       <label class="form-label" for="name">Your Name</label> -->
                    </div>
                  </div>



                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" id="phone" name="phone" class="form-control" placeholder="연락처"/>
<!--                       <label class="form-label" for="phone">연락처</label> -->
                    </div>
                  </div>

                  <div class="d-flex flex-row align-items-center mb-4">
                    <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" id="address" name="address" class="form-control" placeholder="주소"/>
<!--                       <label class="form-label" for="address">주소</label> -->
                      <input type="text" id="addressDetail" name="address" class="form-control" placeholder="상세주소"/>
<!--                       <label class="form-label" for="addressDetail">주소</label> -->
                    </div>
                  </div>

                  <div class="form-check d-flex justify-content-center mb-5">
                    <input class="form-check-input me-2" readonly type="checkbox" value="" id="agree" />
                    <label class="form-check-label" for="agree">
                      I agree all statements in <a id="terms" href="javascript:mAgree()">Terms of service</a>
                    </label>
                  </div>

                  <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                    <button type="button" id="submitBtn" class="btn btn-primary btn-lg">회원가입</button>
                  </div>

                </form>

              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>


<c:import url="./common_js.jsp"></c:import>

<script src="/resources/js/member/memberAgree.js"></script>

</body>
</html>