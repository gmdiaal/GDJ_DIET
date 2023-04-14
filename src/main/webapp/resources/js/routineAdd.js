
//routineAdd 
$('#modalButtons').ready(function() {
  $('#routineConfirm').click(function() {
    // 입력된 데이터 가져오기
    const title = $('#title').val();
    const startDay = new Date($('#startDay').val()); // Date 객체로 변환
    const endDay = new Date($('#endDay').val()); // Date 객체로 변환
    const videoId = $('#videoId').val();
    const machineNum = $('#machineNum').val();
    var machineName = $('#machineSelect').val();
    // 데이터 전송
    $.ajax({
      url: '/routine/add',
      type: 'POST',
      data: {
        title: title,
        startDay: startDay, 
        endDay: endDay, 
        videoId: videoId,
        machineName:machineName
      },
      success: function(data) {
        console.log('성공');
        // 등록이 성공하면 모달을 닫고 화면을 리다이렉트
        $('#exampleModal').modal('hide');
         location.href = './calendar';
      },
      error: function() {
        console.log('실패');
        // 등록이 실패하면 에러 메시지 출력
        alert('등록에 실패했습니다.');
      }
    });
  });
});


// UPDATE!!!!!!!!!! DELETE!!!!!!!!!!!!
$('#modalButtons').ready(function() {
  $('#updateBtn').click(function() {  
    
      // 모달창을 활성화
      $('#scheduleModal').modal('show');

      // 선택된 날짜에 해당하는 일정 목록 가져오기
      $('#selectedDay').on('change', function() {
      let startDay = $(this).val(); // yyyy-MM-dd 형태의 문자열
        console.log(startDay);
        fetch("/routine/list?startDay="+startDay,{
          method:'GET'
          
      })
      .then((response)=>response.text())
      .then((res)=>{
          $('#scheduleList').html(res.trim());
          let num=$('#routinenum').val();
          $("#contentsConfirm").attr("data-update-num",num);
      })
    });
  });
});

$("#contentsConfirm").click(function(){
  const startDay = new Date($('#routinestartDay').val()); // Date 객체로 변환
  const endDay = new Date($('#routineendDay').val()); // Date 객체로 변환
  const title = $('#routinetitle').val();
  const videoId = $('#routinevideoId').val();
  var machineName = $('#machineSelected').val();
  const num=$('#routinenum').val();
  console.log(startDay);

  console.log(endDay);
  console.log(title);
  console.log(videoId);
  console.log(num);

  
  $.ajax({
    url: '/routine/update',
    type: 'POST',
    data: {
      num:num,
      title: title,
      startDay: startDay, 
      endDay: endDay, 
      videoId: videoId,
      machineName: machineName
    },
    success: function(data) {
      alert('수정 성공');
      // 등록이 성공하면 모달을 닫고 화면을 리다이렉트
      $("#closeModal").click();
       location.href = './calendar';
    },
    error: function() {
      alert('수정 실패');
      // 등록이 실패하면 에러 메시지 출력
      alert('등록에 실패했습니다.');
    }
  });
})



// // UPDATE!!!!!!!!!! DELETE!!!!!!!!!!!!
// $('#modalButtons').ready(function() {
//     $('#updateBtn').click(function() {
//         // 모달창을 생성할 HTML 코드
//         let modalSelect = `
//           <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
//             <div class="modal-dialog">
//               <div class="modal-content">
//                 <div class="modal-header">
//                   <h5 class="modal-title" id="scheduleModalLabel">일정 수정</h5>
//                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
//                 </div>
//                 <div class="modal-body">
//                   <input type="date" id="selectedDay" name="selectedDay" class="form-control mb-3" required>
//                   <div id="scheduleList"></div>
//                 </div>
//                 <div class="modal-footer">
//                   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
//                   <button type="submit" class="btn btn-primary">수정</button>
//                 </div>
//               </div>
//             </div>
//           </div>
//         `;
    
//         // 모달창을 HTML로 추가
//         $('body').append(modalSelect);
    
//         // 모달창을 활성화
//         $('#scheduleModal').modal('show');
    
