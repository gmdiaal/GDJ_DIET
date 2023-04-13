<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- oder반복 -->
					<c:forEach items="${orderDTOs}" var="orderDTO">
					
<!-- 상품반복 -->	
        <div class="card card-1 mb-3 d-flex  justify-content-center">

            <div class="card-body">
            
                <div class="row justify-content-between mb-3">
                    <div class="col-auto"> <h6 class="color-1 mb-0 change-color"></h6> </div>
<!--                     <div class="col-auto  "> <small>Receipt Voucher : 1KAU9-84UIL</small> </div> -->
                </div>
							
<!-- 스터디 반복 -->
<c:forEach items="${orderDTO.cartDTOs}" var="cartDTO">

<c:if test="${cartDTO.studyNum ne null}">

                <div class="row mt-4">
                    <div class="col">
                        <div class="card card-2">
                            <div class="card-body">
                                <div class="media">
                                    <div class="sq align-self-center "> <img onclick="javascript:location.href='/study/studyDetail?studyNum=${cartDTO.studyNum}'" class="img-fluid  my-auto align-self-center mr-2 mr-md-4 pl-0 p-0 m-0" 
                                    	src="/resources/upload/study/${cartDTO.studyDTOs[0].studyBoardFileDTOs[0].fileName}" width="135" height="135" /> </div>
                                    <div class="media-body my-auto text-right">
                                        <div class="row  my-auto flex-column flex-md-row">
                                            <div class="col my-auto"> <h6 class="mb-0 text-start"> ${cartDTO.studyDTOs[0].studyName}</h6>  </div>
<!--                                             <div class="col-auto my-auto"> <small></small></div> -->
<!--                                             <div class="col my-auto"> <small></small></div> -->
<!--                                             <div class="col my-auto"> <small></small></div> -->
                                            <div class="col my-auto"><h6 class="mb-0">${cartDTO.studyDTOs[0].studyCost}원</h6>
                                            </div>
                                            <div class="col-2 my-3"></div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-3 ">
                                <div class="row"> <div class="col-3">
<button type="button" class="btn btn-secondary btn-addCart to-cart-popper"
	data-addCart-price="${cartDTO.cartPrice}"
	data-addCart="${cartDTO.studyNum}" data-bs-container="body"
	data-bs-toggle="popover" data-bs-placement="top"
	data-bs-content="Top popover">장바구니담기</button>
                                </div>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>

</c:if>



<!-- 기구 -->
<c:if
	test="${cartDTO.realMachineNum ne null}">


               <div class="row mt-4">
                    <div class="col">
                        <div class="card card-2">
                            <div class="card-body">
                                <div class="media">
                                    <div class="sq align-self-center "> <img 
                                    onclick="javascript:location.href='/study/studyDetail?studyNum=${cartDTO.realMachineNum}'" class="img-fluid  my-auto align-self-center mr-2 mr-md-4 pl-0 p-0 m-0" 
                                    src="/resources/images/${cartDTO.healthMachineDTO.healthMachineImgDTOs[0].fileName}" width="135" height="135" /> </div>
                                    <div class="media-body my-auto text-right">
                                        <div class="row  my-auto flex-column flex-md-row">
                                            <div class="col my-auto"> <h6 class="text-start"> ${cartDTO.healthMachineDTO.machineName}</h6>  </div>
                                            <div class="col-auto my-auto"> <h6>${cartDTO.realHealthMachineDTO.optName1} </h6></div>
                                            <c:if test="${cartDTO.realHealthMachineDTO.optName2 ne null}"><div class="col my-auto"> <h6>size:${cartDTO.realHealthMachineDTO.optName2}</h6></div></c:if>
                                            <c:if test="${cartDTO.realHealthMachineDTO.optName3 ne null}"><div class="col my-auto"> <h6>무게:${cartDTO.realHealthMachineDTO.optName3}</h6></div></c:if>
                                            <div class="col my-auto"> <h6>${cartDTO.count}개</h6></div>
                                            <div class="col my-auto"><h6 class="">${cartDTO.healthMachineDTO.salePrice}원</h6>
                                            </div>
                                            <div class="col-2 my-3"></div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-3 ">
                                <div class="row">
                                <div class="col-3">
<button type="button"
	class="btn btn-secondary btn-addCart-machine to-cart-popper"
	data-bs-container="body" data-bs-toggle="popover"
	data-bs-placement="top" data-bs-content="Top popover"
	data-addCart="${cartDTO.realMachineNum}"
	data-addCart-price="${cartDTO.cartPrice}"
	data-addCart-machineNum="${cartDTO.realHealthMachineDTO.machineNum}"
	data-addCart-op1="${cartDTO.realHealthMachineDTO.optId1}"
	data-addCartop-2="${cartDTO.realHealthMachineDTO.optId2}"
	data-addCartop-3="${cartDTO.realHealthMachineDTO.optId3}"
	data-addCartop-4="${cartDTO.realHealthMachineDTO.optId4}">장바구니담기
</button>
                                </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

</c:if>

</c:forEach>


                <!-- order정보 -->
                <div class="row mt-4">
                    <div class="col">
                        <div class="row justify-content-between">
                            <div class="col-auto"><p class="mb-1 text-dark"><b>Order Details</b></p></div>
                            <div class="flex-sm-col text-right col"> <p class="mb-1"><b>total price</b></p> </div>
                            <div class="flex-sm-col col-auto"> <p class="mb-1">${orderDTO.price}원</p> </div>
                        </div>
                        <div class="row justify-content-between">
                            <div class="flex-sm-col text-right col"><p class="mb-1"> <b>.</b></p> </div>
                            <div class="flex-sm-col col-auto"><p class="mb-1">${orderDTO.address}</p></div>
                        </div>
                        <div class="row justify-content-between">
                            <div class="flex-sm-col text-right col"><p class="mb-1"><b>.</b></p></div>
                            <div class="flex-sm-col col-auto"><p class="mb-1">${orderDTO.recipient}</p></div>
                        </div>
                        <div class="row justify-content-between">
                            <div class="flex-sm-col text-right col"><p class="mb-1"><b>.</b></p></div>
                            <div class="flex-sm-col col-auto"><p class="mb-1">${orderDTO.recipientTel}</p></div>
                        </div>
                    </div>
                </div>
                <div class="row invoice ">
                    <div class="col"><p class="mb-1"> Number : ${orderDTO.orderNum}</p><p class="mb-1"> Date : ${orderDTO.orderDate}</p></div>
                </div>
            </div>

        </div><!-- 상품반복 끝 -->


					</c:forEach><!-- oder반복 -->