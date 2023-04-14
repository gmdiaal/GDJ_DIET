<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="com.goody.diet.exercise.RoutineDTO"%>
<!DOCTYPE html>
<html>
 <head>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.5/index.global.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/rrule@2.6.4/dist/es5/rrule.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
 <title>이달의 루틴</title>
 <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

 <c:import url="../template/common_css.jsp"></c:import>
 <c:import url="../template/header.jsp"></c:import>
 </head>
 <body>

<script type="text/javascript">


document.addEventListener('DOMContentLoaded', function() {
	
    const calendarEl = document.getElementById('calendar');
    const calendar = new FullCalendar.Calendar(calendarEl, {
      initialView : 'dayGridMonth',
      locale : 'ko', // 한국어 설정
      customButtons: {
    	    myCustomButton: {
    	      text: '루틴일정추가',
    	      click: function() {
    	        alert('clicked the custom button!');}
    	    }
      },
      headerToolbar : {
        start : "today",
        center : "title",
        end : "prev next",
        
      },
      selectable : false,
      droppable : false,
      draggbable: false,	
      editable : false,
      events : [
        <c:forEach var="dto" items="${routine}">
          {
            title : '${dto.title}',
            start : '${dto.startDate}',
            end : '${dto.endDate}',
            url : 'http://localhost/routine/video?num=${dto.num}',
            color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
          },
        </c:forEach>
      ],
      eventClick: function(info) {
    	    alert(info.event.title + ':' + '수강하시겠습니까?');
    	    // change the border color just for fun
    	    info.el.style.borderColor = 'red';
    	  }, 
    
      displayEventTime: false, // 시간 표시 x
      /* dateClick: function(info) {
    	  // 출석체크 확인 메시지를 띄우기
    	  alert('출석체크하시겠습니까?');
    	  
    	  // 해당 일자의 배경 이미지를 추가하기
    	  info.dayEl.style.backgroundImage = "url('../resources/images/redcheck.png')";
    	  info.dayEl.style.backgroundRepeat = 'no-repeat';
    	  info.dayEl.style.backgroundPosition = 'center';
    	  info.dayEl.style.backgroundColor = 'transparent';
    	  
    	  eventRender: function(info) {
	    	  // 이벤트와 이미지를 감싸는 부모 요소 생성
	    	  var containerEl = document.createElement('div');
	    	  containerEl.classList.add('event-container');
	    	  // 이미지 요소 생성 및 추가
	    	  var imageEl = document.createElement('div');
	    	  imageEl.classList.add('event-image');
	    	  imageEl.style.backgroundImage = "url('path/to/image.png')";
	    	  containerEl.appendChild(imageEl);
	    	  // 이벤트 요소 추가
	    	  var eventEl = info.el;
	    	  containerEl.appendChild(eventEl);
	    	  // 렌더링 결과 반환
	    	  return containerEl;
	    	} 
    	  
    	}, */
    	  /* eventDrop: function (info) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
    		  console.log(info);
    		  if(confirm("'"+ info.event.title +"' 매니저의 일정을 수정하시겠습니까 ?")){
              }
              var events = new Array(); // Json 데이터를 받기 위한 배열 선언
              var obj = new Object();

              obj.title = info.event._def.title;
              obj.start = info.event._instance.range.start;
              obj.end = info.event._instance.range.end;
              events.push(obj);

              console.log(events);
              $(function deleteData() {
                  $.ajax({
                      url: "/full-calendar/calendar-admin-update",
                      method: "PATCH",
                      dataType: "json",
                      data: JSON.stringify(events),
                      contentType: 'application/json',
                  })
              })
          },
              $(function saveData(jsondata) {
                  $.ajax({
                      url: "/add",
                      method: "POST",
                      dataType: "json",
                      data: JSON.stringify(events),
                      contentType: 'application/json',
                  })
                      .done(function (result) {
                          // alert(result);
                      })
                      .fail(function (request, status, error) {
                           alert("에러 발생" + error);
                      });
                  calendar.unselect()
              });
          }, 
 */
  	});
  calendar.render();

  });

 </script>
 <div class="container">
	 <div class="row justify-content-center mb-5 pb-3">
 	 <div class="col-md-12 heading-section ftco-animate text-center" style="line-height:5%">
 	 <h3 class="mb-1">이달의 루틴 </h3><br><h3>Calendar</h3>
 	</div>
 	</div>
 
	<div id="modalButtons">
	 <c:if test="${sessionMember.roleDTO.roleName eq 'ADMIN'}">
 <button type="button" id="routineBtn"class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">루틴일정추가</button>
 <button type="button" id="updateBtn"class="btn btn-warning" data-bs-toggle="modal2" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">루틴일정수정</button>
 	</c:if>
 
 <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> 
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">루틴을 등록하세요!</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
         <label for="title" class="col-form-label">루틴 제목</label>
         <input type="text" class="form-control" id="title" name="title">	
         <label for="startDay" class="col-form-label">시작 날짜</label>
         <input type="date" class="form-control" id="startDay" name="startDay">
         <label for="endDay" class="col-form-label">종료 날짜</label>
         <input type="date" class="form-control" id="endDay" name="endDay">
         <label for="videoId" class="col-form-label">루틴영상URL</label>
         <input type="text" class="form-control" id="videoId" name="videoId"> 
         <label for="machineName" class="col-form-label">운동기구</label>
         <select class="form-select" id="machineSelect" name="HealthMachineDTOs">
         	<c:forEach items="${list}" var="dto">
				<option value="${dto.machineName}">${dto.machineName}</option>
			</c:forEach>
         </select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closeModal">취소</button>
        <button type="submit" class="btn btn-primary" id="routineConfirm">등록</button>
      </div>
    </div>
  </div>
 </div>
 
 <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="scheduleModalLabel">일정 수정</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <input type="date" id="selectedDay" name="selectedDay" class="form-control mb-3" required>
                  <div id="scheduleList">
						
				</div>
                  
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closeModal">닫기</button>
                  <button type="submit" class="btn btn-primary" id="contentsConfirm" data-update-num="">수정</button>
                </div>
              </div>
            </div>
          </div>
</div>
 
 <div>
<div id='calendar'></div>
 </div>
</div>
 
 <!-- 로그인 모달  -->
    <div class="modal fade" id="loginModal" tabindex="-1"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginModalLabel">로그인이 필요합니다</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body text-center">로그인 후 이용해주세요.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<a href="/member/login" class="btn btn-primary">로그인</a>
			</div>
		</div>
	</div>
</div>


 
 <!-- loader -->

<!-- <script src="/resources/js/video.js"></script> -->
 <script src="/resources/js/routineAdd.js"></script>
 <!-- <script src="/resources/js/update.js"></script> -->
<c:import url="../template/footer.jsp"></c:import>
<c:import url="../template/common_js.jsp"></c:import> 
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</body>
</html>