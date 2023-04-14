let url=$("#data").attr("data-url");
let resultNum=$("#data").attr("data-resultNum");
let result=$("#data").attr("data-result");


	if(result != ''){
		if(resultNum*1>0){
			swal(result," ",'success');		
		}
		else{
			swal(result," ",'error');		
		}
	}
	document.addEventListener("click",function(){

		 location.href=url;
	})