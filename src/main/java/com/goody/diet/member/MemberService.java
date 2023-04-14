package com.goody.diet.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goody.diet.util.Pager;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	

	public List<MemberDTO> getMemberList(Pager pager) throws Exception {
		System.out.println("totalpage: "+memberDAO.getTotalCount(pager));
		pager.makeNum(memberDAO.getTotalCount(pager));//totalcountDAO만드어,,
		pager.makeRow();
		
		return memberDAO.getMemberList(pager);
	}
	
	public MemberDTO getKakaoLogin (MemberDTO memberDTO) throws Exception {
		System.out.println("-------------서비스.카카오로그인--------------");
		//토큰이 초기화되지 않은경우->
		System.out.println(memberDTO.getId());
		MemberDTO result = memberDAO.getMemberLogin(memberDTO); //카카오에서 연결 끊거나, accessToken이 남아있어도 DB에서 초기화
		System.out.println(result); //db에 없으면 머가남음?
		System.out.println("ID: "+memberDTO.getId());
		System.out.println("로그인타입: "+memberDTO.getLoginType());
		//정보가 없으면 회원가입 //?브라우저에 토큰이 살아있어서 id를 받아오면?->ID가 없어서 못받음
		if(result==null) { //가입이 안되있어도 토큰에서 id받아오네? //로컬스토리지에 memberSession때문.
			//카카오에서 서비스를 끊으면, 서비스에선 어떻게알음?-> 카카오계정과연동창이 뜨고 서비스와 연동.-> 1. 세션이 없을경우. db가입진행 2. 세션이 있을 경우 ->검증을 못함.
			//loginType으로 검증하면 회원가입 중복되네..
			memberDTO.setLoginType("kakao"); //회원가입 시 kakao로그인 부여
			memberDAO.setKakaoJoin(memberDTO);
			memberDAO.setMemberRole(memberDTO);
			memberDAO.getMemberLogin(memberDTO);//역할 받아와야함.
		}
		memberDTO=memberDAO.getMemberLogin(memberDTO);
		System.out.println("로그인타입: "+memberDTO.getLoginType()+" 역할: "+memberDTO.getRoleDTO().getRoleName());
		System.out.println("------------카카오로그인-------------");
		return memberDTO;
	}
	
	//카카오끝
	
	public int setMemberDelete(MemberDTO memberDTO) throws Exception {
		System.out.println("member del id 옴?: "+memberDTO.getId());
		int roleresult = memberDAO.setMemberRoleDelete(memberDTO);
		System.out.println("member del 삭제 후: "+memberDTO.getId());
		int result = memberDAO.setMemberDelete(memberDTO);
		System.out.println(roleresult+":"+result);
		int total = roleresult+result;
		return total;
	}

	public String getIdCheck (MemberDTO memberDTO) throws Exception {
		String result = "사용불가";
		if(memberDTO.getId()!=null&&memberDTO.getId()!=""&&memberDAO.getMemberLogin(memberDTO)==null) {
			result = "사용가능";
		}
		if(memberDTO.getId()=="") {
			result = "필수정보";
		}
		if(memberDAO.getMemberLogin(memberDTO)!=null) {
			result = "중복아이디";
		}
		return result;
	}
	
	//0410 이메일 중복허용
//	public String getEmailCheck (MemberDTO memberDTO) throws Exception {
//		String result = "사용불가";
//		if(memberDTO.getEmail()!=null&&memberDTO.getEmail()!=""&&memberDAO.getEmailCheck(memberDTO)==null) {
//			result = "사용가능";
//		}
//		if(memberDTO.getEmail()=="") {
//			result = "필수정보";
//		}
//		if(memberDAO.getEmailCheck(memberDTO)!=null) {
//			result = "중복";
//		}
//		return result;
//	}
	
	public MemberDTO getMemberLogin(MemberDTO memberDTO) throws Exception {
//		System.out.println("서비스왔니..?");
//		System.out.println("서비스 check: "+memberDTO.getPw());
		
		//---------------id검사---------------------
//		memberDTO.getId()
		
		//---------------pw검사---------------------
		if(memberDTO.getPw()!=null||memberDTO.getPw()!="") {	//최소 pw는 입력해야댐.
			MemberDTO result=memberDAO.getMemberLogin(memberDTO);	//id: 일치 or null
			System.out.println("result(id불일치 시 null): "+result);
			if(result!=null && result.getPw().equals(memberDTO.getPw())) { //로그인 정보 일치 시
				System.out.println("서비스아이디일치하나2");
				result.setPw(null);
				memberDTO = result;
			}else { //DB와 pw가 안맞을 때
				memberDTO=null;
			}
		}else { //web에서 pw입력을 안했을 때
			memberDTO=null;
		}//비번 null이면 null받음
		return memberDTO;
	}

	public MemberDTO getMyPage(MemberDTO memberDTO) throws Exception { //pw변경시 검사, 
		memberDTO = memberDAO.getMemberLogin(memberDTO);
		
		//이거 왜 나눠놨지...?
//		if(memberDTO.getLoginType().equals("kakao")) {
//			memberDTO = memberDAO.getMemberLogin(memberDTO);
//
//		}else if(memberDTO.getLoginType().equals("general")) {
//			memberDTO = memberDAO.getMemberLogin(memberDTO);
////			memberDTO.setPw(null); //일반 로그인은 getMemberLogin로 해... pw필요해..
//			
//		}

		return memberDTO;
		
	}
	
	public int setMemberJoin(MemberDTO memberDTO) throws Exception {
		memberDTO.setLoginType("general"); 
		memberDAO.setMemberRole(memberDTO);
		return memberDAO.setMemberJoin(memberDTO);
	}
	
	public int setPasswordUpdate(MemberDTO memberDTO) throws Exception {
		return memberDAO.setPasswordUpdate(memberDTO);
	}
	
	//주소설정
	public DeliveryDTO getDeliveryDetail(DeliveryDTO deliveryDTO) throws Exception {
		return memberDAO.getDeliveryDetail(deliveryDTO);
	}	
	public int setEmailUpdate(MemberDTO memberDTO) throws Exception {
		return memberDAO.setEmailUpdate(memberDTO);
	}
	public MemberDTO setMemberAddressUpdate(MemberDTO memberDTO) throws Exception {
		memberDAO.setMemberAddressUpdate(memberDTO);
		
		//대표주소에 쓰는 세션업데이트 해줘야댐
		memberDTO=memberDAO.getMemberLogin(memberDTO);
		memberDTO.setPw(null);
		return memberDTO;
	}
	public int setDeliveryAdd(DeliveryDTO deliveryDTO) throws Exception {
		return memberDAO.setDeliveryAdd(deliveryDTO);
	}
	public int setDeliveryDelete(DeliveryDTO deliveryDTO) throws Exception {
		return memberDAO.setDeliveryDelete(deliveryDTO);
	}
	public int setdeliveryUpdate(DeliveryDTO deliveryDTO) throws Exception {
		return memberDAO.setdeliveryUpdate(deliveryDTO);
	}


	
	public List<DeliveryDTO> getDeliveryPage (MemberDTO memberDTO) throws Exception {
		return memberDAO.getDeliveryPage(memberDTO);
	}

	public int setDeleteOnMemberDelete (MemberDTO memberDTO) throws Exception {
		memberDAO.setDeliveryDeleteOnMemberDelete(memberDTO);
		memberDAO.setOrderDetailDeleteOnMemberDelete(memberDTO);
		memberDAO.setCartDeleteOnMemberDelete(memberDTO);
		memberDAO.setOrderDeleteOnMemberDelete(memberDTO);
		return 0;
	}
}
