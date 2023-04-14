const checkAll = document.getElementById("checkAll")
const checks = document.getElementsByClassName("checks")


let deliveryPrice = $("#deliveryPrice").attr("data-deliveryPrice") * 1;
let TotalPrice = 0;
let Checked = true;

// checkAll.addEventListener("click",function(){
//     for(let i=0;i<checks.length;i++){
//         checks[i].checked=checkAll.checked;

//     }
// });
$(".checkAll").click(function (e) {
	
	let thisTable = $(this).attr("data-this-check")
	if (thisTable == "machineCheckAll") {
		Checked = $("#machineCheckAll").prop("checked");
		let thisChecks = $("#cartMachineList").find(".checks")

		if (Checked == true) {
			thisChecks.each(function (i, v) {
				if ($(v).prop("checked") == false) {
					$(v).prop("checked", true);
					let cartPrice = $(v).parent().parent().find("#cartPrice").html() * 1;
					Checked = $(v).prop("checked");
					TotalPrice = TotalPrice + cartPrice;
					$("#totalPrice").html(TotalPrice);
					$("#totalCost").html(TotalPrice + deliveryPrice);
				}
			})
		}
		else {
			thisChecks.each(function (i, v) {
				if ($(v).prop("checked") == true) {
					$(v).prop("checked", false);
					let cartPrice = $(v).parent().parent().find("#cartPrice").html() * 1;
					Checked = $(v).prop("checked");
					TotalPrice = TotalPrice - cartPrice;
					$("#totalPrice").html(TotalPrice);
					$("#totalCost").html(TotalPrice + deliveryPrice);
				}
			})
		}
	}
	else if (thisTable == "studyCheckAll") {
		Checked = $("#studyCheckAll").prop("checked");
		let thisChecks = $("#cartStudyList").find(".checks")

		if (Checked == true) {
			thisChecks.each(function (i, v) {
				if ($(v).prop("checked") == false) {
					$(v).prop("checked", true);
					let cartPrice = $(v).parent().parent().find("#cartPrice").html() * 1;
					Checked = $(v).prop("checked");
					TotalPrice = TotalPrice + cartPrice;
					$("#totalPrice").html(TotalPrice);
					$("#totalCost").html(TotalPrice + deliveryPrice);
				}
			})
		}
		else {
			thisChecks.each(function (i, v) {
				if ($(v).prop("checked") == true) {
					$(v).prop("checked", false);
					let cartPrice = $(v).parent().parent().find("#cartPrice").html() * 1;
					Checked = $(v).prop("checked");
					
						TotalPrice = TotalPrice - cartPrice;

					$("#totalPrice").html(TotalPrice);
					$("#totalCost").html(TotalPrice+ deliveryPrice);
				}
			})
		}
	}
})

$("#submitbtn").click(function () {
	let i=0;
	$(".checks").each(function(index,checkitem){
		if($(checkitem).prop("checked")==true){
			i++;
		}
	})
	if(i==0){
		swal('하나이상 선택해야합니다.',' ', 'error')
		return;
	}
	//countUpdate
	$(".machineval").each(function(index,countnum){
		$(countnum).parent().find(".machineCount").val($(countnum).html()*1)
		
	})
	//totalCost보내기 payment에서 계산 귀찮
	$("#p").val($("#totalCost").text()*1);
	

	$("#frm").submit();
	$("#frm").find(".checkAll").prop("checked",false)
	$("#frm").find(".checks").prop("checked",false)

	
})


// function checkOrder() {
// 	  let checkboxes = document.querySelectorAll('input[type=checkbox]:checked');
// 	  if (checkboxes.length === 0) {
// 	    alert("주문할 스터디를 선택해주세요.");
// 	    return false;
// 	  } else {
// 	    let checkedItems = [];
// 	    let uncheckedItems = [];

// 	    $('input[name="checkedItems"]:checked').each(function() {
// 	      checkedItems.push($(this).val());
// 	    });
// 	    $('input[name="checkedItems"]:not(:checked)').each(function() {
// 	      uncheckedItems.push($(this).val());
// 	    });

