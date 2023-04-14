
let machineNum = $("#machineNum").val();

function init(){
    $.ajax({
        type: "POST",
        url: "./RealMachineList",
        data: {
            machineNum: machineNum
    
        },
        success: function (response) {
    
            if (response.trim().length > 0) {
    
                $("#realMachineList").html(response.trim());
            }
        },
        error: function () {
            console.log("error")
        }
    })
}
init();

//--caregorybtn---------------------
let categoryAdd = ""
let categoryMax = null;
let categoryData = ""
let categoryList = $("#categoryList")
let categorycount = $('.categoryDel').length;
let categorystatus = $('.categoryDel').length
$.ajax({
    type: "GET",
    url: "./categoryAdd",
    success: function (response) {

        if (response.trim().length > 0) {

            categoryData = response.trim();



        }
    },
    error: function () {
        console.log("error")
    }
})
$("#categorybtn").on("click", "#categoryAdd", function (e) {
    categoryAdd = '<div class=""> <select class="form-select" id="categorySelect' + categorycount + '" name="categoryDTOs"></select></div>';
    categoryList.append(categoryAdd);
    categoryList.find("#categorySelect" + categorycount).append(categoryData)
    //이미 카테고리가 최대일때
    if (categoryMax == null) {
        categoryMax = categoryList.find("#categorySelect" + categorycount + " option").length;
    }
    if (categoryMax <= categorycount) {
        alert(categoryMax + "개가 최대입니다.")
        $("#categorySelect" + categorycount).remove();
        return;
    }
    //

    categorycount++

    if (categoryMax <= categorycount) {
        $("#categoryAdd").remove();
    }
    if ($("#categorybtn").find("#categoryDelete").length == 0) {
        $("#categorybtn").append('<button type="button" class="btn btn-danger" id="categoryDelete">카테고리삭제</button>');
    }


})

$("#categorybtn").on("click", "#categoryDelete", function (e) {
    categorycount--
    // console.log($("#categorybtn").find("#categoryAdd").length)
    if ($("#categorybtn").find("#categoryAdd").length == 0) {
        $("#categorybtn").prepend('<button type="button" class="btn btn-primary" id="categoryAdd">카테고리추가</button>');
    }
    let categorySelect = $("#categoryList").find("#categorySelect" + categorycount)
    categorySelect.parent().remove();
    if (categorycount == categorystatus) {
        $("#categoryDelete").remove();
    }
})
$(".categoryDel").click(function () {
    let CategoryDelBtn = $(this)
    let categoryNum = CategoryDelBtn.attr("data-category-num");
    let result = confirm('카테고리를 삭제 하시겠습니까?');
    if (result) {
        $.ajax({
            type: 'POST',
            url: './categoryTypeDelete',
            data: {
                machineNum: machineNum,
                categoryNum: categoryNum
            },
            success: function (response) {
                if (response.trim() > 0) {
                    alert("삭제되었습니다.");
                    CategoryDelBtn.parent().remove();
                    categorycount--
                    categorystatus--
                }
                else {
                    alert("삭제실패")
                }
            }
        })
    }
})
//--------------category End------------------------------

//-------option----------------------------
optioncount = $(".options").length;

$("#optionAdd").click(function (e) {
    if (optioncount >= 4) {
        alert('옵션은 4개까지만 가능');
        return;
    }
    optioncount++;
    let child = '<div class="mb-3" id="option' + optioncount + '"'
    child = child + '<label for="option' + optioncount + '" class="form-label">'
    child = child + '<input type = "text" class="form-control essential"  name="option' + optioncount + '">'
    child = child + "</div>";
    $("#optionList").append(child);

})
$("#optionDelete").click(function (e) {
    if (optioncount <= 1) {
        alert('옵션1개는 필수 입니다.');
        return;
    }
    $("#option" + optioncount).remove();
    optioncount--;
})
//----------optionEnd-------------
//--file-----
let count = 0;
let max = 20;
let index = 0;
let notification = "상세정보파일";
let thumnailcount=$("#thumnailFile").find(".deleteCheck").length;
let thumnailChecked=false
let result=null;
function setParam(p){
    param=p;
}

$(".deleteCheck").on("click",function(){
    if(!thumnailChecked){
        result  = confirm("썸네일이 영구 삭제 됩니다.")
    }
    if(result){
        thumnailChecked = $("#thumnailCheck").prop("checked");
        if(thumnailChecked==true){
            thumnailcount=0; 
        }
        else{
            $("#thumnaildel").parent().remove();
            thumnailcount=1; 
        }
    }
})

