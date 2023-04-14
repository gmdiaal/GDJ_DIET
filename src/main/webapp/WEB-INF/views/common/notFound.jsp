<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/style.css">
  <style>
 img { display : block;
       margin:auto;}

    </style>
</head>
<body>
<div class="row mx-auto">
	<div class="col-3 w-100 mx-auto my-5 border">
		<!-- <form action="/member/myPage" method="get" id="frm"> -->
            
           <a class="navbar-brand w-100 mt-3 text-center" style="font-size:25px" href="/"> 잘못된 접근 </a>
            <div class="underline"></div>
			<div id="img" style="cursor: pointer;">
				<img alt="..." src="/resources/images/alert.png">
				
				<div class="text-center justify-content-center">
                    <div>
                    <p style="color:tomato; font-weight: bolder;">Not Found</p><p style="color:black;">잘못된 경로입니다<br></p>
                
                    <p>잘못된 경로로 접속하셨습니다<br>
                    올바른 주소로 서비스를 이용해주세요</p>
                    </div>
                

                </div>
                <div class="underline"></div>
                <div class="row col-4 my-2">
				    <a href="/" onclick="goBack()">돌아가기</a>
				</div>

				</div>
		<!--  </form> -->
		</div>
	</div>
	

<script>
function goBack() {
    event.preventDefault(); // 링크의 기본 동작을 막음
    history.back(); // 이전 페이지로 이동
}
</script>

</body>
</html>