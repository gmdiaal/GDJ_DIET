//essential Check 사용방법

//  1. 필수input(text,file)태그엔 모두 class="essential" 있어야 작동합니다.
//   하나라도 있어야하는 checkbox, radio 에는 class="check1"(2개면 첫번째 check무리들은 check1 그다음 무리들은 check2 등등| check3까지가능) 를 넣습니다.

//  2. 전송버튼(add, update)는 모두 id="submitbtn"이 있어야합니다. 버튼타입 무조건 button으로

//  3. 전송할 데이터들이 모여있는 <form>태그엔 모두 id="frm" 이 있어야합니다.

//  4. checkbox가 있는곳은 제일 상위div태그에 <class ="essbox">가 있어야 하며 이 essbox가 두개있으면 안됨.

//!!!   ajax, modal, Addbtn등등 div안에 생성되는 코드들 모두 필수input태그라면 새로 생성될때에도 class="essential" 있어야함.
//      -> 생성되는 코드에 class="essential" 확인



//input text,file태그 전용
$('.essbox').on('click', '#submitbtn', function () {
    let nullCheck = false;


    $(".essential").each(function (index, essential) {
        $(essential).removeClass("form-control-red")
        $(essential).attr("placeholder", '필수로 입력해야 합니다.')

        if ($(essential).val().length == 0) {
            $(essential).addClass("form-control-red")
            if ($(essential).prop('type') == "text") {
                swal('공란이있습니다', '입력란을 다시 확인해주세요', 'error');
                nullCheck = true;
            }
            else if ($(essential).prop('type') == "file") {
                swal('파일업로드 오류', '추가한 파일을 다시 확인해주세요', 'error');
                nullCheck = true;
            }
            else {
                swal('등록오류', '다시 확인해주세요', 'error');
                nullCheck = true;
            }

            if (nullCheck == true) {
                return false;
            }
        }
    })
    if ($(".essbox").find(".check1").length > 0) {

        let radioCount1 = 0
        let checkBoxCount1 = 0
        $(".check1").each(function (index, check) {
            if ($(check).prop("checked") == true) {
                if ($(check).prop("type") == "radio") {
                    radioCount1 = 1;
                }
                else if ($(check).prop("type") == "checkbox") {
                    checkBoxCount1 = 1;
                }
            }
        })
        if (checkBoxCount1 == 0 && radioCount1 == 0) {
            nullCheck = true;
            swal('선택오류', '하나 이상 선택해야 합니다.', 'error');
            return false;
        }

    }
    if ($(".essbox").find(".check2").length > 0) {

        let radioCount2 = 0
        let checkBoxCount2 = 0
        $(".check2").each(function (index, check) {
            if ($(check).prop("checked") == true) {
                if ($(check).prop("type") == "radio") {
                    radioCount2 = 1;
                }
                else if ($(check).prop("type") == "checkbox") {
                    checkBoxCount2 = 1;
                }
            }
        })
        if (checkBoxCount2 == 0 && radioCount2 == 0) {
            nullCheck = true;
            swal('선택오류', '하나 이상 선택해야 합니다.', 'error');
            return false;
        }

    }
    if ($(".essbox").find(".check3").length > 0) {
        let radioCount3 = 0
        let checkBoxCount3 = 0
        $(".check3").each(function (index, check) {
            if ($(check).prop("checked") == true) {
                if ($(check).prop("type") == "radio") {
                    radioCount3 = 1;
                }
                else if ($(check).prop("type") == "checkbox") {
                    checkBoxCount3 = 1;
                }
            }
        })
        if (checkBoxCount3 == 0 && radioCount3 == 0) {
            nullCheck = true;
            swal('선택오류', '하나 이상 선택해야 합니다.', 'error')
            return false;
        }

    }

    //summernote전용(textArea)
    if (nullCheck != true) {
        if ($(".note-editable").children().children().prop("tagName") == "BR") {
            swal('상세내용 공백', '상세내용을 입력해 주세요.', 'error');
            nullCheck=true
            return false;
        }
    }
//스터디 날짜부분

    // if (nullCheck != true) {
    //     if(document.getElementById("studyStartPeriod")){
    //         const startDate = new Date(studyStartPeriod.value);
    //         const endDate = new Date(studyEndPeriod.value);
    
    //         if (startDate > endDate) {
    //             swal('날짜선택 오류', '올바른 날짜를 선택해주세요.', 'error');
    //             nullCheck = true;
    //             return false;
    //         }
    //     }
        
    // }

    if (nullCheck != true) {
        $("#frm").submit();

    }

})

