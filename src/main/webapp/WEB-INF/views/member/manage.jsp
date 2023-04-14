<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
 <c:import url="../template/common_css.jsp"></c:import>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container-fluid">
<c:import url="../template/header.jsp"></c:import>
<div id="studyListResult"></div>



</div>

<c:import url="../template/footer.jsp"></c:import>
<c:import url="../template/common_js.jsp"></c:import>





<!-- 	<!-- Modal --> -->

<!-- 	<div class="modal fade" id="deleteModal" tabindex="-1" -->
<!-- 		aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable mx-auto"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h1 class="modal-title fs-5" id="exampleModalLabel">회원탈퇴</h1> -->
<!-- 					<button type="button" class="btn-close" data-bs-dismiss="modal" -->
<!-- 						aria-label="Close"></button> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body margin-bottom-xxxl"> -->
<!-- 					<div>가입된 회원정보가 모두 삭제됩니다. 작성하신 게시물은 삭제되지 않습니다.</div> -->
<!-- 					<div>탈퇴 후 같은 계정으로 재가입 시 기존에 가지고 있던 적립금은 복원되지 않으며, 사용 및 다운로드했던 -->
<!-- 						쿠폰도 사용 불가능합니다.</div> -->
<!-- 					<div>회원 탈퇴를 진행하시겠습니까?</div> -->
<!-- 				</div> -->
<!-- 				<div class="modal-footer"> -->
<!-- 					<button type="button" class="btn btn-primary" -->
<!-- 						id="memberDeleteBtnModal">탈퇴하기</button> -->
<!-- 					<button type="button" class="btn btn-secondary" id="modalClose" -->
<!-- 						data-bs-dismiss="modal">Close</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->


<script type="text/javascript">

//kakao_delete //자기자신을 삭제할 경우 로그아웃 함수도 불러야함.
// $('#memberDeleteBtnModal').on("click",$("delBtn"),function(){ //delBtn=모달창열기?
		
//만약 attr이 로그인타입 kakao라면 연결끊기를 실행.
$('#studyListResult').on("click",".delBtn",function(){		 //몇번째 클릭했는지 모달이 알아오네?
	console.log($(this).attr('data-del-id'))
	console.log($(this).attr('data-del-loginType'))
    //kakaoDelete() 
    if($(this).attr('data-del-loginType')){
    $.ajax({
        type:"POST",
        url:"/member/adminDel",
        data:{
            id:$(this).attr('data-del-id')
        },
        success:function(res){
            console.log(res.trim()) //삭제된 아이디
            if(res.trim()>0){
                
			//카카오계정의 일반회원탈퇴
			memberDeleteBack()
// 			//연결 초기화
// 			Kakao.init('b33abf940795b63ab2232ec9938a6b80');
// 			Kakao.isInitialized();
			//access 토큰 초기화 //admin이 초기화되면 안대는데..
// 			Kakao.Auth.logout()
            	
            }
        },
        error:function(){alert('오류')}
    })
    }else{
    	memberDeleteBack() //일반계정의 탈퇴
    }
    
})

//서버계정탈퇴 함수
function memberDeleteBack(){
    $.ajax({
        type:"POST",
        url:"/member/delete",
        data:{
            id:$(this).attr('data-del-id')	//버튼에 있는 속성의 memberId를 가져옴.
        },
        success:function(res){
            console.log(res.trim())
            if(res.trim()>0){
                
                console.log("res: "+res)
                $('#modalClose').click()
                alert("탈퇴완료")
                memberList()
                //location.href="/member/manage"
            }
        },
        error:function(){alert('서버계정탈퇴 오류')}
    })
}


memberList()
//studyQna목록
function memberList(){
	fetch("/member/memberList",{
	    method:'POST'
	})
	.then((response)=>response.text())
	.then((res)=>{
	    $('#studyListResult').html(res.trim());
	})

	    
	//page를 요청할 수 있도록 만든 이벤트
	$('#studyListResult').on("click",".page-qna",function(e){
	    let page = $(this).attr('data-board-page');
	    let kind =''
	    $(".searchOption").each(function(idx, item){
	        if($(item).prop("selected")){
	            kind = $(item).val();
	        }
	    })

	    let search = $("#search").val();

	    fetch("/member/memberList?page="+page+"&kind="+kind+"&search="+search,{
	        method:'POST'
	    })
	    .then((response)=>response.text())
	    .then((res)=>{
	        $('#studyListResult').html(res.trim());
	    })

	    e.preventDefault();
	})

	//검색할 수 있도록 만든 이벤트
	$('#studyListResult').on("click","#searchbutton",function(e){
	    let kind = ''
	    $(".searchOption").each(function(idx, item){
	        if($(item).prop("selected")){
	            kind = $(item).val();
	        }
	    })

	    let search = $("#search").val();

	    fetch("/member/memberList?kind="+kind+"&search="+search,{
	        method:'POST',
	    })
	    .then((response)=>response.text())
	    .then((res)=>{
	        $('#studyListResult').html(res.trim());
	    })
	})	
}





// let search = '';
// let kind = '';
// getPage()
// function getPage(){
//     fetch("/member/memberList?kind="+kind+"&search="+search,{
//         method:'POST',
//     })
//     .then((response)=>response.text())
//     .then((res)=>{
//         $('#studyListResult').html(res.trim());
//     })
// }

// //page를 요청할 수 있도록 만든 이벤트
// $('#studyListResult').on("click",".page-qna",function(e){
//     let page = $(this).attr('data-board-page');
// 	console.log(page)
//     $(".searchOption").each(function(idx, item){
//         if($(item).prop("selected")){
//             kind = $(item).val();
//         }
//     })

//     search = $("#search").val();
//     //페이지
//     fetch("/member/memberList?kind="+kind+"&search="+search+"&page="+page,{
//         method:'POST',
//     })
//     .then((response)=>response.text())
//     .then((res)=>{
//         $('#studyListResult').html(res.trim());
//     })

//     e.preventDefault();
// })

// //검색할 수 있도록 만든 이벤트
// $('#studyListResult').on("click","#searchbutton",function(e){
    
//     $(".searchOption").each(function(idx, item){
//         if($(item).prop("selected")){
//             kind = $(item).val();
//         }
//     })

// 	search = $("#search").val();
//     getPage()

// })
</script>

</body>
</html>