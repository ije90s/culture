<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>     
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">신고 수정</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"><h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6></div>
                            <div class="card-body">
                            		<sec:authentication property="principal" var="pinfo"/>
									<form id="mainForm" role="form" action="/report/modify" method="post">
										<input type="hidden" name="rno" value="${report.rno}" />
										<input type="hidden" name="mid" value="<sec:authentication property="principal.username"/>" />
										<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
										<input type="hidden" name="amount" value="${cri.amount}" />
										<input type="hidden" name="type" value="${cri.type}" />
										<input type="hidden" name="keyword" value="${cri.keyword}" />
										<input type="hidden" name="tab" value="${tab}" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<div class="form-group">
                                                <label class="small mb-1" for="title">제목<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4 chk" name="title" id="title" type="text" value="${report.title}" <c:if test="${fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}"><c:out value="readonly"/></c:if>/>
                                            	<small></small>
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="content">내용<medium class="invalid">*</medium></label>
                                                <textarea class="form-control chk" name="content" rows="5" id="content" <c:if test="${fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}"><c:out value="readonly"/></c:if>>${report.content}</textarea>
												<small></small>
											</div>
											<div class="form-group">
                                                <label class="small mb-1" for="reporter">신고자</label>
                                                <input class="form-control py-4" name="reporter" id="reporter" type="text" value="${report.reporter}" readonly/>
                                            </div>
                                            <c:if test="${fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
                                            <div class="form-group">                                            	
                                            	<label class="small mb-1" for="state">상태</label>
                                            	<div id="state">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="0" <c:if test="${report.state eq '0'}">checked</c:if>>처리중
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="1" <c:if test="${report.state eq '1'}">checked</c:if>>완료
														</label>
													</div>
												    <div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="2" <c:if test="${report.state eq '2'}">checked</c:if>>미처리
														</label>
													</div>
												</div>																																																							                                            			
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="reason">메모</label>
                                                <textarea class="form-control" name="reason" rows="5" id="reason">${report.reason}</textarea>
											</div>
											</c:if>
											<c:if test="${fn:contains(pinfo.member.authList, 'ROLE_MEMBER')}">
												<input type="hidden" name="state" value="${report.state}" />
												<input type="hidden" name="reason" value="${report.reason}" />
											</c:if>
                                            <div class="form-group mt-4 mb-0 text-right">
	                                			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
	                                				<c:if test="${pinfo.username eq report.reporter || fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
                                            			<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
                                            		</c:if>
                                            	</sec:authorize>
												<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                            </div>
                              		</form> <!-- form 끝  -->                            
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->
<script src="/resources/scripts/common.js"></script>                	   
<script src="/resources/scripts/report.js"></script>             	
<script>
$(document).ready(function(){
	var formObj = $("#mainForm"); 
	var auth = null; 
	var object = '<sec:authentication property="principal.username"/>'; 
	<sec:authorize access="isAuthenticated()">
		auth = '<sec:authentication property="principal.member.authList" />';
	</sec:authorize>
	if(auth.includes("ADMIN")) object = "all";

	$(".chk").blur(function(e){
		reportService.validate($(this)); 
	});
	hasErrors();

	//서버에서 받아온 error 검사
	function hasErrors(){
		<spring:hasBindErrors name="report">
		$(".chk").each(function(){
			reportService.validate($(this));	
		}); 
		</spring:hasBindErrors>			
	}		
	
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper");
		console.log(oper);
		if(oper === "modify"){
			
			$(".chk").each(function(){
				reportService.validate($(this));	
			}); 
	
			 if(!checkItem($("input[name='title']"))) return false;		
			 if(!checkItem($("#content"))) return false;
			 
			 
			if(confirm("수정하시겠습니까?")){	
				formObj.append("<input type='hidden' name='object' value='"+object+"' />");
				formObj.submit();
			}
		}else{
			formObj.attr("action", "/report/list/"+object).attr("method", "get"); 
			var pageNum = $("input[name='pageNum']").clone(); 
			var amount = $("input[name='amount']").clone(); 
			var type = formObj.find("input[name='type']");
			var keyword = formObj.find("input[name='keyword']");
			var tab = formObj.find("input[name='tab']");
			formObj.empty(); 
			formObj.append(pageNum); 
			formObj.append(amount); 
			formObj.append(type);
			formObj.append(keyword);
			formObj.append(tab);
			formObj.submit();
		}
	});
		
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>