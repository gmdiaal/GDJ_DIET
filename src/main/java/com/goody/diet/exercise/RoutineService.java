package com.goody.diet.exercise;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goody.diet.healthMachine.HealthMachineDTO;


@Service
public class RoutineService {
	
	@Autowired
	private RoutineDAO routineDAO;
	
	// List - 이달의 루틴 영상리스트 
	public List<RoutineDTO> getRoutineList() throws Exception {
		return routineDAO.getRoutineList();
	}
	public List<RoutineDTO> getSelectList(RoutineDTO routineDTO) throws Exception {
		return routineDAO.getSelectList(routineDTO);
	}
	
	// Detail - 이달의 루틴 영상 재생 
	public RoutineDTO getRoutineVideo(RoutineDTO routineDTO) throws Exception {
		return routineDAO.getRoutineVideo(routineDTO);
	}
	// 머신리스트 
	public List<HealthMachineDTO> getRoutineMachine() throws Exception {
		return routineDAO.getRoutineMachine();
	}
	// 루틴 등록 (기본) 
	public int setRoutineAdd(RoutineDTO routineDTO, HttpSession session) {
		// TODO Auto-generated method stub
		return routineDAO.setRoutineAdd(routineDTO);
	}
	
	// 루틴 수정
	public int setRoutineUpdate(RoutineDTO routineDTO, HttpSession session) {
		
		
		return routineDAO.setRoutineUpdate(routineDTO);
	}
	
	// 루틴 삭제
	public int setRoutineDelete(RoutineDTO routineDTO) {
		return routineDAO.setRoutineDelete(routineDTO);
	}
	
	// 머신 불러오기
	public List<HealthMachineDTO> getMachineName() {
		return routineDAO.getMachineName();
	}
	
	// 루틴 체크 1 
	public int setRoutineChecked(RoutineDTO routineDTO) {
			return routineDAO.setRoutineChecked(routineDTO);
	}		
	
	public void saveRoutine(RoutineDTO routineDTO) {
        routineDAO.setRoutineAdd(routineDTO);
    }
	public List<RoutineDTO> getRoutineUpdate() {
		// TODO Auto-generated method stub
		return routineDAO.getRoutineUpdate();
	}
	
//	public int setRoutineAdd(HttpSession httpSession) throws Exception{
//		List<RoutineDTO> routineDTOs = routineDAO.getRoutineMachine();
//		for (RoutineDTO routineDTO : routineDTOs) {
//			List<HealthMachineDTO> healthMachineDTOs = routineDTO.getHealthMachineDTOs();
//			if (healthMachineDTOs != null && !healthMachineDTOs.isEmpty()) {
//				routineDTO.setMachineName(healthMachineDTOs.get(0).getMachineName());
//				
//				System.out.println("machineNum : " + routineDTO.getMachineNum());
//				System.out.println("machineName : " + routineDTO.getMachineName());
//			}
//	
//		}
//		return routineDTOs;
//		
		
		//		int result = routineDAO.setRoutineAdd(routineDTO);
//		HashSet<Long> hashSet = new HashSet<Long>(Arrays.asList(healtMachineDTOs));//배열 -> 리스트  파라미터로 받는 것들은 리스트로 받지못함.
//		healtMachineDTOs=hashSet.toArray(new Long[0]);
//
//		for(Long machineNum : healtMachineDTOs) {
//			HealthMachineDTO healthMachineDTO = new CategoryDTO();
//			categoryDTO.setCategoryNum(categoryNum);
//			categoryDTO.setMachineNum(healthMachineDTO.getMachineNum());
//			result = healthMachineDAO.setCategoryType(categoryDTO);
//			healthMachineDTO.setMachineName(machineName);
//			healthMachineDTO.setMachineNum(routineDTO.getMachineNum()));
//			result = routineDAO.set
			//			System.out.println(categoryNum);
		
		
//		return routineDAO.setRoutineAdd(routineDTO);
//	}
//	

}
