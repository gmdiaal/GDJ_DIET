


function modalMemberDelete(){
    kakaoDelete()
    $.ajax({
        type:"POST",
        url:"/member/delete",
        data:{
            
        },
        success:function(res){
            console.log(res.trim())
            if(res.trim()>0){
                
                console.log("res: "+res)
                $('#modalClose').click()
                alert("탈퇴완료")
                location.href="/"
            }
        },
        error:function(){alert('오류')}
    })

}


















