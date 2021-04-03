<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header2.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">신고 수정</h3>
                        <div class="card mb-4">
                            <div class="card-header"><h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6></div>
                            <div class="card-body">
									<form id="mainForm" role="form" action="/report/modify" method="post">
										<input type="hidden" name="rno" value="${report.rno}" />
										<input type="hidden" name="mid" value="admin90" />
										<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
										<input type="hidden" name="amount" value="${cri.amount}" />
										<input type="hidden" name="type" value="${cri.type}" />
										<input type="hidden" name="keyword" value="${cri.keyword}" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<div class="form-group">
                                                <label class="small mb-1" for="title">제목</label>
                                                <input class="form-control py-4" name="title" id="title" type="text" value="${report.title}" readonly/>
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content" readonly>${report.content}</textarea>
											</div>
											<div class="form-group">
                                                <label class="small mb-1" for="reporter">신고자</label>
                                                <input class="form-control py-4" name="reporter" id="reporter" type="text" value="${report.reporter}" readonly/>
                                            </div>
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
                                            <div class="form-group mt-4 mb-0 text-right">
                                            	<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
												<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                            </div>
                              		</form> <!-- form 끝  -->                            
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->   
             	
<script>
$(document).ready(function(){
	var formObj = $("#mainForm"); 
	
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper");
		console.log(oper);
		if(oper === "modify"){
			if(confirm("수정하시겠습니까?")){	
				formObj.submit();
			}
		}else{
			formObj.attr("action", "/report/list").attr("method", "get"); 
			var pageNum = $("input[name='pageNum']").clone(); 
			var amount = $("input[name='amount']").clone(); 
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