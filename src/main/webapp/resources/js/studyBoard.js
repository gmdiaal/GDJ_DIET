
//studyQna목록
$('#studyQnaList').click(function getList(){
    fetch("/studyQna/list?studyNum="+studyQnaList.getAttribute('data-study-studyNum'),{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#studyListResult').html(res.trim());
    })
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

    fetch("/studyQna/list?studyNum="+studyQnaList.getAttribute('data-study-studyNum')+"&page="+page+"&kind="+kind+"&search="+search,{
        method:'GET'
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

    fetch("/studyQna/list?studyNum="+studyQnaList.getAttribute('data-study-studyNum')+"&kind="+kind+"&search="+search,{
        method:'GET',
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#studyListResult').html(res.trim());
    })
})

$('#studyQnaInfo').click(function(){
    $('#studyListResult').html("<img class='img-fluid rounded mb-4 mb-lg-0' src='/resources/images/studyDetailinfomation.jpg'/>");
    $('#studyListResult').append("<img class='img-fluid rounded mb-4 mb-lg-0' src='/resources/images/studyDetailinfomation2.jpg'/>");

})


//studyReivew목록
$('#studyReviewList').click(function getList(){
    fetch("/studyReview/list?studyNum="+studyReviewList.getAttribute('data-review-studyNum'),{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#studyListResult').html(res.trim());
    })
})

//page를 요청할 수 있도록 만든 이벤트
$('#studyListResult').on("click",".page-review",function(e){
    let page = $(this).attr('data-board-page');
    let kind =''
    $(".searchOption").each(function(idx, item){
        if($(item).prop("selected")){
            kind = $(item).val();
        }
    })

    let search = $("#search").val();

    fetch("/studyReview/list?studyNum="+studyReviewList.getAttribute('data-review-studyNum')+"&page="+page+"&kind="+kind+"&search="+search,{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#studyListResult').html(res.trim());
    })

    e.preventDefault();
})


//검색할 수 있도록 만든 이벤트
$('#studyListResult').on("click","#searchbtn",function(e){
    let kind = ''
    $(".searchOption").each(function(idx, item){
        if($(item).prop("selected")){
            kind = $(item).val();
        }
    })

    let search = $("#search").val();

    fetch("/studyReview/list?studyNum="+studyReviewList.getAttribute('data-review-studyNum')+"&kind="+kind+"&search="+search,{
        method:'GET',
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#studyListResult').html(res.trim());
    })
})

$('#studyQnaInfo').click(function(){
    $('#studyListResult').html("<img class='img-fluid rounded mb-4 mb-lg-0' src='/resources/images/studyDetailinfomation.jpg'/>");
    $('#studyListResult').append("<img class='img-fluid rounded mb-4 mb-lg-0' src='/resources/images/studyDetailinfomation2.jpg'/>");

})

// add버튼 클릭 후 데이터를 넣고 담아 모달창 불러오기
$("#studyListResult").on('click',".add",function(e){
    //console.log(updateButton.parentNode.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling);
    let num = $(this).attr("data-comment-num");

    $("#contentsConfirm").attr("data-comment-num",num);
e.preventDefault();
})

// modal에서 확인버튼과 cancel버튼 눌렀을 때 동작
$("#contentsConfirm").click(function(){
    let nullCheck=false;
    console.log(nullCheck);
        if ($(".note-editable").children().children().prop("tagName") == "BR") {
            swal('상세내용을 입력해 주세요.', '상세내용 입력 요망', 'error');
            nullCheck = true;
            return false;
        }
    

    if (nullCheck != true) {


    fetch('/studyReview/add', {
        method:'POST',
        headers:{
            "Content-type":"application/x-www-form-urlencoded"
        },
        body: "studyNum="+$(this).attr("data-comment-num")+"&contents="+$(".note-editable").html()+"&score="+$('input[name=reviewStar]:checked').val()
    }).then( (response) => response.text())
      .then( (res) => {
        if(res.trim()>0){
            swal('글쓰기 성공', '성공', 'success');
            $("#closeModal").click();
            location.href='/study/studyDetail?studyNum='+studyReviewList.getAttribute('data-review-studyNum');           
        }else {
            swal('글쓰기 실패', '실패', 'error');
        }
      })
       .catch(()=>{
        swal('관리자에게 문의하세요.', '관리자 문의 요망', 'info');
       })
    }

})

let stock = $("#submitbtn").attr("data-stock-cart");
if(stock != "" || stock.length>0){
    $("#submitbtn").html('장바구니 담기');
}else {
    $("#submitbtn").html('품절입니다.');
    $("#submitbtn").attr('disabled');
}