// 	    if (uncheckedItems.length > 0) {
// 	      $.ajax({
// 	        type: 'POST',
// 	        url: './uncartCheckedUpdate',
// 	        traditional:true,
// 	        data: { uncheckedItems: uncheckedItems },
// 	      });
// 	    } 
// 	    if (checkedItems.length > 0) {
// 	      $.ajax({
// 	        type: 'POST',
// 	        url: './cartCheckedUpdate',
// 	        traditional:true,
// 	        data: { checkedItems: checkedItems },
// 	      });
// 	    }
// 	   	location.href='/cart/payment'
// 	    return true;
// 	  }
// 	} 

function checkDelete() {
	let check = window.confirm("정말 삭제 하시겠습니까?");
	if (check) {
		let checkedItems = [];
		$('input[name="checkedItems"]:checked').each(function () {
			checkedItems.push($(this).val());
		});

		$.ajax({
			type: 'POST',
			url: './cartDelete',
			traditional: true,
			data: { checkedItems: checkedItems },
			success: function () {
				location.reload();
				// 처리 결과에 따라 적절한 동작 수행
			},
			error: function (xhr, status, error) {
				console.log(xhr.responseText);
				console.log(checkedItems);
				// 에러 처리
			}
		});
	}
}

// 태현-------------------------------

$("#totalCost").html(TotalPrice + deliveryPrice);

$("#cartMachineList").on("click", ".checks", function () {
	let cartPrice = $(this).parent().parent().find("#cartPrice").html() * 1;
	Checked = $(this).prop("checked");
	if (Checked == true) {//누른 후 체크라면(원래는 노체크)
		TotalPrice = TotalPrice + cartPrice;

	}
	else {
		TotalPrice = TotalPrice - cartPrice;
	}
	$("#totalPrice").html(TotalPrice);
	$("#totalCost").html(TotalPrice + deliveryPrice);
})
$("#cartStudyList").on("click", ".checks", function () {
	let cartPrice = $(this).parent().parent().find("#cartPrice").html() * 1;
	Checked = $(this).prop("checked");
	if (Checked == true) {//누른 후 체크라면(원래는 노체크)
		TotalPrice = TotalPrice + cartPrice;
	}
	else {
		TotalPrice = TotalPrice - cartPrice;
	}
	$("#totalPrice").html(TotalPrice);
	$("#totalCost").html(TotalPrice + deliveryPrice);
})
$(".countBtn").on("click", ".plusbtn", function () {
	let body = $(this).parent().parent().parent()

	//1. count구하기
	let count = body.find("#count").html() * 1;
	count = count + 1
	body.find("#count").html(count)

	//2. price올리기
	let cartPrice = body.find("#cartPrice").html() * 1;
	cartPrice = cartPrice / (count - 1) * count;
	body.find("#cartPrice").html(cartPrice);
	//3. 총합계 update
	Checked = $(this).parent().parent().parent().find(".checks").prop("checked");
	if (Checked == true) {
		TotalPrice = TotalPrice + cartPrice / count;
		$("#totalPrice").html(TotalPrice);
		$("#totalCost").html(TotalPrice + deliveryPrice);
	}

})
$(".countBtn").on("click", ".minusbtn", function () {
	let body = $(this).parent().parent().parent()
	//1. count구하기
	let count = body.find("#count").html() * 1;
	if (count * 1 <= 1) {
		alert("상품은 최소 1개 이상 있어야 합니다.")
		return;
	}

	count = count - 1
	body.find("#count").html(count)
	//2. price내리기
	let cartPrice = body.find("#cartPrice").html() * 1;
	cartPrice = cartPrice / (count + 1) * count
	body.find("#cartPrice").html(cartPrice);
	Checked = $(this).parent().parent().parent().find(".checks").prop("checked");
	if (Checked == true) {
		TotalPrice = TotalPrice - cartPrice / count;
		$("#totalPrice").html(TotalPrice);
		$("#totalCost").html(TotalPrice + deliveryPrice);
	}

})

// -------------------------------
