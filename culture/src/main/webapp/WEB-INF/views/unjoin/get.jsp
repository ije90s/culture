<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="../includes/header.jsp"  %>
					<div class="container-fluid">
                        <h3 class="mt-4">탈퇴 상세</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">      
                           		<div class="form-group">
                                	<label class="small mb-1" for="id">아이디</label>
                                    <input class="form-control py-4" id="id" type="text" value='${unjoin.id}' readonly/>
                                </div>                       
                                <div class="form-group">
                                	<label class="small mb-1" for="reason">탈퇴사유</label>
                                	<div id="reason">
                                		<c:if test="${unjoin.reason eq '1'}">서비스 불만족</c:if>
                                		<c:if test="${unjoin.reason eq '2'}">쓰기 불편</c:if>
                                		<c:if test="${unjoin.reason eq '3'}">개인 불만족</c:if>
                                		<c:if test="${unjoin.reason eq '4'}">사용 자주 하지 않음</c:if>
                                		<c:if test="${unjoin.reason eq '5'}">기타</c:if>
                                	</div>        																																																							                                            			
                                </div>
                                <div class="form-group">
                                    <label class="small mb-1" for="content">내용</label>
                                    <textarea class="form-control" name="content" rows="5" id="content" readonly>${member.memo}</textarea>
								</div>																                                                                                                                                                                                             
                                <div class="form-group mt-4 mb-0 text-right">
									<button type="button" class="btn btn-secondary" data-oper="list">목록</button>
                                </div>                  				
                            </div> <!-- card-body 끝  -->           
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->            	 
<form id="mainFrom" role="form" method="get">
	<input type="hidden" name="uno" value="${unjoin.uno}" />
	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
	<input type="hidden" name="amount" value="${cri.amount}" />
</form>  
<script>
$(document).ready(function(){
	var form = $("#mainFrom"); 
	var uno = '<c:out value="${unjoin.uno}"/>';
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper=$(this).data("oper");
		
		if(oper=="list"){
			form.find("input[name='uno']").remove();
			form.attr("action", "/unjoin/list").submit();
		}
	});	
});
</script>       
<%@ include file="../includes/footer.jsp"  %>