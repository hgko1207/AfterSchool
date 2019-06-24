<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/applyInfo.css" rel="stylesheet" type="text/css">

<div class="navbar navbar-expand-md navbar-dark">
	<div class="navbar-brand">
		<a href="/" class="d-inline-block">
			<span><i class="icon-shutter mr-2"></i>방과후학교 수강신청</span>
		</a>
	</div>
</div>

<div class="page-content">
	<div class="content-wrapper">
		<div class="content d-flex justify-content-center align-items-center">
			<form class="login-form"> 
				<div class="card mb-0">
					<div class="card-header">
						<h2>
							2019년도 01 신청안내
					    </h2>
					</div>
					<div class="card-body apply-content">
				    	<div>
				    		<label class="col-form-label text_bold">학생명 : </label>
				    		<label class="col-form-label">${name}&nbsp;&nbsp;&nbsp;&nbsp;${student}</label>
				    	</div>
				    	<div>
				    		<label class="col-form-label text_bold">신청기간 : </label>
				    		<label class="col-form-label apply-peirod">2019-06-01 00시 ~ 2020-02-27 00시</label>
				    	</div>
					</div>
					<div class="card-footer text-center">
						<a href="subscribe" class="btn bg-primary-700 rounded-round custom-btn apply-btn">수강신청하기</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>