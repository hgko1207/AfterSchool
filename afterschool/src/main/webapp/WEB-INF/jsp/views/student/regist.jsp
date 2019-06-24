<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/student.css" rel="stylesheet" type="text/css">

<div class="navbar navbar-expand-md navbar-dark">
	<div class="navbar-brand">
		<a href="/" class="d-inline-block">
			<span><i class="icon-shutter mr-2"></i>방과후학교 학생등록</span>
		</a>
	</div>
</div>

<div class="page-content">
	<div class="content-wrapper">
		<div class="content d-flex justify-content-center align-items-center">
			<form id="studentRegistForm" class="login-form form-validate" method="POST"> 
				<div class="card mb-0">
					<div class="card-header bg-teal-400 text-white">
						<h2>
							경남교육청<br>(캠퍼스 형 방과후학교)<br>
					    </h2>
					</div>
					<div class="card-body student-content">
						<p class="info-text mt-1">*정보 입력 후 하단 [학생등록]을 클릭하세요.<br>핸드폰에 반드시 수업관련안내를 받으실 번호<br>(학부모 전화번호)를 입력하세요.
						<div class="form-group row pt-2">
							<label class="col-form-label col-3">학 교</label>
							<div class="col-9">
								<select data-placeholder="- 선 택 -" class="form-control select-search" name="school" required>
									<option></option>
									<c:forEach var="school" items="${schools}" varStatus="status">
										<option value="${school}">${school}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-3">학 년</label>
							<div class="col-9">
								<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="grade" required>
									<option></option>
									<c:forEach var="item" begin="1" end="6" step="1">
										<option value="${item}">${item} 학년</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-3">반</label>
							<div class="col-9">
								<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="classType" required>
									<option></option>
									<c:forEach var="item" begin="1" end="10" step="1">
										<option value="${item}">${item} 반</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-3">번 호</label>
							<div class="col-9">
								<select data-placeholder="- 선 택 -" class="form-control form-control-select2" name="number" required>
									<option></option>
									<c:forEach var="item" begin="1" end="40" step="1">
										<option value="${item}">${item} 번</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-3">이 름</label>
							<div class="col-9">
								<input type="text" class="form-control" name="name" autocomplete="off" required>
							</div>
						</div>
						<div class="form-group row mb-2">
							<label class="col-form-label col-3">핸드폰</label>
							<div class="col-9 d-flex">
								<select class="form-control select2-size" name="service">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<input type="number" class="form-control ml-2" maxlength="8" name="tel" 
									autocomplete="off" placeholder="'-' 없이 입력하세요." required>
							</div>
						</div>
					</div>
					<div class="card-footer text-center">
						<button type="submit" class="btn bg-teal-600 rounded-round custom-btn mr-2">학생등록</button>
						<a href="${pageContext.request.contextPath}/" class="btn btn-light rounded-round custom-btn">취 소</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<script>


$("#studentRegistForm").submit(function(e) {
	e.preventDefault();
	
	var form = $(this);
    var url = form.attr('action');
    var student = form.serialize();
    
    $.ajax({
		url: contextPath + "/student/search",
		type: "GET",
		data: student,
		success: function(response) {
       		if (response) {
       			swal({title: "등록된 학생 정보입니다.", type: "warning", position: 'top', confirmButtonClass: 'btn btn-warning',})
       		} else {
       			$.ajax({
       				type: "POST",
       	           	url: url,
       	           	data: student,
       	           	success: function(response) {
       	           		location.href = contextPath + "/login";
       	           	},
       	            error: function(response) {
       	            	swal({title: "학생 등록을 실패하였습니다.", type: "error"})
       	            }
       			});
       		}
       	}
	}); 
});
</script>