// $('#emailDiv').append('<label class="form-label" id="emailLabel" for="email">뭐</label>')

let checkCount = [];
// $('#terms').click(()=>{


// 	fetch('member/agree', {
// 			method:"get",
// 	})
// 	//응답객체에서 Data 추출
// 	.then((response)=> response.text()) // (response)=> {return response.text()}
// 	//추출한 Data 사용
// 	.then((res)=> console.log(res))
// 	//예외 발생시 처리
// 	.catch(()=>console.log('에러 발생'))
	
// })


//@약관동의창
function mAgree(){

	$('#modalBtn').click()

	fetch("/member/agree", {
		method:"get",
	}).then((response)=> response.text()) // (response)=> {return response.text()}
	.then((res)=> {
		// console.log(res)
		$('.modal-body').text(res)
	})
	//예외 발생시 처리
	.catch(()=>console.log('에러 발생'))
}

$('#modalSubmit').click(()=>{
	$('.form-check-input').attr("checked", "checked")
	$('#modalCancel').click();
})

//@회원가입버튼
$('#submitBtn').click(()=>{
	if(! $('.form-check-input').attr("checked")=="checked"){
		alert("약관동의점..")

	}else if(checkCount.includes(false)){
		alert("필수정보 입력점")
	}else{
		$('#submitBtn').attr("type", "submit")
	}

})

//@idCheck
$('#id').blur(()=>{
	console.log($('#id').val())
	fetch('/member/idCheck', {
		method:"POST",
		headers:{"Content-type":"application/x-www-form-urlencoded"},
		body:"id="+$('#id').val(),
	}).then((response)=>{

		return response.text()
	})
	.then((res)=>{

		if(res.trim()=="사용가능"){
			// $('#idLabel').prop("hidden", "false")
			$('#idLabel').prop("class", "form-label blueResult")
			$('#idLabel').text("사용가능 아이디")
			console.log('사용가능 아이디')
			checkCount[0]=true;

		}else if(res.trim()=="중복아이디"){
			// $('#idLabel').prop("hidden", "false")
			$('#idLabel').prop("class", "form-label redResult")
			$('#idLabel').text("아이디 중복")
			console.log('아이디 중복')
			checkCount[0]=false;
		}else{
			$('#idLabel').prop("class", "form-label redResult")
			$('#idLabel').text("필수정보")
			checkCount[0]=false;
		}
	})

})

// console.log($('#email').attr('id'))
//@emailCheck
$('#email').blur(()=>{
	// console.log($('#email').val())
	fetch('/member/emailCheck', {
		method:"POST",
		headers:{"Content-type":"application/x-www-form-urlencoded"},
		body:"email="+$('#email').val(),
	}).then((response)=>{

		return response.text()
	})
	.then((res)=>{

		$('#emailLabel').remove()
		$('#emailDiv').after('<label class=" form-label" id="emailLabel" for="email"></label>')


		if(res.trim()=="사용가능"){

			// //이메일 인증 form
			// $('#emailSendDiv').remove()
			// let emailSendDiv = '<div id="emailSendDiv" class="hstack gap-3">';
			// emailSendDiv=emailSendDiv+'<input class="col form-control " type="text" placeholder="인증번호">'
			// emailSendDiv=emailSendDiv+'<button type="button" class="col-2 btn btn-secondary text-nowrap">제출</button>'
			// emailSendDiv=emailSendDiv+'<div class="vr "></div>'
			// emailSendDiv=emailSendDiv+'<button type="button" class="col-2 btn btn-outline-danger text-nowrap">다시</button>'
			// emailSendDiv=emailSendDiv+'</div>'
			// $('#emailDiv').after(emailSendDiv)

			
			$.get("/member/verificationCode", function(res){
				if(res==1){
					$('#emailLabel').prop("class", "form-label blueResult")
					$('#emailLabel').text("보냈어용^^ "+$('#email').attr('id'))
				}
			})

			// console.log('사용가능 '+$('#email').attr('id'))
			// checkCount[0]=true;

		}else if(res.trim()=="중복"){
			// $('#idLabel').prop("hidden", "false")
			$('#emailLabel').prop("class", "form-label redResult")
			$('#emailLabel').text($('#email').attr('id')+" 중복")
			console.log('중복'+$('#email').attr('id'))
			checkCount[0]=false;
		}else{
			$('#emailLabel').prop("class", "form-label redResult")
			$('#emailLabel').text("필수정보")
			checkCount[0]=false;
		}
	})

})

//@pwCheck
 let password = document.getElementById('password')
 let passwordCheck = document.getElementById('passwordCheck')
// password.addEventListener('blur', function(){
// 	if(password.value.length<7||password.value.length>15){
// 		console.log('6자리 이상 14이하')
// 	}
		
// })

$('#password').blur(()=>{

	// if(password.value == null){
	// 	$('#passwordLabel').text('필수입력')
	// 	$('#passwordLabel').prop("class", "form-label redResult")
	// 	checkCount[1]=false;
	// }

	if(password.value.length<6 || password.value.length>14){
		$('#passwordLabel').text('6자리 이상 14이하')
		$('#passwordLabel').prop("class", "form-label redResult")
		checkCount[1]=false;
	}else{
		$('#passwordLabel').text("")
		checkCount[1]=true;
	}
})

//@pw재확인
$('#password').change(()=>{
	if(passwordCheck.value!=""&&password.value!=passwordCheck.value){
		$('#passwordCheckLabel').text('비밀번호가 다름')
		$('#passwordCheckLabel').prop("class", "form-label redResult")
		checkCount[1]=false;
	}else if(passwordCheck.value!=""&&password.value==passwordCheck.value){
		$('#passwordCheckLabel').text("")
		checkCount[1]=true;
	}
})
$('#passwordCheck').blur(()=>{
	if(password.value!=passwordCheck.value){
		$('#passwordCheckLabel').text('비밀번호가 다름')
		$('#passwordCheckLabel').prop("class", "form-label redResult")
		checkCount[1]=false;
	}else{
		$('#passwordCheckLabel').text("")
		checkCount[1]=true;
	}
})

function verificationRe(){
	$.get("/member/verificationCode", function(res){
		if(res==1){
			$('#emailLabel').remove()
			$('#emailDiv').after('<label class=" form-label" id="emailLabel" for="email"></label>')
			$('#emailLabel').prop("class", "form-label blueResult")
			$('#emailLabel').text("다시 보냈어용^^ "+$('#email').attr('id'))
		}
	})
}
function verificationSubmit(){
	$.get("/member/verificationCodeCheck?verificationCode="+$('#verification_val').val(), function(res){
		console.log(res)
		if(res.trim()=="yes"){
			$('#verificationLabel').remove()
			$('#verification_div').after('<label class=" form-label" id="verificationLabel"></label>')
			$('#verificationLabel').prop("class", "form-label blueResult")
			$('#verificationLabel').text("굳^^ "+$('#email').attr('id'))
			checkCount[1]=true;
		}else{
			$('#verificationLabel').remove()
			$('#verification_div').after('<label class=" form-label" id="verificationLabel"></label>')
			$('#verificationLabel').prop("class", "form-label redResult")
			$('#verificationLabel').text("불일치")
			checkCount[1]=false;
		}
	})
}