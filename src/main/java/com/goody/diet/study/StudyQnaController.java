package com.goody.diet.study;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.goody.diet.util.Pager;

@Controller
@RequestMapping("/studyQna/**")
public class StudyQnaController {

	@Autowired
	private StudyQnaService studyQnaService;
	
	@ModelAttribute("boardName")
	public String getBoardName() {
		return "qna";
	}
	
	@GetMapping("list")
	public ModelAndView getBoardList(Pager pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StudyQnaDTO> ar = studyQnaService.getBoardList(pager);
		mv.addObject("list", ar);
		mv.addObject("pager", pager);
		mv.setViewName("studyQna/list");

		return mv;
	}
	
	@GetMapping("add")
	public ModelAndView setBoardAdd(Pager pager) throws Exception{
		ModelAndView mv = new ModelAndView();

		mv.setViewName("studyQna/add");
		return mv;
	}
	

	@PostMapping("add")
	public ModelAndView setBoardAdd(StudyQnaDTO qnaDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = studyQnaService.setBoardAdd(qnaDTO);
		
		String message="등록 실패";
		if(result>0) {
			message="글이 등록 되었습니다";
		}
		mv.addObject("url","/study/studyDetail?studyNum="+qnaDTO.getStudyNum());
		mv.addObject("result",message);
		mv.addObject("resultNum", result);
		mv.setViewName("common/result");

		return mv;
	}
	
	@GetMapping("detail")
	public ModelAndView getBoardDetail(StudyQnaDTO qnaDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = studyQnaService.setHitUpdate(qnaDTO);
		StudyQnaDTO qnaDTO2 = studyQnaService.getBoardDetail(qnaDTO);

		mv.addObject("dto", qnaDTO2);
		mv.setViewName("studyQna/detail");
		return mv;
	}
	
	@GetMapping("update")
	public ModelAndView setBoardUpdate(StudyQnaDTO qnaDTO, ModelAndView mv) throws Exception{
		qnaDTO = studyQnaService.getBoardDetail(qnaDTO);
		
		mv.addObject("dto", qnaDTO);
		
		mv.setViewName("studyQna/update");
		
		return mv;
	}
	
	@PostMapping("update")
	public ModelAndView setBoardUpdate(StudyQnaDTO qnaDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = studyQnaService.setBoardUpdate(qnaDTO);
		String message="수정 실패";
		if(result>0) {
			message="글이 수정 되었습니다";
		}
		mv.addObject("result", message);
		mv.addObject("resultNum", result);
		mv.addObject("url", "/study/studyDetail?studyNum="+qnaDTO.getStudyNum());
		mv.setViewName("common/result");
		
		return mv;
	}
	
	@PostMapping("delete")
	public ModelAndView setBoardDelete(StudyQnaDTO qnaDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = studyQnaService.setBoardDelete(qnaDTO);
		String message="삭제 실패";
		if(result>0) {
			message="글이 삭제 되었습니다";
		}
		System.out.println(qnaDTO.getStudyNum());
		mv.addObject("result", message);
		mv.addObject("url", "/study/studyDetail?studyNum="+qnaDTO.getStudyNum());
		mv.setViewName("common/result");
		return mv;
	}
	
	@GetMapping("reply")
	public ModelAndView setReplyAdd(StudyQnaDTO qnaDTO, ModelAndView mv) throws Exception{
		mv.setViewName("studyQna/reply");
		return mv;
	}
	
	@PostMapping("reply")
	public ModelAndView setReplyAdd(StudyQnaDTO qnaDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int result = studyQnaService.setReplyAdd(qnaDTO);
		
		String message="등록 실패";
		if(result>0) {
			message="글이 등록 되었습니다";
		}
		
		mv.setViewName("common/result");
		mv.addObject("resultNum", result);
		mv.addObject("result", message);
		mv.addObject("url","/study/studyDetail?studyNum="+qnaDTO.getStudyNum());
		return mv;
	}
}