//         // 선택된 날짜에 해당하는 일정 목록 가져오기
//         $('#selectedDay').on('change', function() {
//           let selectedDay = $(this).val();
//           console.log(selectedDay);
//           $.ajax({
//             url: '/routine/calendar',
//             type: 'GET',
//             data: {  
//               startDay : selectedDay
//             },
//             success: function(data) {
//               // 일정 목록을 HTML로 변환하여 화면에 출력
//               let html = '';
//               for (let i = 0; i < data.length; i++) {
//                 html += '<div class="mb-3">'
//                     + '<label class="form-label">' + data[i].title + '</label>'
//                     + '<p>' + data[i].videoId + '</p>'
//                     + '<p>' + data[i].machineNum + '</p>'
//                     + '</div>';
//               }
//               $('#scheduleList').html(html);
//             },
//             error: function() {
//               alert('일정 목록을 불러오는데 실패했습니다.');
//             }
//           });
//         });
//       });
//     });

  // $('#updateBtn').click(function() {
  //     alert("수정하기");
  //         //모달창을 생성할 HTML 코드
  //         $('#selectDay').on('change', function() {
  //             const selectedDate = $(this).val();
  //                 $.ajax({
  //                 url: '/routine/update',
  //                 type: 'GET',
  //                 data: {
  //                     date: selectedDate
  //                 },
  //                 success: function(data) {
  //                     // 일정 목록을 HTML로 변환하여 화면에 출력
  //                     let html = '';
  //                     for (let i = 0; i < data.length; i++) {
  //                     html += '<div class="mb-3">'
  //                         + '<label class="form-label">' + data[i].title + '</label>'
  //                         + '<p>' + data[i].description + '</p>'
  //                         + '</div>';
  //                     }
  //                     $('#scheduleList').html(html);
  //                 },
  //                 error: function() {
  //                     alert('일정 목록을 불러오는데 실패했습니다.');
  //                 }
  //                 });
  //             });     
  //         const modalHtml = '<div class="modal fade" id="upModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">' + 
  //                           '<div class="modal-dialog">' +
  //                           '<div class="modal-content">' +
  //                           '<div class="modal-header">' +
  //                            '<h1 class="modal-title fs-5" id="exampleModalLabel">루틴을 수정하세요!</h1>' +
  //                             '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
  //                             '</div>'
  //                             +'<label for="selectDay">수정할 날짜: </label><input type="date" id="selectDay" for="${list.startDay}">'+'</input>'
  //                             +'<div id="scheduleList"></div>'
  //                             + '<div class="modal-body">'
  //            + '<label for="title" class="col-form-label">루틴 제목</label>'
  //            + '<input type="text" class="form-control" id="title" name="title">'	
  //            + '<label for="startDay" class="col-form-label">시작 날짜</label>'
  //            + '<input type="date" class="form-control" id="startDay" name="startDay">'
  //            + '<label for="endDay" class="col-form-label">종료 날짜</label>'
  //            + '<input type="date" class="form-control" id="endDay" name="endDay">'
  //            + '<label for="videoId" class="col-form-label">루틴영상URL</label>'
  //            + '<input type="text" class="form-control" id="videoId" name="videoId">'
  //            + '<label for="machineNum" class="col-form-label">운동기구</label>'
  //            + '<input type="text" class="form-control" id="machineNum" name="machineNum">' 
  //         + '</div>'
  //         + '<div class="modal-footer">'
  //          + '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="closeModal">취소</button>'
  //           + '<button type="submit" class="btn btn-primary" id="updateConfirm">수정하기</button>'
  //           + '<button type="submit" class="btn btn-primary" id="deleteConfirm">삭제하기</button>'
  //         + '</div>'
  //      + '</div>'
  //     + '</div>'
  //         // 모달창을 body에 추가
  //         $("body").append(modalHtml);
  //         // 모달 엘리먼트를 jQuery로 선택하여 show() 메소드를 이용하여 보여줌
  //         $("#upModal").modal("show");  
      
//      $('#updateConfirm').click(function() {// 입력된 데이터 가져오기
//      const title = $('#title').val();
//      const startDay = new Date($('#startDay').val()); // Date 객체로 변환
//      const endDay = new Date($('#endDay').val()); // Date 객체로 변환
//      const videoId = $('#videoId').val();
//      const machineNum = $('#machineNum').val();

//      console.log(title);
//      console.log(startDay);
//      console.log(endDay);
//      console.log(videoId);
//      console.log(machineNum);

//      // 데이터 전송
//      $.ajax({
//        url: '/routine/update',
//        type: 'POST',
//        data: {
//          title: title,
//          startDay: startDay, 
//          endDay: endDay, 
//          videoId: videoId,
//          machineNum: machineNum
//        },
//        success: function(data) {
//          console.log('성공');
//          // 등록이 성공하면 모달을 닫고 화면을 리다이렉트
//          $('#upModal').modal('hide');
//           location.href = './calendar';
//        },
//        error: function() {
//          console.log('실패');
//          // 등록이 실패하면 에러 메시지 출력
//          alert('등록에 실패했습니다.');
//        }
//         });
//     });
// });



// $("#categorySelect").change(function(){
//     $("#categoryId").val($("#categorySelect").val())
//     console.log($(this).val())
//     console.log($("#categoryId").val())
// })

// $(document).ready(function() {
//     // 등록 버튼 클릭시
//     $('#routineConfirm').click(function() {
//       // 입력된 데이터 가져오기
//       const title = $('#title').val();
//       const startDay = $('#startDay').val();
//       const endDay = $('#endDay').val();
//       const videoId = $('#videoId').val();
//       const machineNum = $('#machineNum').val();
//         console.log(title)
//         console.log(endDay)
//         console.log(machineNum)
//       // 데이터 전송
//       $.ajax({
//         url: '/routine/add',
//         type: 'POST',
//         data: {
//           title: title,
//           startDay: startDay,
//           endDay: endDay,
//           videoId: videoId,
//           machineNum: machineNum
//         },
//         success: function(data) {
//             console.log('성공')
//           // 등록이 성공하면 모달을 닫고 화면을 리다이렉트
//           $('#exampleModal').modal('hide');
//           location.href = './calendar';
//         },
//         error: function() {
//             console.log('실패')
//           // 등록이 실패하면 에러 메시지 출력
//           alert('등록에 실패했습니다.');
//         }
//       });
//     });
//   });

// $('#routineBtn').click(function(){
//     location.href="./add";
// });


