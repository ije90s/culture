<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">
	                        <c:if test="${kind eq 'notice' }">공지사항</c:if>
	                        <c:if test="${kind eq 'free' }">자유게시판</c:if>
	                        <c:if test="${kind eq 'question' }">질문&답변</c:if>
	                        <c:if test="${kind eq 'share' }">공유마당</c:if>
                        </h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header">
                                 <form id="searchForm" action="/board/list" method="get">
                                 <input type="hidden" name="pageNum" value='<c:out value="${page.cri.pageNum }"/>' />
								 <input type="hidden" name="amount" value='<c:out value="${page.cri.amount }"/>' />
								 <div class="input-group">
                                	<select name="type" class="custom-select" style="flex:none; width:200px;">
                                	<option value="" <c:out value="${page.cri.type==null?'selected':''}"/>>선택</option>
                                	<option value="T" <c:out value="${page.cri.type eq 'T'?'selected':''}"/>>제목</option>
                                	<option value="C" <c:out value="${page.cri.type eq 'C'?'selected':''}"/>>내용</option>
                                	<option value="W" <c:out value="${page.cri.type eq 'W'?'selected':''}"/>>작성자</option>
                                	<option value="TC" <c:out value="${page.cri.type eq 'TC'?'selected':''}"/>>제목+내용</option>
                                	<option value="TW" <c:out value="${page.cri.type eq 'TW'?'selected':''}"/>>제목+작성자</option>
                                	<option value="WC" <c:out value="${page.cri.type eq 'WC'?'selected':''}"/>>작성자+내용</option>
                                	<option value="TWC" <c:out value="${page.cri.type eq 'TWC'?'selected':''}"/>>제목+작성자+내용</option>
                                	</select>
                                	<div class="input-group-prepend"><input type="text" name="keyword" class="form-control" value='<c:out value="${page.cri.keyword}"/>' /></div>  	
									<div class="input-group-prepend"><button class="btn btn-primary" data-oper="search">검색</button></div>
									<div class="input-group-prepend"><button type="button" class="btn btn-success" data-oper="back">초기화</button></div>
									<c:if test="${kind ne 'notice' }">
										<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
											<button class="btn btn-secondary" style="position:absolute; right:5px;" data-oper="register">등록</button>
										</sec:authorize>
									</c:if>
									<c:if test="${kind eq 'notice' }">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<button class="btn btn-secondary" style="position:absolute; right:5px;" data-oper="register">등록</button>
										</sec:authorize>
									</c:if>
								</div>	
                                </form>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                	<h6>* 게시글이 삭제될 시, 답글까지도 모두 삭제됩니다.</h6>
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
											<td>${list.rn}</td>
											<td>
												<c:forEach varStatus="sts" begin="1" end="${list.level}">
												&nbsp;&nbsp;
													<c:if test="${list.level>1 and sts.last}">
														<i class='fab fa-replyd'></i>
													</c:if>
												</c:forEach>
												<a class="move" href="${list.bno}">${list.title} <b>[<c:out value="${list.replyCnt}"/>]</b></a>												
											</td>
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
	var kind = '<c:out value="${kind}"/>';
	
	checkModal(result); 
	history.replaceState({}, null, null);
	
	//모달창
	function checkModal(result){
		if(result === '' || history.state){
			return; 
		}
		$("#myModal").modal("show");
	}
	
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
			search.attr("action", "/board/list/"+kind).submit();			
		}else if(oper == "register"){
			search.empty();
			search.append("<input type='hidden' name='kind' value='"+kind+"'/>");
			search.append("<input type='hidden' name='refno' value='0' />");
			search.attr("action", "/board/register").submit();			
		}else {
			self.location="/board/list/"+kind;
		}
		
	});

	
	var form = $("#listForm");
	$(".move").click(function(e){
		e.preventDefault();
		var bno = $(this).attr("href");
		console.log(bno);
		form.append("<input type='hidden' name='bno' value='"+bno+"'/>");
		form.append("<input type='hidden' name='kind' value='"+kind+"'/>");
		form.attr("action", "/board/get").submit();
	}); 
	
	 
	$(".page-link").click(function(e){
		e.preventDefault(); 
		var selectedPageNum = $(this).attr("href"); 
		form.find("input[name='pageNum']").val(selectedPageNum);
		form.attr("action", "/board/list/"+kind).submit();
	});
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>