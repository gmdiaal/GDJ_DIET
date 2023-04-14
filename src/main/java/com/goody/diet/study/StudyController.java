package com.goody.diet.study;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.goody.diet.board.BbsDTO;
import com.goody.diet.util.Pager;


@Controller
@RequestMapping("/study/")
public class StudyController {
	
	@Autowired
	private StudyService studyService;
	
	@GetMapping("studyList")
	public ModelAndView getBoardList(Pager pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		List<StudyDTO> ar  = studyService.getBoardList(pager);
		mv.setViewName("study/studyList");
		mv.addObject("list", ar);
		mv.addObject("pager", pager);
		return mv;
	}
	
	@GetMapping("studyDetail")
	public ModelAndView getBoardDetail(StudyDTO studyDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		studyDTO = studyService.getBoardDetail(studyDTO);
		Long review = studyService.getStudyReivewCount(studyDTO);
		Long qna = studyService.getStudyQnaCount(studyDTO);
		
		mv.addObject("review", review);
		mv.addObject("qna", qna);
		mv.addObject("dto", studyDTO);
		mv.setViewName("study/studyDetail");
		
		return mv;
	}
	
	
	@PostMapping("summerFile")
	public ModelAndView setBoardFileAdd(MultipartFile files,HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		String file = studyService.setBoardFileAdd(files, session);
		mv.setViewName("common/ajaxResult");
		mv.addObject("result", file);
		return mv;
	}
	
	@GetMapping("studyAdd")
	public ModelAndView setBoardAdd() throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("study/studyAdd");
		return mv;
	}
	
	@PostMapping("studyAdd")
	public ModelAndView setBoardAdd(StudyDTO studyDTO, MultipartFile[] addFiles,HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = studyService.setBoardAdd(studyDTO,addFiles,session);
		
		String message="등록 실패";
		if(result>0) {
			message="글이 등록 되었습니다";
		}
		mv.addObject("resultNum", result);
		mv.addObject("result",message);
		mv.addObject("url","./studyList");
		mv.setViewName("common/result");
		return mv;
	}
	
	@GetMapping("studyUpdate")
	public ModelAndView setBoardUpdate(StudyDTO studyDTO) throws Exception{
		ModelAndView mv = new ModelAndView();
		studyDTO = studyService.getBoardDetail(studyDTO);
		
		mv.addObject("dto", studyDTO);
		
		mv.setViewName("study/studyUpdate");
		
		return mv;
	}
	
	@PostMapping("studyUpdate")
	public ModelAndView setBoardUpdate(StudyDTO studyDTO, MultipartFile[] addFiles, HttpSession session, Long fileNum) throws Exception{
		ModelAndView mv = new ModelAndView();
		System.out.println(fileNum);
		int result = studyService.setBoardUpdate(studyDTO, addFiles, session, fileNum);
		mv.addObject("resultNum", result);
		mv.setViewName("common/result");
		mv.addObject("result", "수정성공");
		mv.addObject("url", "./studyList");
		
		return mv;
	}
	
	@PostMapping("studyDelete")
	public ModelAndView setBoardDelete(StudyDTO studyDTO, Long fileNum) throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = studyService.setBoardDelete(studyDTO, fileNum);
		
		String message="삭제 실패";
		if(result>0) {
			message="글이 삭제 되었습니다";
		}
		mv.addObject("resultNum", result);
		mv.addObject("result",message);
		mv.addObject("url", "./studyList");
		mv.setViewName("common/result");
		return mv;
	}
	//-------------------------------------------
	
} 
