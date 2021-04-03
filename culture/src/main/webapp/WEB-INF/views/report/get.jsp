<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ include file="../includes/header2.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">신고 상세</h3>
                        <div class="card mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">
                                           <div class="form-group">
                                                <label class="small mb-1" for="title">제목</label>
                                                <input class="form-control py-4" name="title" id="title" type="text" value="${report.title}"  readonly/>
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
															<input type="radio" class="form-check-input" name="state" value="0" <c:if test="${report.state eq '0'}"><c:out value="checked"/></c:if> disabled>처리중
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="1" <c:if test="${report.state eq '1'}"><c:out value="checked"/></c:if> disabled>완료
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="state" value="2" <c:if test="${report.state eq '2'}"><c:out value="checked"/></c:if> disabled>미처리
														</label>
													</div>													
												</div>																																																							                                            			
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="reason">메모</label>
                                                <textarea class="form-control" name="reason" rows="5" id="reason" readonly>${report.reason}</textarea>
											</div> 
                                            <div class="form-group mt-4 mb-0 text-right">
	                                        	<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
	                                            <button type="button" class="btn btn-danger" data-oper="remove">삭제</button>
	                                            <button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
	                                            <button type="button" class="btn btn-info" data-oper="search"><i class="fa fa-search"></i></button>
                                            </div>                       
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->              	               	
 <form id="mainForm" role="form" method="post">
 	<input type="hidden" id="rno" name="rno" value="${report.rno}" />
 	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
 	<input type="hidden" name="amount" value="${cri.amount}" />
 	<input type="hidden" name="type" value="${cri.type }"/>
 	<input type="hidden" name="keyword" value="${cri.keyword }" />
 </form>   
 <script>
 $(document).ready(function(){
	 
	 var formObj = $("#mainForm"); 
	 $(".btn").on("click",function(e){
		 e.preventDefault(); 
		 var oper = $(this).data("oper"); 
		 //console.log(oper);
		 if(oper === "modify"){
			 formObj.attr("action", "/report/modify").attr("method", "get").submit();
		 }else if(oper === "remove"){
			 formObj.append('<input type="hidden" id="${_csrf.parameterName}" name="${_csrf.parameterName}" value="${_csrf.token}" />');
			 formObj.attr("action", "/report/remove").submit();
		 }else if(oper === "list"){
			 formObj.find("#rno").remove();
			 formObj.attr("action", "/report/list").attr("method","get").submit();
		 }else if(oper == "search"){
			 var kind = '<c:out value="${report.kind}"/>';
			 var no = '<c:out value="${report.no}"/>';
			 var href; 
			 if(kind=="culture"){href="/culture/get?cno="+no; }
			 else{href="/board/get?bno="+no; }
			 window.open(href, '_blank'); 
		 } 
	 });	
 });
 </script>               	
<%@ include file="../includes/footer.jsp"  %>