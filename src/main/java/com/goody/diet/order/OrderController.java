package com.goody.diet.order;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;

import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.map.util.JSONPObject;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.goody.diet.member.DeliveryDTO;
import com.goody.diet.member.MemberDTO;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	@Autowired
	OrderService orderService;

	@GetMapping("listCalen")
	public ModelAndView getOrderList (ModelAndView mv, OrderCalendar orderCalendar, HttpSession session) throws Exception {
		System.out.println("-------------------test------------------");
		System.out.println(orderCalendar.getStartDate()+"~"+orderCalendar.getEndDate());
		
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
		orderCalendar.setId(memberDTO.getId());
		
		if(memberDTO!=null) { //로그인안하면 어케댐?
			List<OrderDTO> orderDTOs=orderService.getOrderList(orderCalendar);	
			mv.addObject("orderDTOs", orderDTOs);

//			System.out.println("------------------오더리스트-----------------");
//			System.out.println(orderDTOs.get(0).getCartDTOs().get(0).getStudyNum());
//			System.out.println(orderDTOs.get(0).getCartDTOs().get(0).getRealMachineNum());
//			System.out.println(orderDTOs.get(0).getCartDTOs().get(0).getStudyDTOs().get(0)
//					.getStudyBoardFileDTOs().get(0).getStudyNum());
//			System.out.println(orderDTOs.get(0).getCartDTOs().get(0).getStudyDTOs().get(0)
//					.getStudyBoardFileDTOs().get(0).getFileName());

		}
		
		mv.setViewName("/order/detailAjax2_back"); //detailAjax detailAjax2_back
		return mv;
	}
	@GetMapping("list")
	public ModelAndView getOrderList(ModelAndView mv) throws Exception {
		mv.setViewName("/order/orderListPage2_back"); //  orderListPage2_back orderListPage
		return mv;
	}

	
	@PostMapping("success")
	public ModelAndView getOrderSuccess(ModelAndView mv,String result, HttpSession session, OrderDTO orderDTO)throws Exception{
		MemberDTO memberDTO =(MemberDTO) session.getAttribute("sessionMember");
		orderDTO.setId(memberDTO.getId());

		int verification=orderService.getOrderVerification(result, session, orderDTO);
		mv.addObject("result",verification);
		mv.setViewName("/common/ajaxResult");
		return mv;
	}
	@GetMapping("orderFaild")
	public ModelAndView orderFaild(ModelAndView mv)throws Exception{
		mv.setViewName("/order/orderFaildPage");
		return mv;
	}
	@PostMapping("paymentUpdate")
	public ModelAndView setUpdateCart(ModelAndView mv,OrderDTO orderDTO, Long [] num,Long[] studyNum, Long[] realMachineNum, HttpSession session) throws Exception{
		MemberDTO memberDTO =(MemberDTO) session.getAttribute("sessionMember");
		
		orderDTO.setId(memberDTO.getId());
		int result = orderService.setUpdateCart(memberDTO, orderDTO, num,studyNum,realMachineNum,session);
		if(result>0) {
			mv.setViewName("/order/orderSuccessPage");
		}
		else {
			mv.setViewName("/order/orderFaildPage");
		}
		
		return mv; 
	}

	///////////////////////payment 배송지///////////////////////
	@GetMapping("newPaymentOrder")
	public ModelAndView getPaymentOrder(HttpSession session, DeliveryDTO deliveryDTO, ModelAndView mv) throws Exception {
		System.out.println("-------------------getPaymentOrder-------------------");
		System.out.println(deliveryDTO.getAddressNum());
		
		//받아오는 deliveryDTO가 없으면 대표주소로
		if(deliveryDTO.getAddressNum()==null) {
			MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
			deliveryDTO=orderService.getPrimeDelivery(memberDTO);			
		}
		
		mv.addObject("deliveryDTO", deliveryDTO);
		mv.setViewName("/order/paymentPageAddressAjax");
		return mv;
	}

}
