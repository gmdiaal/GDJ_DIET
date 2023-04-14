package com.goody.diet.exercise;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.goody.diet.healthMachine.HealthMachineDTO;


@Controller
@RequestMapping(value="/routine/*")
public class RoutineController {
	
	@Autowired
	private RoutineService routineService;
	
	// 루틴 리스트 캘린더에 뿌리기
	@GetMapping("calendar")
	public ModelAndView getRoutineList() throws Exception{
		ModelAndView mv = new ModelAndView();
		List<RoutineDTO> ar = routineService.getRoutineList();
		List<HealthMachineDTO> list = routineService.getMachineName();
		mv.setViewName("routine/calendar");
		mv.addObject("routine", ar);
		mv.addObject("list", list);
		
		return mv;
	}

	@GetMapping("list")
	public ModelAndView getSelectList(@RequestParam("startDay") String startDay) throws Exception{
	    ModelAndView mv = new ModelAndView();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate localDate = LocalDate.parse(startDay, formatter);
	    java.sql.Date date = java.sql.Date.valueOf(localDate);
	    RoutineDTO routineDTO = new RoutineDTO();
	    routineDTO.setStartDay(date);
	    System.out.println(routineDTO.getStartDate());
	    List<RoutineDTO> ar = routineService.getSelectList(routineDTO);
	    List<HealthMachineDTO> list = routineService.getMachineName();
	    mv.setViewName("routine/list");
	    mv.addObject("ar", ar);
	    mv.addObject("list", list);
	    return mv;
	}
	
	//이달의 루틴영상 play page  - routine detail 
	@GetMapping("video")
	public ModelAndView getRoutineVideo(ModelAndView mv, RoutineDTO routineDTO) throws Exception {
		routineDTO = routineService.getRoutineVideo(routineDTO);
		mv.setViewName("routine/video");
		mv.addObject("dto", routineDTO);
		return mv;
	}
	@PostMapping("add")
	public ModelAndView setRoutineAdd(ModelAndView mv, RoutineDTO routineDTO, HttpSession session) throws Exception {
		int result = routineService.setRoutineAdd(routineDTO, session);
		
		String message="실패";
		if(result>0) {
			message="성공";
		}
		mv.addObject("result", message);
		mv.setViewName("common/result");
		return mv;	
	}
	
	@PostMapping("update")
	public ModelAndView  setRoutineUpdate(RoutineDTO routineDTO, HttpSession session)throws Exception{
		ModelAndView mv = new ModelAndView();
		System.out.println(routineDTO.getStartDate());
		System.out.println(routineDTO.getStartDate());
		
		int result = routineService.setRoutineUpdate(routineDTO, session);
		String msg = "업데이트 실패";
		if(result>0) {
			msg = "업데이트 성공";
		}
		mv.addObject("result", msg);
		mv.setViewName("common/result");
		return mv;
	}
	
	@PostMapping("delete")
	public ModelAndView  setRoutineDelete(RoutineDTO routineDTO)throws Exception{
		ModelAndView mv = new ModelAndView();
		int result = routineService.setRoutineDelete(routineDTO);
		String msg = "삭제 실패";
		if(result>0) {
			msg = "삭제 성공";
		}
		mv.addObject("result", msg);
		mv.addObject("url", "/routine/calendar");
		mv.setViewName("common/result");
		return mv;
	}

	
}
