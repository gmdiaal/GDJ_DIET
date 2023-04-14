package com.goody.diet.member;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.goody.diet.util.Pager;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@PostMapping("adminDel")
	public ModelAndView adminDelete(ModelAndView mv, MemberDTO memberDTO) throws Exception {
		System.out.println("---------------카카오연결끊기 admin------------------");

		String reqURL = "https://kapi.kakao.com/v1/user/unlink";
		String deletedIdLong = "";
		 try {
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            
	            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);
	            
	            //	헤더
	            conn.setRequestProperty("Authorization", "KakaoAK cffbbf5524ffcc3a7dc95c63c0952914");
	            
	            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("target_id_type=user_id");
	            sb.append("&target_id="+Long.parseLong(memberDTO.getId()));
	            bw.write(sb.toString());
	            bw.flush();
	            
	            //    결과 코드가 200이라면 성공
	            int responseCode = conn.getResponseCode();
	            System.out.println("responseCode : " + responseCode);
	 
	            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            System.out.println(conn.getInputStream());
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	            
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            System.out.println("response body : " + result);
	            
	            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            
	            deletedIdLong = element.getAsJsonObject().get("id").getAsString();
	            
	            System.out.println("연결 끊기에 성공한 사용자의 회원번호 : " + deletedIdLong);
	            
	            br.close();
	            bw.close();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } 
		 
			mv.addObject("result", deletedIdLong);
			mv.setViewName("/member/ajaxResult");
		
		return mv;
	}

	@GetMapping("manage")
	public ModelAndView getMemberList(Pager pager, HttpSession session, ModelAndView mv) throws Exception {
		
		//@@@인터셉터 누가만들면 바까주기 //이상하게 들어왓을 때
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
		String message="권한 부족";
		if(!memberDTO.getRoleDTO().getRoleName().equals("ADMIN")) {
			mv.addObject("url", "/");
			mv.addObject("result", message);
			mv.setViewName("common/result");
		}else {
			mv.setViewName("/member/manage");
		}
		
		return mv;
	}
	@PostMapping("memberList")
	public ModelAndView getMemberList(Pager pager, ModelAndView mv) throws Exception {
		List<MemberDTO> ar = memberService.getMemberList(pager);
		mv.addObject("list", ar);
		mv.addObject("pager", pager);		
		mv.setViewName("/member/memberList");
		return mv;
	}

	
	@PostMapping("kakaoLogin")
	public ModelAndView getKakaoLogin(ModelAndView mv, MemberDTO memberDTO, HttpSession session) throws Exception {
		memberDTO = memberService.getKakaoLogin(memberDTO);
		if(memberDTO!=null) {
			memberService.getMyPage(memberDTO);
			session.setAttribute("sessionMember", memberDTO);	
		}
		mv.setViewName("redirect:/");

		return mv;
	}

	@PostMapping("delete")
	public ModelAndView setMemberDelete(ModelAndView mv, HttpSession session, MemberDTO memberDTO) throws Exception {
		System.out.println("-------------회원탈퇴------------");
		System.out.println(memberDTO);
		System.out.println(memberDTO.getId());
		int delResult=0;
		if(memberDTO.getId()==null||memberDTO.getId().equals("")) {	//회원탈퇴 //memberDTO.getId().equals(null)||memberDTO.getId().equals("")
			memberDTO=(MemberDTO)session.getAttribute("sessionMember");	
			memberService.setDeleteOnMemberDelete(memberDTO); //주문-카트삭제, 카트삭제, 주문삭제, 주소삭제 (FK)
			delResult=memberService.setMemberDelete(memberDTO);
			session.invalidate();
		}else {					//ADMIN이 회원삭제
			memberService.setDeleteOnMemberDelete(memberDTO); //주문-카트삭제, 카트삭제, 주문삭제, 주소삭제 (FK)
			delResult=memberService.setMemberDelete(memberDTO);
					
		}
		


		
		System.out.println("회원탈퇴 del ajax 가니?: " +delResult);
		mv.addObject("result", delResult);
		mv.setViewName("/member/ajaxResult");
		return mv;
	}
	
