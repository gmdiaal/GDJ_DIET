package com.goody.diet.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	
//그냥 JS에서 할게요...ㅠ
//	@RequestMapping(value = "kakaoLogin")
//    public String kakaoLogin() throws Exception {
//    	System.out.println("왔어...");
////    	String kakaoUrl="https://kauth.kakao.com/oauth/authorize?client_id=4dbfcfd2f5a649a659ccd93aa0364e69&redirect_uri=https://localhost/oauth&response_type=code";
////    	String url = "/member/kakao";
////    	return kakaoUrl;
//    	
//    	String restAPI="4dbfcfd2f5a649a659ccd93aa0364e69";
//        StringBuffer loginUrl = new StringBuffer();
//        loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
//        loginUrl.append(restAPI); //REST API
//        loginUrl.append("&redirect_uri=");
//        loginUrl.append("https://localhost/oauth"); //redirect URL
//        loginUrl.append("&response_type=code");
//        
//        return "redirect:"+loginUrl.toString();
//    }	

	@PostMapping("kakaoLogin")
	public ModelAndView getKakaoLogin(ModelAndView mv, MemberDTO memberDTO, HttpSession session) throws Exception {
		System.out.println("카카오왓니?");
		memberDTO = memberService.getKakaoLogin(memberDTO);
		if(memberDTO!=null) {
			memberService.getMyPage(memberDTO);
			session.setAttribute("sessionMember", memberDTO);	
		}
		mv.setViewName("redirect:./dummiHome");

//		MemberAuthDTO result = (MemberAuthDTO)session.getAttribute("sessionMember");
//		System.out.println("세션: "+result.getEmail());
		return mv;
	}
//------------------카카오 끝----------------------
	
	
	@GetMapping("dummiHome")
	public String dummiHome() throws Exception {
		return "/member/dummiHome";
	}

	@PostMapping("delete")
	public ModelAndView setMemberDelete(ModelAndView mv, HttpSession session) throws Exception {
		System.out.println("post delete 왓니?");
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
		int delResult=memberService.setMemberDelete(memberDTO);
		session.invalidate();
		
		System.out.println("del ajax 가니?: " +delResult);
		mv.addObject("result", delResult);
		mv.setViewName("/member/ajaxResult");
		return mv;
	}
	
	@GetMapping("agree")
	public ModelAndView setMemberAgree(ModelAndView mv) throws Exception {
		mv.setViewName("member/agree");
		return mv;
	}
	
	@GetMapping("login")
	public String setMemberLogin() throws Exception {
		return "/member/login";
	}
	@PostMapping("login")
	public ModelAndView getMemberLogin(ModelAndView mv, MemberDTO memberDTO, HttpSession session) throws Exception {
//		System.out.println("컨트롤러왔니..?");
//		System.out.println("ajax옴?: "+memberDTO.getPw());
//		memberDTO.setLoginType("general"); //내가젖소..ㅠ
		memberDTO = memberService.getMemberLogin(memberDTO);

//		System.out.println("타입: "+memberDTO.getLoginType());
		
		if(memberDTO!=null) {
//			memberService.getMyPage(memberDTO);
			session.setAttribute("sessionMember", memberDTO);			
//			mv.setViewName("redirect:./dummiHome");
//			MemberDTO result = (MemberDTO)session.getAttribute("sessionMember");
//			System.out.println("세션: "+result+" 이메일"+result.getEmail());	
			
			mv.addObject("result", "굳^^");
			mv.setViewName("/member/ajaxResult");
		}else {//로그인실패
			mv.addObject("result", "id/pw불일치"); //trim인데 띄어쓰기댐?
			mv.setViewName("/member/ajaxResult");
		}
		
		
		
		return mv;
	}
	@GetMapping("logout")
	public String getMemberLogout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:./dummiHome";
	}
	
	@GetMapping("myPage")
	public void getMyPage(ModelAndView mv, HttpSession session) throws Exception {
		
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("sessionMember");
		
		System.out.println("로그인타입: "+memberDTO.getLoginType());
		
		
//		if(memberDTO!=null) {
//			memberDTO = memberService.getMyPage(memberDTO);
//		}
//		mv.addObject("mypage",memberDTO );
//		mv.setViewName("/member/myPage");
//		return mv;
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
	@PostMapping("emailCheck")
	public ModelAndView getEmailCheck (MemberDTO memberDTO, ModelAndView mv) throws Exception {
//		System.out.println(memberDTO.getId());
		String result = memberService.getEmailCheck(memberDTO);
//		System.out.println(result);
		mv.addObject("result", result);
		mv.setViewName("/member/ajaxResult");
		return mv;
	}
	@GetMapping("verificationCode")
	public ModelAndView sendVerificationCode(ModelAndView mv, HttpSession httpSession) {
		SendEmail sendEmail= new SendEmail();
		String result = sendEmail.generateEmail(httpSession);
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
			mv.addObject("result", "실패했따.");
		}
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
		
		System.out.println(memberDTO.getAddress());
		
		mv.setViewName("redirect:../");
		mv.addObject("result", result);
		return mv;
	}

}
