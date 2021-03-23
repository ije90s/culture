<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ include file="../includes/header.jsp"  %>

                    <div class="container-fluid">
                        <h3 class="mt-4">나의 기록
	                        <div class="btn-group float-right">
	                         	<button type="button" class="btn btn-outline-primary active">리스트</button>
	  							<button type="button" class="btn btn-outline-primary">통계</button>
	                        </div>
                        </h3>
                        <div class="card mb-4">
                            <div class="card-header">
                                <form id="searchForm" action="/culture/list" method="get">
                                	<select name="type">
                                	<option value="" <c:out value="${page.cri.type==null?'selected':''}"/>>선택</option>
                                	<option value="T" <c:out value="${page.cri.type eq 'T'?'selected':''}"/>>제목</option>
                                	<option value="C" <c:out value="${page.cri.type eq 'C'?'selected':''}"/>>내용</option>
                                	<option value="TC" <c:out value="${page.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
                                	</select>
                                	<input type="text" name="keyword" value='<c:out value="${page.cri.keyword}"/>' />
                                	<input type="hidden" name="pageNum" value='<c:out value="${page.cri.pageNum }"/>' />
									<input type="hidden" name="amount" value='<c:out value="${page.cri.amount }"/>' />
									<button class="btn btn-primary" data-oper="search">검색</button>
									<button class="btn btn-secondary float-right" data-oper="regiter">등록</button>
                                </form>
                                
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>NO.</th>
                                                <th>종류</th>
                                                <th>제목</th>
                                                <th>평점</th>
                                                <th>날짜</th>
                                            </tr>
                                        </thead>
     									<tbody>
     									<c:forEach var="culture" items="${list}">     	
     										<tr>										
     											<td>${culture.cno}</td>
     											<td>
     												<c:if test="${culture.kind eq 1}">공연</c:if> 
     												<c:if test="${culture.kind eq 2}">영화</c:if> 
     												<c:if test="${culture.kind eq 3}">독서</c:if> 
     												<c:if test="${culture.kind eq 4}">관람</c:if> 
     												<c:if test="${culture.kind eq 5}">스포츠</c:if> 
     												<c:if test="${culture.kind eq 6}">기타</c:if> 
     											</td>
     											<td><a class="move" href="${culture.cno}">${culture.title}</a></td>
     											<td>${culture.rank}점</td>
     											<td>
     											<fmt:parseDate value="${culture.cdate}" var="cdate" pattern="yyyy-MM-dd"/>
     											<fmt:formatDate value="${cdate}" pattern="yyyy-MM-dd"/></td>
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
								    
								    <c:if test="">
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
	var mno = '<sec:authentication property="principal.member.mno"/>'; 
	var form = $("#listForm"); 
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
		form.attr("action", "/culture/list/"+mno).submit();
	});
	
	//상세페이지 이동
	$(".move").click(function(e){
		e.preventDefault(); 
		form.append("<input type='hidden' name='cno' value='"+$(this).attr("href")+"'>"); 
		form.attr("action", "/culture/get").submit();
	});
	$(".btn-group").on("click", "button", function(e){
		e.preventDefault(); 
		var text = $(this).text(); 
		if(text == "리스트"){
			self.location="/culture/list/"+mno; 	
		}else{
			self.location="/culture/stats/"+mno; 	
		}
	});
	var search = $("#searchForm"); 
	$("#searchForm button").on("click", function(e){
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
			search.attr("action", "/culture/list/"+mno).submit();			
		}else{
			self.location="/culture/register";
		}
		
	});
});
</script>                	
<%@ include file="../includes/footer.jsp"  %>
              