package com.goody.diet.exceptions;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class ExceptionController {
	
	@ExceptionHandler(Exception.class)
	public ModelAndView fix2Exception() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("common/notFound");
		return mv;
	}
	
}
