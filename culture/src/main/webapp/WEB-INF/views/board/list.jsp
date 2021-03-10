<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">게시판</h1>
                        <div class="card mb-4">
                            <div class="card-header">
                                <button id="regBtn" class="btn btn-secondary float-right">등록</button>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
									<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<td>NO.</td>
											<td>제목</td>
											<td>작성자</td>
											<td>등록일</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="list">
										<tr>
											<td>${list.bno}</td>
											<td><a class="move" href="${list.bno}">${list.title}</a></td>
											<td>${list.writer}</td>
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
								    
								    <c:if test="">
								    	<li class="page-item"><a class="page-link" href="${page.end+1}">Next</a></li>
								    </c:if>
  								  </ul>
                                </div> <!-- paging 처리 끝 -->      
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->   
                	
<form action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${page.cri.pageNum }"/>
	<input type="hidden" name="amount" value="${page.cri.amount }"/>
</form>                	
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">처리결과</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
     	 정상적으로 처리되었습니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->                    	
                	
<script>
$(document).ready(function(){
	
	var result = '<c:out value="${result}"/>'; 
	
	checkModal(result); 
	history.replaceState({}, null, null);
	
	//모달창
	function checkModal(result){
		if(result === '' || history.state){
			return; 
		}
		$("#myModal").modal("show");
	}
	

	$("#regBtn").click(function(){
		self.location="/board/register";
	});
	
	var form = $("form");
	$(".move").click(function(e){
		e.preventDefault();
		var bno = $(this).attr("href");
		console.log(bno);
		form.append("<input type='hidden' name='bno' value='"+bno+"'/>");
		form.attr("action", "/board/get").submit();
	}); 
	
	 
	$(".page-link").click(function(e){
		e.preventDefault(); 
		var selectedPageNum = $(this).attr("href"); 
		form.find("input[name='pageNum']").val(selectedPageNum);
		form.submit();
	});
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>