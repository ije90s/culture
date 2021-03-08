<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">게시판 상세</h1>
                        <div class="card mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">
                        		<div class="form-group">
                            		<label class="small mb-1" for="kind">구분</label>
                            		<select name="kind" id="kind" disabled>
                            			<option value="">선택</option>
                            			<option value="free" <c:if test="${board.kind eq 'free'}">selected</c:if>>자유게시판</option>
                            			<option value="question" <c:if test="${board.kind eq 'question'}">selected</c:if>>문의사항</option>
                            		</select>
                            	</div>                            
                            	<div class="form-group">
                                	<label class="small mb-1" for="cdate">제목 </label>
                                    <input class="form-control py-4" name="title" id="title" type="text" value='${board.title}' readonly/>
                                </div>
                                <div class="form-group">
                                	<label class="small mb-1" for="content">내용</label>
                                    <textarea class="form-control" name="content" rows="5" id="content" readonly>${board.content}</textarea>
								</div>
								<div class="form-group">
								사진 첨부
								</div>
                                <div class="form-group mt-4 mb-0 text-right">
                                    <button type="button" class="btn btn-primary" data-oper="modify">수정</button>
                                    <button type="button" class="btn btn-danger" data-oper="remove">삭제</button>
									<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                </div>                  				
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 --> 
<form role="form" method="get">
	<input type="hidden" name="bno" value="${board.bno}" />
	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
	<input type="hidden" name="amount" value="${cri.amount}" />
</form>                 	  
<script>
$(document).ready(function(){
	var form = $("form"); 
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper"); 
		console.log(oper);
		if(oper === "modify"){
			form.attr("action", "/board/modify").submit();
		}else if(oper === "remove"){
			form.attr("method", "post").form.attr("action", "/board/remove").submit();
		}else{
			form.find("input[name='bno']").remove();
			form.attr("action", "/board/list").submit();
		}
	});
});
</script>                	
<%@ include file="../includes/footer.jsp"  %> 