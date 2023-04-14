package com.goody.diet.study;

import java.sql.Date;
import java.util.List;

public class StudyDTO {
	
	private Long studyNum;
	private String studyName;
	private Long studyCost;
	private Date studyStartPeriod;
	private Date studyEndPeriod;
	private Long studyStock;
	private Double studyScore;
	
	private List<StudyBoardFileDTO> studyBoardFileDTOs;
	private List<StudyReviewDTO> studyReviewDTOs;
	
	public Long getStudyNum() {
		return studyNum;
	}
	public void setStudyNum(Long studyNum) {
		this.studyNum = studyNum;
	}
	public String getStudyName() {
		return studyName;
	}
	public void setStudyName(String studyName) {
		this.studyName = studyName;
	}
	public Long getStudyCost() {
		return studyCost;
	}
	public void setStudyCost(Long studyCost) {
		this.studyCost = studyCost;
	}

	public Date getStudyStartPeriod() {
		return studyStartPeriod;
	}
	public void setStudyStartPeriod(Date studyStartPeriod) {
		this.studyStartPeriod = studyStartPeriod;
	}
	public Date getStudyEndPeriod() {
		return studyEndPeriod;
	}
	public void setStudyEndPeriod(Date studyEndPeriod) {
		this.studyEndPeriod = studyEndPeriod;
	}
	public Long getStudyStock() {
		return studyStock;
	}
	public void setStudyStock(Long studyStock) {
		this.studyStock = studyStock;
	}
	public List<StudyBoardFileDTO> getStudyBoardFileDTOs() {
		return studyBoardFileDTOs;
	}
	public void setStudyBoardFileDTOs(List<StudyBoardFileDTO> studyBoardFileDTOs) {
		this.studyBoardFileDTOs = studyBoardFileDTOs;
	}
	public List<StudyReviewDTO> getStudyReviewDTOs() {
		return studyReviewDTOs;
	}
	public void setStudyReviewDTOs(List<StudyReviewDTO> studyReviewDTOs) {
		this.studyReviewDTOs = studyReviewDTOs;
	}
	public Double getStudyScore() {
		return studyScore;
	}
	public void setStudyScore(Double studyScore) {
		this.studyScore = studyScore;
	}
	
	
	

}
