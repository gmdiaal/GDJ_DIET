<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
 <head>
 <title>Meditative - Free Bootstrap 4 Template by Colorlib</title>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <c:import url="../template/common_css.jsp"></c:import>
 </head>
 
 <body>
<!-- modal 추가 -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">루틴을 등록하세요</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="title" class="col-form-label">루틴 제목</label>
                        <input type="text" class="form-control" id="title" name="title">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="date" class="form-control" id="start" name="start">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="date" class="form-control" id="end" name="end">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="addCalendar">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">취소</button>
                </div>
    
            </div>
        </div>
    </div>

<!-- <div class="mb-3">
				<label for="studyName" class="form-label">스터디 이름</label> 
				<input type="text" name="studyName" class="form-control" id="studyName" placeholder="온라인 스터디 입력">
			</div> -->
 <tr>
 <td class="text-center">
 <strong></strong>
 <div class="img rounded-circle mb-2" style="background-image: "></div>
 <a href="" class="videoId" data-day="1"><strong></strong></a>
 </td>
 <td class="text-center"></td>
 <td class="text-center"></td>
 
<td class="text-center">
 <strong>${dto.days}</strong>
 <div class="img rounded-circle mb-2" style="background-image: url(/resources/images/leg1.png);"></div>
 <a href="./exercise/video?days=1일차" class="videoId" data-day="1"><strong>승마살 싹뚝루틴</strong></a>
 </td>

 </body>
</html>