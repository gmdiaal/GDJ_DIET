//FileManger.js


const fileAdd = document.getElementById("fileAdd");
const fileList = document.getElementById("fileList");


// let count=0;
// let max=0;
// let idx=0;
let optioncount=1;
// let notification = "상세정보파일";
let toggleStatus = "off";
let toggleFlag=false;
let categorycount=2;




//--caregoryAddbtn---------------------
let categoryAdd = ""
let categoryMax=0;
let categoryData=""
let categoryList = $("#categoryList")
$.ajax({
    type:"GET",
    url:"./categoryAdd",
    success:function(response){
        
        if(response.trim().length>0){
            console.log(response.trim())
            categoryData=response.trim();
            categoryMax=categoryList.find("#categorySelect option").length;
            console.log("categorySelect"+categorycount+" MAX : "+categoryMax)
            
           
        }
    },
    error:function(){
        console.log("error")
    }
})
$("#categorybtn").on("click", "#categoryAdd", function (e) {
    categoryAdd = '<div class=""> <select class="form-select" id="categorySelect' + categorycount + '" name="categoryDTOs"></select></div>';
    categoryList.append(categoryAdd);
    categoryList.find("#categorySelect" + categorycount).append(categoryData)
    categorycount++

    if (categoryMax < categorycount) {
        $("#categoryAdd").remove();
    }
    if ($("#categorybtn").find("#categoryDelete").length == 0) {
        $("#categorybtn").append('<button type="button" class="btn btn-danger" id="categoryDelete">카테고리삭제</button>');
    }


})

$("#categorybtn").on("click","#categoryDelete",function(e){
    categorycount--
    console.log($("#categorybtn").find("#categoryAdd").length)
    if($("#categorybtn").find("#categoryAdd").length==0){
        $("#categorybtn").prepend('<button type="button" class="btn btn-primary" id="categoryAdd">카테고리추가</button>');
    }
    let categorySelect=$("#categoryList").find("#categorySelect"+categorycount)
    categorySelect.parent().remove();
    if(categorycount==2){
        $("#categoryDelete").remove();
    }
})


// ---option--------------------------------------
$("#optionAdd").click(function(e){
    if(optioncount>=4){
        alert('옵션은 4개까지만 가능');
        return;
    }
    optioncount++;
    let child ='<div class="mb-3" id="option'+optioncount+'"'
    child=child + '<label for="option'+optioncount+'" class="form-label">'
    child = child+'<input type = "text" class="form-control" name="option'+optioncount+'">'
    child = child+"</div>";
    $("#optionList").append(child);
    
})
$("#optionDelete").click(function(e){
    if(optioncount<=1){
        alert('옵션1개는 필수 입니다.');
        return;
    }
    $("#option"+optioncount).remove();
    optioncount--;
})

// ---optionAddPage--------------------------------------
$(".container-fluid").click(function () {
    
    if (toggleFlag==true&&toggleStatus != "") {
        
        toggleFlag=false
        return;
    }
    else if(toggleFlag==false){
    $(this).find('.dropdown').removeClass('show')
        $(this).find('.dropdown-menu').removeClass('show');
        toggleStatus=""
    }
})
$(".dropdown").on("focus",".optInput",function(){
    let parent = $(this).parents("#optionSelect")
    parent.find('.dropdown').removeClass('show')
    parent.find('.dropdown-menu').removeClass('show');

    let $this = $(this).parents(".dropdown");
    $this.addClass('show');
    $this.find('.dropdown-menu').addClass('show');

    toggleStatus = $(this).attr("id");
    toggleFlag=true;
})

$(".dropdown").on("click", ".dropdown-item", function () {
    let $this = $(this).parents(".boxx");
    $this.find(".optInput").val($(this).attr("data-name"))
    $this.find(".optInputId").val($(this).attr("data-id"))
    let parent = $(this).parents("#optionSelect")
    parent.find('.dropdown').removeClass('show')
    parent.find('.dropdown-menu').removeClass('show');
    toggleFlag=false
    toggleStatus = "";
})
