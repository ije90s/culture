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
                            	<form role="form" action="/board/modify" method="post">
                            		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
                            		<input type="hidden" name="amount" value="${cri.amount}" />
									<input type="hidden" name="bno" value="${board.bno}" />
                            		<div class="form-group">
                            			<label class="small mb-1" for="kind">구분</label>
                            			<select name="kind" id="kind">
                            				<option value="">선택</option>
                            				<option value="free" <c:if test="${board.kind eq 'free'}">selected</c:if>>자유게시판</option>
                            				<option value="question" <c:if test="${board.kind eq 'question'}">selected</c:if>>문의사항</option>
                            			</select>
                            		</div>									
	                            	<div class="form-group">
	                                	<label class="small mb-1" for="cdate">제목 </label>
	                                    <input class="form-control py-4" name="title" id="title" value="${board.title}" type="text"/>
	                                </div>
	                                <div class="form-group">
	                                	<label class="small mb-1" for="content">내용</label>
	                                    <textarea class="form-control" name="content" rows="5" id="content">${board.content}</textarea>
									</div>
									<div class="form-group">
									사진 첨부
									</div>
	                                <div class="form-group mt-4 mb-0 text-right">
	                                     <button type="button" class="btn btn-primary" data-oper="modify">수정</button>
										<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
	                                </div>
                                </form>                             
                            
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->   
<script>
$(document).ready(function(){
	var form = $("form");
	
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper"); 
		
		if(oper == "modify"){
			if(confirm("수정하시겠습니까?")){
				form.submit();
			}
		}else{
			var pageNumObj = $("input[name='pageNum']").clone(); 
			var amountObj = $("input[name='amount']").clone(); 
			console.log(pageNumObj);
			form.empty();
			form.append(pageNumObj);
			form.append(amountObj);
			form.attr("method","get").attr("action", "/board/list").submit();
		}
	})
});
</script>                                                        
<%@ include file="../includes/footer.jsp"  %>                            