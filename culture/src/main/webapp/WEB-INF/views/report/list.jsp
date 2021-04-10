<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">신고리스트 <div class="btn-group float-right" role="group">
                       				<button type="button" class="btn btn-outline-primary  <c:if test="${tab eq 'all'}"><c:out value="active"/></c:if>" data-oper="all">전체</button>
		                         	<button type="button" class="btn btn-outline-primary <c:if test="${tab eq 'ing'}"><c:out value="active"/></c:if>" data-oper="ing">처리중</button>
		  							<button type="button" class="btn btn-outline-primary <c:if test="${tab eq 'done'}"><c:out value="active"/></c:if>" data-oper="done">완료</button>
		  							<button type="button" class="btn btn-outline-primary <c:if test="${tab eq 'no'}"><c:out value="active"/></c:if>" data-oper="no">미처리</button>
		                        </div></h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header">
                                <form id="searchForm" method="get">
                                	<input type="hidden" name="pageNum" value='<c:out value="${page.cri.pageNum }"/>' />
									<input type="hidden" name="amount" value='<c:out value="${page.cri.amount }"/>' />
									<input type="hidden" name="tab" value='<c:out value="${tab}" />' />
									
                                	<div class="input-group">
	                                	<select name="type" class="custom-select" style="flex:none; width:120px;">
	                                	<option value="" <c:out value="${page.cri.type==null?'selected':''}"/>>선택</option>
	                                	<option value="T" <c:out value="${page.cri.type eq 'T'?'selected':''}"/>>제목</option>
	                                	<option value="C" <c:out value="${page.cri.type eq 'C'?'selected':''}"/>>내용</option>
	                                	<option value="R" <c:out value="${page.cri.type eq 'R'?'selected':''}"/>>신고자</option>
	                                	<option value="TC" <c:out value="${page.cri.type eq 'TC'?'selected':''}"/>>제목+내용</option>
	                                	<option value="TR" <c:out value="${page.cri.type eq 'TR'?'selected':''}"/>>제목+신고자</option>
	                                	<option value="CR" <c:out value="${page.cri.type eq 'CR'?'selected':''}"/>>내용+신고자</option>
	                                	<option value="TCR" <c:out value="${page.cri.type eq 'TCR'?'selected':''}"/>>제목+내용+신고자</option>
	                                	</select>
	                                	<div class="input-group-prepend"><input type="text" name="keyword" class="form-control" value='<c:out value="${page.cri.keyword}"/>' /></div>
										<div class="input-group-prepend"><button class="btn btn-primary" data-oper="search">검색</button></div>
										<div class="input-group-prepend"><button type="button" class="btn btn-success" data-oper="back">초기화</button></div>		
									</div>
                                </form>	
                               			                  
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>NO.</th>
                                                <th>제목</th>
                                                <th>신고자</th>
                                                <th>상태</th>
                                                <th>등록일</th>
                                            </tr>
                                        </thead>
     									<tbody>
     									<c:forEach var="report" items="${list}">     	
     										<tr>										
     											<td>${report.rno}</td>
     											<td><a class="move" href="${report.rno}">${report.title}</a></td>
     											<td>${report.reporter}</td>
     											<td>
     												<c:if test="${report.state eq '0'}">처리중</c:if> 
     												<c:if test="${report.state eq '1'}">완료</c:if> 
     												<c:if test="${report.state eq '2'}">미처리</c:if> 
     											</td>
     											<td><fmt:formatDate value="${report.rdate}" pattern="yyyy-MM-dd"/></td>
     										</tr>
     									</c:forEach>
                                        </tbody>
                                    </table>  <!-- table 끝  -->
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
<!-- form -->
<form id="listForm" role="form"  method="get">
	<input type="hidden" name="pageNum" value="${page.cri.pageNum }" />
	<input type="hidden" name="amount" value="${page.cri.amount }" />
	<input type="hidden" name="type" value="${page.cri.type }" />
	<input type="hidden" name="keyword" value="${page.cri.keyword }" />
	<input type="hidden" name="tab" value="${tab}" />
</form>
<!-- form 끝 -->                        
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
<script type="text/javascript">
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	var form = $("#listForm"); 
	
	var auth = null; 
	var object = '<sec:authentication property="principal.username"/>'; 
	<sec:authorize access="isAuthenticated()">
		auth = '<sec:authentication property="principal.member.authList" />';
	</sec:authorize>
	
	if(auth.includes("ADMIN")) object = "all";
	
	checkModal(result); 
	history.replaceState({}, null, null);
	
	//모달창
	function checkModal(result){
		if(result === '' || history.state){
			return; 
		}
		$("#myModal").modal("show");
	}
	
	
	
	//페이징
	$("ul.pagination li.page-item a").on("click", function(e){
		e.preventDefault(); 
		
		console.log("click");
	
		form.find("input[name='pageNum']").val($(this).attr("href"));
		form.attr("action", "/report/list/"+object).submit();
	});
	
	//상세페이지 이동
	$(".move").click(function(e){
		e.preventDefault(); 
		form.append("<input type='hidden' name='rno' value='"+$(this).attr("href")+"'>"); 
		form.attr("action", "/report/get").submit();
	});

	var search = $("#searchForm"); 
	$(".btn").click(function(e){
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
			search.attr("action", "/report/list/"+object).submit();						
		}else if(oper == "ing"){
			form.find($("input[name='tab']")).val("ing"); 
			form.attr("action", "/report/list/"+object).submit();
		}else if(oper == "done"){
			form.find($("input[name='tab']")).val("done"); 
			form.attr("action", "/report/list/"+object).submit();
		}else if(oper == "no"){
			form.find($("input[name='tab']")).val("no"); 
			form.attr("action", "/report/list/"+object).submit();
		}else if(oper == "all"){
			form.find($("input[name='tab']")).val("all"); 
			form.attr("action", "/report/list/"+object).submit();
		}else{
			var tab = '<c:out value="${tab}"/>';
			self.location="/report/list/"+object+"?tab="+tab;
		}
	});
	

});
</script>                	
<%@ include file="../includes/footer.jsp"  %>
              