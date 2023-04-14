<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row d-flex justify-content-center">
	<div class="col-8 m-5">
    <table class="table my-table">
        <thead>
            <c:if test="${not empty list}">
                <tr>
<!--                     <th style="text-align: left;">ID</th> -->
					<th>ID</th>
                    <th>STUDYNUM</th>
                    <th>PW</th>
                    <th>NAME</th>
                    <th>PHONE</th>
                    <th>EMAIL</th>
                    <th>ADDRESS</th>
                    <th>loginType</th>
                </tr>
            </c:if>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="dto">
                <tr>
                    <td>${dto.id}</td>
                    <td>${dto.studyNum}</td>
                    <td>${dto.pw}</td>				
                    <td>${dto.names}</td>
                    <td>${dto.phone}</td>
                    <td>${dto.email}</td>
                    <td>${dto.address}</td>
                    <td>
                    ${dto.loginType}
	<!-- Button trigger modal -->
	<c:if test="${dto.loginType eq 'general'}">
	<button type="button" class="btn btn-primary delBtn" data-del-id="${dto.id}" data-del-lginType="${dto.loginType}"
		>회원탈퇴</button>	
	</c:if>
	<c:if test="${dto.loginType ne 'general'}">
	<button type="button" class="btn btn-secondary delBtn" data-del-id="${dto.id}" data-del-lginType="${dto.loginType}"
		>회원탈퇴</button>	
	</c:if>	
	
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div></div>


<!-- 페이징 -->
<div class="row">
	<nav aria-label="Page navigation example">
		<ul class="pagination ">
			<li class="page-item "><a class="page-link text-dark page-qna" href="#"
				aria-label="Previous" data-board-page="1"> <span
					aria-hidden="true">&laquo;</span>
			</a></li>
			<li class="page-item ${pager.before?'disabled':''}"><a
				class="page-link text-dark page-qna" href="#" aria-label="Previous"
				data-board-page="${pager.startNum-1}"> <span aria-hidden="true">&lsaquo;</span>
			</a></li>

			<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
				<li class="page-item"><a class="page-link text-dark page-qna" href="#"
					data-board-page="${i}">${i}</a></li>
			</c:forEach>

			<li class="page-item ${pager.after eq false ? 'disabled' : ''}">
				<%--${pager.after eq false ? 'disabled' : ''} --%> <a
				class="page-link text-dark page-qna" href="#" aria-label="Next"
				data-board-page="${pager.lastNum+1}"> <span aria-hidden="true">&rsaquo;</span>
			</a>
			</li>
			<li class="page-item ">
				<%--${pager.after eq false ? 'disabled' : ''} --%> <a
				class="page-link text-dark page-qna" href="#" aria-label="Next"
				data-board-page="${pager.totalPage}"> <span aria-hidden="true">&raquo;</span>
			</a>
			</li>
		</ul>
	</nav>
</div>

<!-- 검색창 -->
<div class="row">
	
		<div class="col-auto">
			<label for="kind" class="visually-hidden">Kind</label> <select
				class="form-select" name="kind" id="kind"
				aria-label="Default select example">
				<option class="searchOption">선택</option>
				<option class="searchOption" value="names" ${pager.kind eq 'names'?'selected':''}>NAME</option>
				<option class="searchOption" value="loginType" ${pager.kind eq 'loginType'?'selected':''}>LOGIN TYPE</option>
			</select>
		</div>
		<div class="col-auto">
			<label for="search" class="visually-hidden">Search</label> <input
				type="text" class="form-control" style="font-size:15px;" value="${pager.search}"
				name="search" id="search" placeholder="검색어를 입력하세요.">
		</div>
		<div class="col-auto">
			<button type="button" class="btn btn-primary mb-3" id="searchbutton">검색</button>
		</div>
		

</div>