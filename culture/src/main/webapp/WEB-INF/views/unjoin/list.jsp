<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<%@ include file="../includes/header.jsp"  %>
					<div class="container-fluid">
                        <h3 class="mt-4">탈퇴리스트</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">
                                <div class="table-responsive">
									<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<td>NO.</td>
											<td>아이디</td>
											<td>구분</td>
											<td>등록일</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="list">
										<tr>
											<td>${list.rn}</td>
											<td>
												<a class="move" href="${list.uno}">${list.id}</a>												
											</td>
											<td><c:if test="${list.reason eq '1'}">서비스 불만족</c:if>
		                                		<c:if test="${list.reason eq '2'}">쓰기 불편</c:if>
		                                		<c:if test="${list.reason eq '3'}">개인 불만족</c:if>
		                                		<c:if test="${list.reason eq '4'}">사용 자주 하지 않음</c:if>
		                                		<c:if test="${list.reason eq '5'}">기타</c:if></td>
											<td><fmt:formatDate value="${list.rdate}" pattern="yyyy-MM-dd"/></td>
										</tr>
										</c:forEach>
									</tbody>
									</table> <!-- table 끝 -->
								 </div> <!-- table-responsive 끝  -->           
								 
								 <div class="float-right"> <!-- paging 처리 -->
                                  <ul class="pagination">
                                  	<c:if test="${page.pre}">
                                  		<li class="page-item"><a class="page-link" href="${page.start-1}">Previous</a></li>
                                  	</c:if>
                                  	
								    <c:forEach var="num" begin="${page.start}" end="${page.end}">
								    	<li class='page-item ${page.cri.pageNum eq num? "active":""}'><a class='page-link' href="${num}">${num}</a></li>
								    </c:forEach>
								    
								    <c:if test="${page.next}">
								    	<li class="page-item"><a class="page-link" href="${page.end+1}">Next</a></li>
								    </c:if>
  								  </ul>
                                </div> <!-- paging 처리 끝 -->      
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->   
<form id="listForm" method="get">
	<input type="hidden" name="pageNum" value="${page.cri.pageNum }"/>
	<input type="hidden" name="amount" value="${page.cri.amount }"/>
</form> 
<script>
$(document).ready(function(){
	
	var form = $("#listForm"); 
	$(".move").click(function(e){
		e.preventDefault();
		var uno = $(this).attr("href");
		form.append("<input type='hidden' name='uno' value='"+uno+"'/>");
		form.attr("action", "/unjoin/get").submit();
	}); 
	 
	$(".page-link").click(function(e){
		e.preventDefault(); 
		var selectedPageNum = $(this).attr("href"); 
		form.find("input[name='pageNum']").val(selectedPageNum);
		form.attr("action", "/unjoin/list").submit();
	});	
});
</script>                	
<%@ include file="../includes/footer.jsp"  %>