$("#fileAdd").click(() => {
    // alert("add");

    if (count >= max) {

        alert(notification + '은 최대 ' + max + ' 까지만 가능');
        return;
    }

    count++;

    let child = '<div class="input-group mb-3" id="f' + index + '">';
    child = child + '<input type="file" class="form-control" name="' + param + '">'
    child = child + '<button type="button" class="btn btn-outline-danger dels" data-dels-id="f' + index + '">X</button></div>'
    child = child + '</div>';
    $("#fileList").append(child);
    index++;
});
$("#thumnailbtn").click(() => {
    
    if (thumnailcount < 1) {
        let child = '<div class="input-group mb-3"">';
        child = child + '<input type="file" class="form-control " name="Files">'
        child = child + '<button type="button" class="btn btn-outline-danger dels" id="thumnaildel">X</button>'
        child = child + '</div>';
        $("#thumnailFile").append(child);
        thumnailcount++;
    }
    else{
        alert("썸네일은 1개만 가능.")
    }
})

$("#fileList").on("click", ".dels", function (e) {

    $(this).parent().remove();
    count--;
    index--;
})
$("#thumnailFile").on("click", ".dels", function (e) {

    $(this).parent().remove();
    thumnailcount--;
})

//fileUpdate End-------------------------------------------------------


 
let idx = 0;
let optId1 = null;
let optId2 = null;
let optId3 = null;
let optId4 = null;
let optId5 = null;
let url = "";
let select = "";
let toggleStatus = "off";
let toggleFlag=false;
let optName

$.ajax({
    type: "POST",
    url: "./option1",
    data: {
        machineNum: machineNum
    },
    success: function (response) {

        $("#optSelect1").append(response.trim())
        
    },
    error: function () {
        console.log("error");
    }
})

$("#optionSelect").on("click", ".op1", function (e) {
    idx = 2;

    optId1 = $(this).attr("data-id");
    console.log(optId1)

    getOption(2);

    $.ajax({

        type: "POST",
        url: "./option2",
        data: {
            machineNum: machineNum,
            optId1: optId1
        },
        success: function (response) {
            
            if (response.trim().length > 20) {
                $("#opt2").append(select);
                $("#optSelect2").append(response.trim())
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }
        },
        error: function () {
            console.log("error");
        }
    })
    $.ajax({

        type: "POST",
        url: "./filterOption",
        data: {
            machineNum: machineNum,
            optId1: optId1
        },
        success: function (response) {
            
            if (response.trim().length > 20) {
                $("#realMachineList").html(response.trim())
                
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }
        },
        error: function () {
            console.log("error");
        }
    })


})
$("#optionSelect").on("click", ".op2", function (e) {

    optId2 = $(this).attr("data-id")
    console.log(optId2)
    // idx=3;
    // optName=$("#opt3").attr("data-optName")
    // select ='<select class="form-select mb-3" id="optSelect3">'
    // select=select+'<option class="option"  id="default">'+optName
    // select=select+'을 선택해주세요</option></select>'
    getOption(3);
    idx = 3;
    $.ajax({

        type: "POST",
        url: "./option3",
        data: {
            machineNum: machineNum,
            optId1: optId1,
            optId2: optId2
        },
        success: function (response) {
            if (response.trim().length > 20) {
                $("#opt" + idx).append(select);
                $("#optSelect3").append(response.trim())
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }
            
        },
        error: function () {
            console.log("error");
        }
    })
    $.ajax({

        type: "POST",
        url: "./filterOption",
        data: {
            machineNum: machineNum,
            optId1: optId1,
            optId2: optId2
        },
        success: function (response) {
            
            if (response.trim().length > 20) {
                $("#realMachineList").html(response.trim())
                
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }
        },
        error: function () {
            console.log("error");
        }
    })


})

