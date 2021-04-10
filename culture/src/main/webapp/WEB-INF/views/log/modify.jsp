<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">로그 상세</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"><h6>메모만 수정가능합니다.</h6></div>
                            <div class="card-body">
									<form id="mainForm" role="form" action="/log/modify" method="post">
										<input type="hidden" name="lno" value="${log.lno}" />
										<input type="hidden" name="mid" value='<sec:authentication property="principal.username"/>'/>
										<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
										<input type="hidden" name="amount" value="${cri.amount}" />
										<input type="hidden" name="type" value="${cri.type}" />
										<input type="hidden" name="keyword" value="${cri.keyword}" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="kind">종류</label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="R" <c:if test="${log.kind eq 'R'}"><c:out value="checked"/></c:if> disabled>등급
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="B" <c:if test="${log.kind eq 'B'}"><c:out value="checked"/></c:if> disabled>블락
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="E" <c:if test="${log.kind eq 'E'}"><c:out value="checked"/></c:if> disabled>강퇴
														</label>
													</div>	
												</div>																																																							                                            			
                                           </div>
                                           <c:if test="${log.kind eq 'R' }">
	                                           <div class="form-group">
													<label class="small mb-1" for="auth">권한</label>
	                                            	<div id="auth">
		                                            	<div class="form-check-inline">
															<label class="form-check-label">
																<input type="radio" class="form-check-input" name="auth" value="ROLE_USER" <c:if test="${log.auth eq 'ROLE_USER'}"><c:out value="checked"/></c:if> disabled>유저
															</label>
														</div>
		                                            	<div class="form-check-inline">
															<label class="form-check-label">
																<input type="radio" class="form-check-input" name="auth" value="ROLE_MEMBER" <c:if test="${log.auth eq 'ROLE_MEMBER'}"><c:out value="checked"/></c:if> disabled>멤버
															</label>
														</div>
		                                            	<div class="form-check-inline">
															<label class="form-check-label">
																<input type="radio" class="form-check-input" name="auth" value="ROLE_ADMIN" <c:if test="${log.auth eq 'ROLE_ADMIN'}"><c:out value="checked"/></c:if> disabled>관리자
															</label>
														</div>	
													</div>			                                           	
	                                           </div>
                                           </c:if>
                                           <c:if test="${log.kind eq 'B' }">
	                                           <div class="form-group">
	                                                <label class="small mb-1">기간</label>
	                                                <fmt:parseDate value="${log.sdate}" var="sdate" pattern="yyyy-MM-dd"/>
	                                                <fmt:parseDate value="${log.edate}" var="edate" pattern="yyyy-MM-dd"/>
	                                                <input class="form-control py-4 chk" name="sdate" type="date" value="<fmt:formatDate value="${sdate}" pattern="yyyy-MM-dd"/>" readonly/>
	                                                <input class="form-control py-4 chk" name="edate" type="date" value="<fmt:formatDate value="${edate}" pattern="yyyy-MM-dd"/>" readonly/>
	                                           </div>                                              
                                           </c:if>
                                           <div class="form-group">
                                                <label class="small mb-1" for="target">아이디</label>
                                                <input class="form-control py-4 chk" name="target" id="target" type="text" value="${log.target}" readonly/>
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content" readonly>${log.content}</textarea>
											</div>
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="state">상태</label>
                                            	<div id="state">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="0" <c:if test="${log.state eq 0}"><c:out value="checked"/></c:if> disabled>일반
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="1" <c:if test="${log.state eq 1}"><c:out value="checked"/></c:if> disabled>블락
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="2" <c:if test="${log.state eq 2}"><c:out value="checked"/></c:if> disabled>강퇴
														</label>
													</div>	
												</div>																																																							                                            			
                                           </div>	
	                                       <div class="form-group">
												<label class="small mb-1" for="oldauth">기존 권한</label>
	                                            <div id="oldauth">
		                                        	<div class="form-check-inline">
														<label class="form-check-label">
														<input type="radio" class="form-check-input" name="oldauth" value="ROLE_USER" <c:if test="${log.oldauth eq 'ROLE_USER'}"><c:out value="checked"/></c:if> disabled>유저
														</label>
													</div>
		                                            <div class="form-check-inline">
														<label class="form-check-label">
														<input type="radio" class="form-check-input" name="oldauth" value="ROLE_MEMBER" <c:if test="${log.oldauth eq 'ROLE_MEMBER'}"><c:out value="checked"/></c:if> disabled>멤버
														</label>
													</div>
		                                            <div class="form-check-inline">
														<label class="form-check-label">
														<input type="radio" class="form-check-input" name="oldauth" value="ROLE_ADMIN" <c:if test="${log.oldauth eq 'ROLE_ADMIN'}"><c:out value="checked"/></c:if> disabled>관리자
														</label>
													</div>	
												</div>			                                           	
	                                        </div>                                           										
										    <div class="form-group">
                                                <label class="small mb-1" for="reason">메모</label>
                                                <textarea class="form-control" name="reason" rows="5" id="reason">${log.reason}</textarea>
											</div>											
                                            <div class="form-group mt-4 mb-0 text-right">
                                            	<sec:authentication property="principal" var="pinfo"/>
                                             	<sec:authorize access="isAuthenticated()">
                                             		<c:if test="${fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
                                            			<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
                                            		</c:if>
                                            	</sec:authorize>
												<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                            </div>
                              		</form> <!-- form 끝  -->                            
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->            	
<script>

$(document).ready(function(){
	var formObj = $("#mainForm"); 
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	

	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper");
		console.log(oper);
		if(oper === "modify"){
			if(confirm("수정하시겠습니까?")){	
				formObj.submit();
			}
		}else{
			formObj.attr("action", "/log/list").attr("method", "get"); 
			var pageNum = formObj.find("input[name='pageNum']"); 
			var amount = formObj.find("input[name='amount']"); 
			var type = formObj.find("input[name='type']");   
			var keyword = formObj.find("input[name='keyword']"); 
			
			formObj.empty(); 
			formObj.append(pageNum); 
			formObj.append(amount); 
			formObj.append(type);
			formObj.append(keyword);
			formObj.submit();
		}
	});
	
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>