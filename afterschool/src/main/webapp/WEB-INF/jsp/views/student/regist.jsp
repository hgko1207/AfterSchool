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
						<div class="form-group row">
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
						
						<fieldset class="mb-0">
							<legend class="text-uppercase font-weight-bold">개인정보제공 동의</legend>
							<label class="text-grey-600">학생보험 가입 시 필요한 개인정보제공에 동의를<br>해 주셔야 가입이 가능합니다.<br>보험가입목적 외에는 절대 사용하지 않습니다.</label>
							<div class="form-check mt-2">
								<label class="form-check-label">
									<input id="agreeCheck" type="checkbox" name="agree" class="form-check-input-styled" data-fouc>
									보험가입에 필요한 개인정보를 보험사에<br>제공하는 것에 동의합니다.
								</label>
							</div>
							<div id="residentNumberInput" class="form-group mt-2 d-none">
								<label class="font-weight-bold">학생주민등록번호 입력 :</label>
								<div class="d-flex align-items-center">
									<input type="text" class="form-control format-jumin1" id="jumin1" name="jumin1">
									<span class="font-weight-bold mx-2">-</span>
									<input type="password" class="form-control format-jumin2" id="jumin2" name="jumin2">
								</div>
							</div>
						</fieldset>
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
	
	if ($("#agreeCheck").is(":checked")) {
		if ($("#jumin1").val() == '' || $("#jumin2").val() == '') {
			$("#jumin1").focus();
			return;
		}
		
		if (!validate()) {
			swal({title: "올바른 주민번호가 아닙니다.", type: "warning", position: 'top'});
			return;
		}
	}
	
	var form = $(this);
    var url = form.attr('action');
    var student = form.serialize();
    
    $.ajax({
		url: contextPath + "/student/search",
		type: "GET",
		data: student,
		success: function(response) {
       		if (response) {
       			swal({title: "이미 등록된 학생 정보입니다.", type: "warning", position: 'top', confirmButtonClass: 'btn btn-warning',})
       		} else {
       			$.ajax({
       				type: "POST",
       	           	url: url,
       	           	data: student,
       	           	success: function(response) {
       	           		location.href = contextPath + "/login";
       	           	},
       	            error: function(response) {
       	            	swal({title: "학생 등록을 실패하였습니다.", type: "error", position: 'top'})
       	            }
       			});
       		}
       	}
	});
});

$("#agreeCheck").click(function(){
    if ($(this).is(':checked')){
    	$("#residentNumberInput").removeClass("d-none");
    } else {
    	$("#residentNumberInput").addClass("d-none");
    }
});

function validate() {
    var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
    var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    // 이메일이 적합한지 검사할 정규식

    var num1 = document.getElementById("jumin1");
    var num2 = document.getElementById("jumin2");

    var arrNum1 = new Array(); // 주민번호 앞자리숫자 6개를 담을 배열
    var arrNum2 = new Array(); // 주민번호 뒷자리숫자 7개를 담을 배열

    // -------------- 주민번호 -------------

    for (var i=0; i<num1.value.length; i++) {
        arrNum1[i] = num1.value.charAt(i);
    } // 주민번호 앞자리를 배열에 순서대로 담는다.

    for (var i=0; i<num2.value.length; i++) {
        arrNum2[i] = num2.value.charAt(i);
    } // 주민번호 뒷자리를 배열에 순서대로 담는다.

    var tempSum = 0;

    for (var i=0; i<num1.value.length; i++) {
        tempSum += arrNum1[i] * (2+i);
    } // 주민번호 검사방법을 적용하여 앞 번호를 모두 계산하여 더함

    for (var i=0; i<num2.value.length-1; i++) {
        if (i>=2) {
            tempSum += arrNum2[i] * i;
        }
        else {
            tempSum += arrNum2[i] * (8+i);
        }
    } // 같은방식으로 앞 번호 계산한것의 합에 뒷번호 계산한것을 모두 더함

    if ((11-(tempSum%11))%10!=arrNum2[6]) {
        //alert("올바른 주민번호가 아닙니다.");
        num1.value = "";
        num2.value = "";
        num1.focus();
        return false;
    } else{
    	//alert("올바른 주민등록번호 입니다.");
    	return true;
    }
}
</script>