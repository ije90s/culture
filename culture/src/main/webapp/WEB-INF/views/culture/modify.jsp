<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">나의 기록 수정</h1>
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-check-circle"></i> 자유롭게 수정하세요</div>
                            <div class="card-body">
									<form role="form" action="/culture/modify" method="post">
										<input type="hidden" name="cno" value="${culture.cno }" />
										<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
										<input type="hidden" name="amount" value="${cri.amount}" />
									        <div class="form-group">
                                                <label class="small mb-1" for="cdate">날짜</label>
                                                <input class="form-control py-4" name="cdate" id="cdate" type="date" value='<fmt:formatDate value="${culture.cdate}" pattern="yyyy-MM-dd"/>'/>
                                            </div>
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="kind">종류</label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="1" <c:if test="${culture.kind eq 1}"><c:out value="checked"/></c:if>>공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="2" <c:if test="${culture.kind eq 2}"><c:out value="checked"/></c:if>>영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="3" <c:if test="${culture.kind eq 3}"><c:out value="checked"/></c:if>>독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="4" <c:if test="${culture.kind eq 4}"><c:out value="checked"/></c:if>>관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="5" <c:if test="${culture.kind eq 5}"><c:out value="checked"/></c:if>>스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="6" <c:if test="${culture.kind eq 6}"><c:out value="checked"/></c:if>>기타
														</label>
													</div>
												</div>																																																							                                            			
                                            </div>
                                           <div class="form-group">
                                                <label class="small mb-1" for="title">제목</label>
                                                <input class="form-control py-4" name="title" id="title" type="text" value="${culture.title}"/>
                                            </div>
                                            <div class="form-group">
                                            	<label class="small mb-1" for="rank">평점</label>
                                            	<div id="rank">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="1" <c:if test="${culture.rank eq 1}"><c:out value="checked"/></c:if>>1점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="2" <c:if test="${culture.rank eq 2}"><c:out value="checked"/></c:if>>2점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="3" <c:if test="${culture.rank eq 3}"><c:out value="checked"/></c:if>>3점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="4" <c:if test="${culture.rank eq 4}"><c:out value="checked"/></c:if>>4점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="5" <c:if test="${culture.rank eq 5}"><c:out value="checked"/></c:if>>5점
														</label>
													</div>	
												</div>																																																							                                            			
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content">${culture.content}</textarea>
											</div>
											<div class="form-group">
												<label class="small mb-1">사진첨부</label>
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
	var formObj = $("form"); 
	
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper");
		console.log(oper);
		if(oper === "modify"){
			if(confirm("수정하시겠습니까?")){
				formObj.submit();
			}
		}else{
			formObj.attr("action", "/culture/list").attr("method", "get"); 
			var pageNum = $("input[name='pageNum']").clone(); 
			var amount = $("input[name='amount']").clone(); 
			
			formObj.empty(); 
			formObj.append(pageNum); 
			formObj.append(amount); 
			formObj.submit();
		}
	});
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>