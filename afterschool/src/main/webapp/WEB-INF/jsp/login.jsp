<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" />
	<title>방과후학교 관리시스템</title>
	
	<c:set var="contextName">${pageContext.request.contextPath}</c:set>
	
	<!-- Global stylesheets -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="${contextName}/limitless/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="${contextName}/limitless/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${contextName}/limitless/css/bootstrap_limitless.min.css" rel="stylesheet" type="text/css">
	<link href="${contextName}/limitless/css/layout.min.css" rel="stylesheet" type="text/css">
	<link href="${contextName}/limitless/css/components.min.css" rel="stylesheet" type="text/css">
	<link href="${contextName}/limitless/css/colors.min.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->
	
	<link href="${contextName}/css/common.css" rel="stylesheet" type="text/css">
	
	<!-- Core JS files -->
	<script src="${contextName}/limitless/js/main/jquery.min.js"></script>
	<script src="${contextName}/limitless/js/main/bootstrap.bundle.min.js"></script>
	<script src="${contextName}/limitless/js/plugins/loaders/blockui.min.js"></script>
	<!-- Core JS files -->
	
	<!-- Theme JS files -->
	<script src="${contextName}/limitless/js/plugins/forms/validation/validate.min.js"></script>
	<script src="${contextName}/limitless/js/plugins/forms/styling/uniform.min.js"></script>
	
	<script src="${contextName}/limitless/js/app.js"></script>
	<!-- /theme JS files -->
	
	<script src="${contextName}/js/login.js"></script>
</head>
<body>
	<div class="navbar navbar-expand-md navbar-dark">
		<div class="navbar-brand">
			<a href="/" class="d-inline-block">
				<span><i class="icon-shutter mr-2"></i>캠퍼스 형 방과후학교</span>
			</a>
		</div>
	</div>
	<div class="page-content">
		<div class="content-wrapper">
			<div class="content d-flex justify-content-center align-items-center">
				<form class="login-form form-validate" action="${pageContext.request.contextPath}/login" method="POST"> 
					<div class="card mb-0">
						<div class="card-body">
							<div class="text-center mt-2 mb-4">
								<i class="icon-reading icon-2x text-slate-300 border-slate-300 border-3 rounded-round p-3 mb-2 mt-1"></i>
								<h3 class="mb-1">로그인</h3>
								<span class="d-block text-muted">학생 이름과 학부모 전화번호를 입력하세요.</span>
							</div>
							
							<c:if test="${not empty error}">
								<div class="alert alert-danger border-0 alert-dismissible">
									<button type="button" class="close" data-dismiss="alert"><span>×</span></button>
									<span class="font-weight-semibold">학생 정보가 일치하지 않습니다.</span>
							    </div>
							</c:if>
							
							<div class="form-group form-group-feedback form-group-feedback-left">
								<input type="text" class="form-control" placeholder="학생 이름" autocomplete="off" value="${username}" name="username" required>
								<div class="form-control-feedback">
									<i class="icon-user text-muted"></i>
								</div>
							</div>
							
							<div class="form-group form-group-feedback form-group-feedback-left">
								<input type="number" class="form-control" placeholder="'-' 없이 입력하세요." autocomplete="off" name="password" required>
								<div class="form-control-feedback">
									<i class="icon-phone2 text-muted"></i>
								</div>
							</div>

							<div class="form-group">
								<button type="submit" class="btn btn-primary btn-block">로그인<i class="icon-circle-right2 ml-2"></i></button>
							</div>
							
							<div class="form-group text-center text-muted content-divider">
								<span class="px-2">학생이 등록 되지 않았습니까?</span>
							</div>

							<div class="form-group">
								<a href="${pageContext.request.contextPath}/student/regist" class="btn bg-grey btn-block">
									학생등록<i class="icon-circle-right2 ml-2"></i>
								</a>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>