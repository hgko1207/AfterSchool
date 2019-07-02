<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/common/tagLib.jsp"%>

<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/apply.css" rel="stylesheet" type="text/css">

<div class="page-content layout-boxed-bg">
	<div class="content-wrap">
		<c:import url="/WEB-INF/jsp/common/header.jsp" >
	  		<c:param name="header" value="수강신청확인" />
		</c:import>
		
		<c:choose>
			<c:when test="${fn:length(applies) == 0}">
		       	<div class="result-empty">
					수강신청내역이 없습니다.
				</div>
		    </c:when>
		     <c:otherwise>
		     	<div class="card-group-control card-group-control-left" id="accordion-group">
		     		<c:forEach var="apply" items="${applies}" varStatus="status">
		     			<div class="card">
							<div class="card-header bg-light header-elements-inline">
								<h6 class="card-title">
									<a data-toggle="collapse" class="collapsed text-default font-weight-bold" href="#accordion-item-group${apply.id}">
										<c:choose>
											<c:when test="${apply.subject.name == '쉬지말고 롤라타자'}">
										       ${apply.subject.name} <span class="text-danger"> - 재료비 정정</span>
										    </c:when>
										    <c:otherwise>
					    						${apply.subject.name}
					    					</c:otherwise>
										</c:choose>
									</a>
								</h6>
								<div class="header-elements mylist-header">
									<button type="button" class="btn btn-danger btn-sm" onclick="applyCancel(${apply.id})">신청취소</button>
					           	</div>
							</div>
					
							<div id="accordion-item-group${apply.id}" class="collapse" data-parent="#accordion-group">
								<div class="card-body">
									<div>
							    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수강기간 : </label>
							    		<label class="col-form-label">${apply.subject.period}</label>
							    	</div>
							    	<div>
							    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>수업일시 : </label>
							    		<label class="col-form-label">${apply.subject.week} (${apply.subject.time})</label>
							    	</div>
							    	<div>
							    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>대상학년 : </label>
							    		<label class="col-form-label">${apply.subject.target}</label>
							    	</div>
							    	<div>
							    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>재료,교구비 : </label>
							    		<label class="col-form-label">
							    			<c:choose>
												<c:when test="${apply.subject.name == '쉬지말고 롤라타자'}">
											       <span class="text-danger">재료 교구비 8만원(수익자 부담-롤러스케이트,보호장비) 원하는 학생만 구매</span>
											    </c:when>
											    <c:otherwise>
						    						${apply.subject.costDesc}
						    					</c:otherwise>
											</c:choose>
							    		</label>
							    	</div>
							    	<div>
							    		<label class="col-form-label text-primary font-weight-bold"><i class="icon-arrow-right13 mr-1"></i>강사이름 : </label>
							    		<label class="col-form-label">${apply.subject.teacher}</label>
							    	</div>
							    	<div class="align-items-stretch">
							    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>수업장소 : </label>
							    		<label class="col-form-label ml-xs-3">${apply.subject.location}</label>
							    	</div>
							    	<div class="align-items-stretch">
							    		<label class="col-form-label text-primary font-weight-bold pb-0"><i class="icon-arrow-right13 mr-1"></i>과목특징 : </label>
							    		<label class="col-form-label ml-xs-3 pb-0">${apply.subject.description}</label>
							    	</div>
								</div>
							</div> 
						</div>
		     		</c:forEach>
				</div>
		     </c:otherwise>
		</c:choose>
		<!-- <div class="mylist-result">
			<ul class="text-right">
				<li>(예상)신청총액 : ₩65,000</li>
				<li class="advice">교재/재료비에 따라 신청총액이 증감될 수 있습니다.</li>
			</ul>
		</div> -->
	</div>
</div>

<script>
var agent = navigator.userAgent.toLowerCase();

function applyCancel(applyId) {
	if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
		console.log("인터넷 익스플로러 브라우저 입니다.");
	 	var check = confirm("수강취소 하시겠습니까?");
	 	if (check) {
	 		$.ajax({
	    		url: contextPath + "/apply/delete",
	      		data: {"applyId": applyId},
	      		type: "DELETE",
	           	success: function(response) {
	           		alert("수강 취소 되었습니다.");
	           		location.href = "mylist";
	           	},
	            error: function(response) {
	            	alert(response.responseText);
	            }
	    	});
	 	}
	} else {
		console.log("인터넷 익스플로러 브라우저가 아닙니다.");
		swal({
	        title: "수강취소 하시겠습니까?",
	        type: "question",
	        confirmButtonText: "확인",
	        confirmButtonClass: "btn btn-danger",
	        showCancelButton: true, 
	        cancelButtonText: "닫기",
	        position: "top"
	    }).then(function(e) {
	    	if (e.value) {
	    		$.ajax({
		    		url: contextPath + "/apply/delete",
		      		data: {"applyId": applyId},
		      		type: "DELETE",
		           	success: function(response) {
		           		swal({
		       				title: "수강 취소 되었습니다.", 
		       				type: "success",
		       				position: 'top'
		       			}).then(function(e) {
		       				location.href = "mylist";
		       			});
		           	},
		            error: function(response) {
		            	swal({title: response.responseText, type: "error", position: 'top'})
		            }
		    	});
	    	}
	    });
	}
}
</script>