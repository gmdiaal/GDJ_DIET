// update버튼 클릭 후 데이터를 넣고 담아 모달창 불러오기
$('.reviewUpdate').click(function(e){
    let num = $(this).attr("data-comment-num");
    $("#contentsConfirm").attr("data-comment-num",num);
    e.preventDefault();
})

// modal에서 확인버튼과 cancel버튼 눌렀을 때 동작
$("#contentsConfirm").click(function(){
    console.log('Update Post');
    let nullCheck=false;
    console.log(nullCheck);
        if ($(".note-editable").children().children().prop("tagName") == "BR") {
            swal('상세내용을 입력해 주세요.', '상세내용 입력 요망', 'error');
            nullCheck = true;
            return false;
        }
    

    if (nullCheck != true) {
    fetch('/machineReview/update', {
        method:'POST',
        headers:{
            "Content-type":"application/x-www-form-urlencoded"
        },
        body: "machineNum="+$(this).attr("data-comment-num")+"&num="+$("#num").val()+"&contents="+$(".note-editable").html()+"&score="+$('input[name=reviewStar]:checked').val()
    }).then( (response) => response.text())
      .then( (res) => {
        if(res.trim()>0){
            swal('글쓰기 성공', '성공', 'success');
            $("#closeModal").click();
            location.href='/machineReview/detail?machineNum='+$(this).attr("data-comment-num")+"&num="+$("#num").val();        
        }else { 
            swal('글쓰기 실패', '실패', 'error');
        }
      })
       .catch(()=>{
        swal('관리자에게 문의하세요.', '관리자 문의 요망', 'info');
       })
    }

})