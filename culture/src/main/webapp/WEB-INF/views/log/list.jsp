<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<%@ include file="../includes/header.jsp"  %>
					<div class="container-fluid">
                        <h3 class="mt-4">로그리스트</h3>
                        <div class="card mb-4">
                            <div class="card-header">
                                 <form id="searchForm" action="/log/list" method="get">
                                 <input type="hidden" name="pageNum" value='<c:out value="${page.cri.pageNum }"/>' />
								 <input type="hidden" name="amount" value='<c:out value="${page.cri.amount }"/>' />
								 <div class="input-group">
                                	<select name="type" class="custom-select" style="flex:none; width:200px;">
                                	<option value="" <c:out value="${page.cri.type==null?'selected':''}"/>>선택</option>
                                	<option value="T" <c:out value="${page.cri.type eq 'T'?'selected':''}"/>>아이디</option>
                                	</select>
                                	<div class="input-group-prepend"><input type="text" name="keyword" class="form-control" value='<c:out value="${page.cri.keyword}"/>' /></div>  	
									<div class="input-group-prepend"><button class="btn btn-primary" data-oper="search">검색</button></div>
								</div>	
                                </form>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
									<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>							
											<td>아이디</td>
											<td>건수</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="list">
										<tr>
											<td>
												<a class="move" href="${list.target}">${list.target}</a>												
											</td>
											<td>${list.cnt}</td>
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
	<input type="hidden" name="type" value="${page.cri.type }"/>
	<input type="hidden" name="keyword" value="${page.cri.keyword }"/>
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
	
	var form = $("#listForm"); 
	$(".move").click(function(e){
		e.preventDefault();
		var target = $(this).attr("href");
		form.append("<input type='hidden' name='target' value='"+target+"'/>");
		form.append("<input type='hidden' name='subPage' value='1'/>");
		form.attr("action", "/log/get").submit();
	}); 
	 
	$(".page-link").click(function(e){
		e.preventDefault(); 
		var selectedPageNum = $(this).attr("href"); 
		form.find("input[name='pageNum']").val(selectedPageNum);
		form.attr("action", "/log/list").submit();
	});	
	
	var search = $("#searchForm"); 
	$(".btn").on("click", function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper"); 
		if(oper == "search"){
			if(!search.find("option:selected").val()){
				alert("종류를 선택하세요."); 
				return false; 
			}
				
			if(!search.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요."); 
				return false; 
			}
			search.find("input[name='pageNum']").val("1");
			search.attr("action", "/log/list").submit();							
		}		
	});	
});
</script>                	
<%@ include file="../includes/footer.jsp"  %>