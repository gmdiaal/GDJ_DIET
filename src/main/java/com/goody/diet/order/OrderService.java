package com.goody.diet.order;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goody.diet.cart.CartDAO;
import com.goody.diet.cart.CartDTO;
import com.goody.diet.healthMachine.HealthMachineDTO;
import com.goody.diet.healthMachine.RealHealthMachineDTO;
import com.goody.diet.member.DeliveryDTO;
import com.goody.diet.member.MemberDAO;
import com.goody.diet.member.MemberDTO;
import com.goody.diet.study.StudyDTO;
import com.goody.diet.util.Pager;

@Service
public class OrderService {

	@Autowired OrderDAO orderDAO;
	@Autowired CartDAO cartDAO;

	public DeliveryDTO getPrimeDelivery (MemberDTO memberDTO) throws Exception {
		return orderDAO.getPrimeDelivery(memberDTO);
	}
	public int getOrderVerification(String result, HttpSession session, OrderDTO orderDTO)throws Exception{
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonParser.parse(result);

		//검증하기
		int verification=0;
		Long amount = (Long)jsonObject.get("paid_amount");
		System.out.println(amount);
		Long totalPrice=orderDAO.getOrderVerification(orderDTO);
		System.out.println(totalPrice);
		if(totalPrice.equals(amount)) {
			verification=1;
			System.out.println(verification);
		};
		return verification;
	}
	public List<OrderDTO> getOrderList(OrderCalendar orderCalendar) throws Exception {
		return orderDAO.getOrderList(orderCalendar);	
	}
	public int setUpdateCart(MemberDTO memberDTO, OrderDTO orderDTO,Long [] num,Long[] studyNum, Long[] realMachineNum, HttpSession session)throws Exception{
		//1. order생성
		int result= orderDAO.setOrder(orderDTO); 
		System.out.println("----------------setUpdateCart-----------------");
		System.out.println("result: "+result);

		//2. CartUpdate
		CartDTO cartDTO = new CartDTO();
		cartDTO.setOrderNum(orderDTO.getOrderNum());
		cartDTO.setId(orderDTO.getId());
		
		//stock수정
		int count = 0;
		int studyidx = 0;
		int machineidx=0;
		for(Long cartNum:num) {
			cartDTO.setNum(cartNum);

			//cart status 2로 설정
			cartDAO.setCartStatusUpdate(cartDTO);
			//detail생성
			orderDAO.setOrderDetail(cartDTO);
			//

			
			if(studyNum!=null&&count<studyNum.length) {
				cartDTO.setStudyNum(studyNum[studyidx]);
				if(cartDTO.getStudyNum()!=null) {
					cartDAO.setMemberStudyNum(cartDTO);
					cartDAO.setStudyStock(cartDTO);
					studyidx++;//
					count++;
					//세션업데이트
					memberDTO.setStudyNum(cartDTO.getStudyNum());
					session.setAttribute("sessionMember", memberDTO);
				}
				continue;
			}

			cartDTO.setRealMachineNum(realMachineNum[machineidx]);
			if(cartDTO.getRealMachineNum()!=null) {
				cartDAO.setMachineStock(cartDTO);
				count++;
				machineidx++;
			}




		}





		return result;
	}


}
