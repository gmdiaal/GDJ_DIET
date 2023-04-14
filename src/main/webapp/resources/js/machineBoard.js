const STATUS=$("#machineListResult").html();
//machineQna목록
$('#machineQnaList').click(function getList(){
    fetch("/machineQna/list?machineNum="+machineQnaList.getAttribute('data-qna-machineNum'),{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#machineListResult').html(res.trim());
    })
})

//page를 요청할 수 있도록 만든 이벤트
$('#machineListResult').on("click",".page-qna",function(e){
    let page = $(this).attr('data-board-page');
    let kind =''
    $(".searchOption").each(function(idx, item){
        if($(item).prop("selected")){
            kind = $(item).val();
        }
    })

    let search = $("#search").val();

    fetch("/machineQna/list?machineNum="+machineQnaList.getAttribute('data-qna-machineNum')+"&page="+page+"&kind="+kind+"&search="+search,{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#machineListResult').html(res.trim());
    })

    e.preventDefault();
})


//검색할 수 있도록 만든 이벤트
$('#machineListResult').on("click","#searchbutton",function(e){
    let kind = ''
    $(".searchOption").each(function(idx, item){
        if($(item).prop("selected")){
            kind = $(item).val();
        }
    })

    let search = $("#search").val();

    fetch("/machineQna/list?machineNum="+machineQnaList.getAttribute('data-qna-machineNum')+"&kind="+kind+"&search="+search,{
        method:'GET',
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#machineListResult').html(res.trim());
    })
})

$('#machineQnaInfo').click(function(){
    $('#machineListResult').html(STATUS);
})

//studyReivew목록
$('#machineReviewList').click(function getList(){
    fetch("/machineReview/list?machineNum="+machineReviewList.getAttribute('data-review-machineNum'),{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#machineListResult').html(res.trim());
    })
})

//page를 요청할 수 있도록 만든 이벤트
$('#machineListResult').on("click",".page-review",function(e){
    let page = $(this).attr('data-board-page');
    let kind =''
    $(".searchOption").each(function(idx, item){
        if($(item).prop("selected")){
            kind = $(item).val();
        }
    })

    let search = $("#search").val();

    fetch("/machineReview/list?machineNum="+machineReviewList.getAttribute('data-review-machineNum')+"&page="+page+"&kind="+kind+"&search="+search,{
        method:'GET'
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#machineListResult').html(res.trim());
    })

    e.preventDefault();
})


//검색할 수 있도록 만든 이벤트
$('#machineListResult').on("click","#searchbtn",function(e){
    let kind = ''
    $(".searchOption").each(function(idx, item){
        if($(item).prop("selected")){
            kind = $(item).val();
        }
    })

    let search = $("#search").val();

    fetch("/machineReview/list?machineNum="+machineReviewList.getAttribute('data-review-machineNum')+"&kind="+kind+"&search="+search,{
        method:'GET',
    })
    .then((response)=>response.text())
    .then((res)=>{
        $('#machineListResult').html(res.trim());
    })
})

// add버튼 클릭 후 데이터를 넣고 담아 모달창 불러오기
$("#machineListResult").on('click',".add",function(e){
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
    fetch('/machineReview/add', {
        method:'POST',
        headers:{
            "Content-type":"application/x-www-form-urlencoded"
        },
        body: "machineNum="+$(this).attr("data-comment-num")+"&contents="+$(".note-editable").html()+"&score="+$('input[name=reviewStar]:checked').val()
    }).then( (response) => response.text())
      .then( (res) => {
        if(res.trim()>0){
            swal('글쓰기 성공', '성공', 'success');
            $("#closeModal").click();
            location.href='/healthMachine/detail?machineNum='+machineReviewList.getAttribute('data-review-machineNum');        
        }else {
            swal('글쓰기 실패', '실패', 'error');
        }
      })
       .catch(()=>{
        swal('관리자에게 문의하세요.', '관리자 문의 요망', 'info');
       })
    }
})