$("#optionSelect").on("click", ".op3", function (e) {
    optId3 = $(this).attr("data-id");
    getOption(4);
    
    $.ajax({

        type: "POST",
        url: url,
        data: {
            machineNum: machineNum,
            optId1: optId1,
            optId2: optId2,
            optId3: optId3
        },
        success: function (response) {

            if (response.trim().length > 20) {
                $("#opt" + idx).append(select);
                $("#optSelect4").append(response.trim())
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }   
        },
        error: function () {
            console.log("error");
        }
    })
    $.ajax({

        type: "POST",
        url: "./filterOption",
        data: {
            machineNum: machineNum,
            optId1: optId1,
            optId2: optId2,
            optId3: optId3
        },
        success: function (response) {
            
            if (response.trim().length > 20) {
                $("#realMachineList").html(response.trim())
                
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }
        },
        error: function () {
            console.log("error");
        }
    })

})
$("#optionSelect").on("click", ".op4", function (e) {
    optId4 = $(this).attr("data-id");
    $.ajax({

        type: "POST",
        url: "./filterOption",
        data: {
            machineNum: machineNum,
            optId1: optId1,
            optId2: optId2,
            optId3: optId3,
            optId4: optId4
        },
        success: function (response) {
            
            if (response.trim().length > 20) {
                $("#realMachineList").html(response.trim())
                
            }
            // else{
            //     if($("#btn").find('#optionDelete').length<=0)
            //     $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
            // }
        },
        error: function () {
            console.log("error");
        }
    })
        
    $("#opt" + 5).children().remove()
                
            
    $("#btn").find("#optionDelete").remove()
    $("#btn").prepend('<button id="optionDelete" type="button" class="btn btn-border">해당옵션삭제</button>')
    // $.ajax({

    //     type: "POST",
    //     url: url,
    //     data: {
    //         machineNum: machineNum,
    //         optId1: optId1,
    //         optId2: optId2,
    //         optId3: optId3,
    //         optId4: optId4
    //     },
    //     success: function (response) {

    //         if (response.trim().length > 20) {
    //             $("#opt" + idx).append(select);
    //             $("#optSelect4").append(response.trim())
    //         }
    //         else{
    //             if($("#btn").find('#optionDelete').length<=0){

    //             }
                
    //         }
           
    //     },
    //     error: function () {
    //         console.log("error");
    //     }
    // })

});

// function getOption(optSelectNum) {
//     optName = $("#opt" + optSelectNum).attr("data-optName")
//     url = "./option" + optSelectNum
//     select = '<select class="form-select mb-3" id="optSelect' + optSelectNum + '">'
//     select = select + '<option class="option"  id="default">' + optName
//     select = select + '을 선택해주세요</option></select>'
//     for (i = optSelectNum; i <= 5; i++) {
//         $("#optSelect" + i).remove()
//     }


// }

// $('#optbtn1').on("focus",function(e){
//     let $this = $(this).parents(".dropdown");
//     $this.addClass('show');
//     $this.find('> a').attr('aria-expanded', true);
//     // $this.find('.dropdown-menu').addClass('animated-fast fadeInUp show');
//     $this.find('.dropdown-menu').addClass('show');
// })

function getOption(optSelectNum) {
    optName = $("#opt" + optSelectNum).attr("data-optName")
    url = "./option" + optSelectNum
    idx=optSelectNum
    select = '<button class="btn dropdown-toggle" id=optbtn' + optSelectNum + '>'
    select = select + optName + '을 선택해주세요</button><div class="dropdown-menu"><ul style="list-style: none;" id=optSelect' + optSelectNum + '>'
    select = select + '</ul></div>'
    for (i = optSelectNum; i <= 5; i++) {
        
        $("#opt" + i).children().remove()
        
    }
    $("#btn").find("#optionDelete").remove()
}


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
$(".dropdown").on("click", ".dropdown-toggle", function () {
    let $this = $(this).parents(".dropdown");
    let parent = $(this).parents("#optionSelect")

    parent.find('.dropdown').removeClass('show')
    parent.find('.dropdown-menu').removeClass('show');
    toggleFlag=false

    if (toggleStatus != $(this).attr("id")) {
        $this.addClass('show');
        $this.find('> a').attr('aria-expanded', true);
        $this.find('.dropdown-menu').addClass('show');
        toggleStatus = $(this).attr("id");
        toggleFlag=true;
        return;
    }
    toggleStatus = "";


})

$(".dropdown").on("click", ".dropdown-item", function () {
    let $this = $(this).parents(".dropdown");

    $this.find(".btn").html($(this).attr("data-name")+"을 선택하였습니다.")

    $this.removeClass('show');
    // $this.find('> a').attr('aria-expanded', false);
    $this.find('.dropdown-menu').removeClass('show');
    toggleFlag=false
    toggleStatus = "";
})

$("#realMachineList").on("click",".cursor-pointer",function(){
    let realMachineNum=$(this).attr("data-realMachineNum")
    
    let result = confirm('옵션을 삭제 하시겠습니까?');
    if(result){
        $.ajax({
            type: "POST",
            url: "./optionDelete",
            data:{
                realMachineNum:realMachineNum
            },
            success: function (response) {
                if (response.trim().length > 0) {
                    alert("삭제되었습니다.")
                    init();
                }
            },
            error: function () {
                console.log("error")
            }
        })
    }
})