//	@GetMapping("agree")
//	public ModelAndView setMemberAgree(ModelAndView mv) throws Exception {
//		mv.setViewName("member/agree");
//		return mv;
//	}
	
	@GetMapping("login")
	public ModelAndView setMemberLogin(ModelAndView mv, HttpSession session) throws Exception {
		System.out.println(session.getAttribute("sessionMember"));
		if(session.getAttribute("sessionMember")!=null) {
			String result="이미 로그인함";
			mv.setViewName("/common/result");
			mv.addObject("url", "/");
			mv.addObject("result", result);
		}else {			
			mv.setViewName("/member/login");
		}
		
		return mv;
	}
	@PostMapping("login") //이거 회원관리할떼 비번확인에도 씀..
	public ModelAndView getMemberLogin(ModelAndView mv, MemberDTO memberDTO, HttpSession session) throws Exception {
//		System.out.println("pwcheck ajax옴?: "+memberDTO.getPw());
		System.out.println(memberDTO.getPw());
		memberDTO = memberService.getMemberLogin(memberDTO); //MyPage는 비번도 옴
		System.out.println("----------getMemberLogin---------");
//		System.out.println("타입: "+memberDTO.getLoginType());
		
		if(memberDTO!=null) {
			session.setAttribute("sessionMember", memberDTO);		
			
//			mv.addObject("result", "1");
			mv.setViewName("/member/ajaxResult");
		}else {//로그인실패
			mv.addObject("result", "0"); //trim인데 띄어쓰기댐?
			mv.setViewName("/member/ajaxResult");
		}
		return mv;
	}
	@GetMapping("logout")
	public String getMemberLogout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("myPage")
	public ModelAndView getMyPage(ModelAndView mv, HttpSession session) throws Exception {
		
//		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
		System.out.println("-----------------myPage-------------------");
//		System.out.println("로그인타입: "+memberDTO.getLoginType());
//		System.out.println("q&na부르는: "+memberDTO.getStudyNum());
//		System.out.println(memberDTO.getRoleDTO().getRoleName());
		
//		if(memberDTO!=null) { //무결성 로그인
//			memberDTO = memberService.getMyPage(memberDTO);
//		}
		
//		mv.addObject("mypage",memberDTO );
		mv.setViewName("/member/myPage");
//		mv.setViewName("/order/orderListPage");
		return mv;
	}

	@PostMapping("idCheck")
	public ModelAndView getIdCheck (MemberDTO memberDTO, ModelAndView mv) throws Exception {
//		System.out.println(memberDTO.getId());
		String result = memberService.getIdCheck(memberDTO);
//		System.out.println(result);
		mv.addObject("result", result);
		mv.setViewName("/member/ajaxResult");
		return mv;
	}
	
	@GetMapping("join")
	public String setMemberJoin() throws Exception {
		return "/member/join";
	}
	@PostMapping("join")
	public ModelAndView setMemberJoin(MemberDTO memberDTO, ModelAndView mv) throws Exception {
		int result = memberService.setMemberJoin(memberDTO);
	
		System.out.println("join result값: "+result);
		
		//주소록에도 복제
		if(result==1) {
		DeliveryDTO deliveryDTO = new DeliveryDTO();
		deliveryDTO.setId(memberDTO.getId());
		deliveryDTO.setAddress(memberDTO.getAddress());
		deliveryDTO.setRecipient(memberDTO.getNames());
		deliveryDTO.setRecipientTel(memberDTO.getPhone());
		memberService.setDeliveryAdd(deliveryDTO);
//		System.out.println(memberDTO.getAddress());
		}
		
		mv.setViewName("redirect:../");
		mv.addObject("result", result);
		return mv;
	}
	
	//--이메일체크
	@GetMapping("verificationCode")
	public ModelAndView sendVerificationCode(ModelAndView mv, HttpSession httpSession, String emailVer) {
		SendEmail sendEmail= new SendEmail();
		System.out.println("-----------------");
		System.out.println(emailVer);
		String result = sendEmail.generateEmail(httpSession, emailVer);
		System.out.println("result: "+result+"보낸 번호: "+httpSession.getAttribute("verificationCode"));
		mv.addObject("result", result);
		mv.setViewName("/member/ajaxResult");
		return mv;
	}
	@GetMapping("verificationCodeCheck")
	public ModelAndView verificationCodeCheck(String verificationCode, ModelAndView mv, HttpSession httpSession) {
		System.out.println(verificationCode);
		System.out.println("string이니?: "+httpSession.getAttribute("verificationCode"));
		
		if(verificationCode.equals(httpSession.getAttribute("verificationCode"))) {
			mv.addObject("result", "yes");
		}else {
			mv.addObject("result", "실패.");
		}
		mv.setViewName("/member/ajaxResult");
		return mv;
	}
	//--이메일 끝
	
	//--업데이트--
	@GetMapping("update") //비번확인
	public ModelAndView setMyPageUpdate(ModelAndView mv, HttpSession session) {
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
		if(memberDTO.getLoginType().equals("general")) {			
			mv.setViewName("/member/updateCheck");
		}else {mv.setViewName("/member/update");} //카카오면 걍가
		
		return mv;
	}
	@GetMapping("update2")
	public String setUpdateCheck() {
		return "/member/update";
	}	
	
//	@GetMapping("emailUpdate") //안함~
//	public ModelAndView setEmailUpdate(DeliveryDTO deliveryDTO, MemberDTO memberDTO, ModelAndView mv) throws Exception {
//		int result=memberService.setEmailUpdate(memberDTO);
//		mv.addObject("result", result);
//		mv.setViewName("/member/ajaxResult");
//		//인증번호를 받고 submit버튼 누르면, 바로 업데이트되고 버튼 삭제
//		return mv;
//	}
	
	@GetMapping("delivery")
	public ModelAndView getDeliveryPage(HttpSession session, ModelAndView mv, boolean popUp) throws Exception {
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");

		if(popUp) {
			mv.addObject("popUp", popUp);
		}
		
		if(memberDTO.getId()!=null) {
			mv.addObject("deliveryList", memberService.getDeliveryPage(memberDTO));
			mv.setViewName("/member/delivery");			
		}else {
			mv.setViewName("/member/login");	
		}

		
		return mv;
	}
	@GetMapping("deliveryNew")
	public ModelAndView setDeliveryAdd(ModelAndView mv, boolean popUp) throws Exception {
		
		if(popUp) {
			mv.addObject("popUp", popUp);
		}
		mv.setViewName("/member/deliveryNew");
		return mv;
	}
	@PostMapping("deliveryAdd")
	public ModelAndView setDeliveryAdd(String primaryAddress, DeliveryDTO deliveryDTO, ModelAndView mv,HttpSession session
			, boolean popUp) throws Exception {
		
		//member에 주소가 없으면 prime 주소가 없을시 DELIVERY 강제로 대표주소로 CHECKED (member.address 업데이트)
		MemberDTO address_result=(MemberDTO)session.getAttribute("sessionMember");
		if(address_result.getAddress()==null) {primaryAddress="1";}
		//member address 업데이트.(대표주소)
		System.out.println("primaryAddress: "+primaryAddress);
		if(primaryAddress!=null&&primaryAddress.equals("1")) {
			MemberDTO memberDTO= new MemberDTO();
			memberDTO.setId(deliveryDTO.getId());
			memberDTO.setAddress(deliveryDTO.getAddress());
			memberDTO=memberService.setMemberAddressUpdate(memberDTO);
			session.setAttribute("sessionMember", memberDTO);
		}
		
		int result = memberService.setDeliveryAdd(deliveryDTO);
		mv.setViewName("redirect:./delivery");	//redirect:./delivery //popUp에서 추가했을시 "/member/delivery?popUp=true" 로 가야헤..
		if(popUp) {
			mv.addObject("popUp", popUp);
		}
		mv.addObject("result", result);
		//memberDTO ID를 session에서 꺼내든 parameter로 받아오든, deliveryDTO를 추가. 
		return mv;
	}
	@GetMapping("deliveryDelete")
	public ModelAndView setDeliveryDelete(HttpSession session,ModelAndView mv, DeliveryDTO deliveryDTO, boolean popUp) throws Exception {
		int result=memberService.setDeliveryDelete(deliveryDTO);
		mv.setViewName("/member/delivery");
		if(popUp) {
			mv.addObject("popUp", popUp);
		}
		

		//delivery불러옴
		mv.addObject("deliveryList", memberService.getDeliveryPage((MemberDTO)session.getAttribute("sessionMember")));
		mv.setViewName("/member/delivery");			
		
		return mv;
	}
	
	@GetMapping("deliveryUpdate")
	public ModelAndView setdeliveryUpdate(DeliveryDTO deliveryDTO, boolean popUp) throws Exception {
		ModelAndView mv = new ModelAndView();

		deliveryDTO=memberService.getDeliveryDetail(deliveryDTO);

		//상세주소랑 나눠줘야대네..
		String address=deliveryDTO.getAddress();
		String addressPost=address.substring(0, address.indexOf(","));
		String addressDetail=address.substring(address.indexOf(",")+1);
		mv.addObject("addressPost", addressPost);
		mv.addObject("addressDetail", addressDetail);
		
		if(popUp) {
			mv.addObject("popUp", popUp);
		}
		
		mv.setViewName("/member/deliveryUpdate");
		mv.addObject("deliveryDTO",deliveryDTO);
		return mv;
	}
	@PostMapping("deliveryUpdate")
	public ModelAndView setdeliveryUpdate(boolean popUp, HttpSession session,String primaryAddress, DeliveryDTO deliveryDTO, ModelAndView mv) throws Exception {
		
		System.out.println("--------------setdeliveryUpdate---------------");
		System.out.println(deliveryDTO.getAddress());
		
		int result=memberService.setdeliveryUpdate(deliveryDTO);
		
		System.out.println("업데이트 후: "+deliveryDTO.getId());
		//member address 업데이트.(대표주소)
		System.out.println("primaryAddress: "+primaryAddress);
		if(primaryAddress!=null&&primaryAddress.equals("1")) {
			MemberDTO memberDTO= new MemberDTO();
			memberDTO.setId(deliveryDTO.getId());
			memberDTO.setAddress(deliveryDTO.getAddress());
			memberService.setMemberAddressUpdate(memberDTO);
			
			//세션업데이트
//			MemberDTO memberCheck=(MemberDTO)session.getAttribute("sessionMember");
			session.setAttribute("sessionMember", memberDTO);
		}
		if(popUp) {
			mv.addObject("popUp", popUp);
		}
		
		mv.setViewName("redirect:./delivery");
		return mv;
	}
	


	
	//password Update
	@PostMapping("pwUpCheck")
	public ModelAndView passwordChangeCheck(String pw2,MemberDTO memberDTO, ModelAndView mv, HttpSession httpSession) throws Exception {
		MemberDTO memberCheck=(MemberDTO)httpSession.getAttribute("sessionMember");
		memberCheck=memberService.getMyPage(memberCheck); 
		System.out.println("보낸pw: "+memberDTO.getPw());
		
		System.out.println(memberCheck.getPw());
		System.out.println(memberDTO.getPw());
		
		//여기서 pw검사를...?
		if( memberDTO!=null && memberCheck.getPw().equals(memberDTO.getPw())  ) { //원래비번 일치
			String result="1";
			
			if(memberDTO.getPw().equals(pw2)) { //새비번과 중복
				result="2";
			}
			mv.addObject("result", result);
		}
//		else {
//			mv.addObject("result", 0);
//		}
		
		mv.setViewName("member/ajaxResult");
		return mv;
	}
	@PostMapping("pwChange")
	public ModelAndView setPasswordUpdate(MemberDTO memberDTO, ModelAndView mv, HttpSession httpSession) throws Exception {
		System.out.println(memberDTO.getId());
		System.out.println(memberDTO.getPw());
		int result=memberService.setPasswordUpdate(memberDTO);
		System.out.println(result);
		mv.setViewName("member/ajaxResult");
		mv.addObject("result", result);
		return mv;
	}

}
