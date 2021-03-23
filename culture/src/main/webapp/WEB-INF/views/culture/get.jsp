<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ include file="../includes/header.jsp"  %>
					<style>
					.originPictureWrapper{
						position:absolute; 
						display:none; 
						justify-content:center; 
						align-items:center; 
						top:0%;
						width:100%; 
						height:100%; 
						background-color:gray; 
						z-index:100; 
						background:rgba(255,255,255,0.5); 
					}
					.originPicture{
						position:relative; 
						display:flex; 
						justify-content:center; 
						align-items:center; 
					}
					.originPicture img{
						width:600px; 
					}
					</style>
                    <div class="container-fluid">
                        <h1 class="mt-4">나의 기록 상세</h1>
                        <div class="card mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">
									        <div class="form-group">
                                                <label class="small mb-1" for="cdate">날짜 </label>
                                                <fmt:parseDate value="${culture.cdate}" var="cdate" pattern="yyyy-MM-dd"/>
                                                <input class="form-control py-4" name="cdate" id="cdate" type="date" value='<fmt:formatDate value="${cdate}" pattern="yyyy-MM-dd"/>' readonly/>
                                            </div>
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="kind">종류</label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="1" <c:if test="${culture.kind eq 1}"><c:out value="checked"/></c:if> disabled>공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="2" <c:if test="${culture.kind eq 2}"><c:out value="checked"/></c:if> disabled>영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="3" <c:if test="${culture.kind eq 3}"><c:out value="checked"/></c:if> disabled>독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="4" <c:if test="${culture.kind eq 4}"><c:out value="checked"/></c:if> disabled>관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="5" <c:if test="${culture.kind eq 5}"><c:out value="checked"/></c:if> disabled>스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="6" <c:if test="${culture.kind eq 6}"><c:out value="checked"/></c:if> disabled>기타
														</label>
													</div>
												</div>																																																							                                            			
                                            </div>
                                           <div class="form-group">
                                                <label class="small mb-1" for="title">제목</label>
                                                <input class="form-control py-4" name="title" id="title" type="text" value="${culture.title}" readonly/>
                                            </div>
                                            <div class="form-group">
                                            	<label class="small mb-1" for="rank">평점</label>
                                            	<div id="rank">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="1" <c:if test="${culture.rank eq 1}"><c:out value="checked"/></c:if> disabled>1점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="2" <c:if test="${culture.rank eq 2}"><c:out value="checked"/></c:if> disabled>2점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="3" <c:if test="${culture.rank eq 3}"><c:out value="checked"/></c:if> disabled>3점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="4" <c:if test="${culture.rank eq 4}"><c:out value="checked"/></c:if> disabled>4점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="5" <c:if test="${culture.rank eq 5}"><c:out value="checked"/></c:if> disabled>5점
														</label>
													</div>	
												</div>																																																							                                            			
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content" readonly>${culture.content}</textarea>
											</div>
											<div class="form-group uploadResult">
												<ul class="list-group list-group-horizontal"></ul>
											</div>
                                            <div class="form-group mt-4 mb-0 text-right">
                                            	<sec:authentication property="principal" var="pinfo"/>
                                             	<sec:authorize access="isAuthenticated()">
                                             		<c:if test="${pinfo.member.mno eq culture.mno}">
	                                            		<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
	                                            		<button type="button" class="btn btn-danger" data-oper="remove">삭제</button>
                                            		</c:if>
                                            	</sec:authorize>
												<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                            </div>                       
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->
<div class="originPictureWrapper">
	<div class="originPicture"></div>
</div>                	               	
 <form role="form" method="post">
 	<input type="hidden" id="cno" name="cno" value="${culture.cno}" />
 	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
 	<input type="hidden" name="amount" value="${cri.amount}" />
 	<input type="hidden" name="type" value="${cri.type }"/>
 	<input type="hidden" name="keyword" value="${cri.keyword }" />
 </form>   
 <script src="/resources/scripts/common.js"></script>
 <script>
 $(document).ready(function(){
	 
	 var formObj = $("form"); 
	 var mno = '<sec:authentication property="principal.member.mno"/>'; 
	 (function(){
			var cno = '<c:out value="${culture.cno}" />';
			$.getJSON("/culture/getAttachList", {cno : cno}, function(arr){
				var str = ""; 
				
				if(arr==null || arr.length==0){
					$(".uploadResult ul").html("");
					return;
				}

				$(arr[0].fileList).each(function(i, attach){
					
					if(!attach.fileType){	
					}else{
						var fileCallPath = encodeURIComponent(attach.path+"/s_"+attach.uuid+"_"+attach.fileName); 
						
						str+="<li class='list-group-item' data-path='"+attach.path+"'";
						str+=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'>";
						str+="<div>";
						str+="<img src='/display?fileName="+fileCallPath+"' />";
						str+="</div></li>"; 
					}
				});
				$(".uploadResult ul").html(str);
			});
	 })();	 
	 
	 $(".uploadResult").on("click", "li", function(e){
		console.log("clicked");
		var liObj = $(this); 
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename")); 
	 	showImg(path.replace(new RegExp(/\\/g),"/"));
	 });
		

	 $(".btn").on("click",function(e){
		 e.preventDefault(); 
		 var oper = $(this).data("oper"); 
		 //console.log(oper);
		 if(oper === "modify"){
			 formObj.attr("action", "/culture/modify").attr("method", "get").submit();
		 }else if(oper === "remove"){
			 formObj.append('<input type="hidden" id="${_csrf.parameterName}" name="${_csrf.parameterName}" value="${_csrf.token}" />');
			 formObj.append('<input type="hidden" name="mno" value="'+mno+'"/>');
			 formObj.attr("action", "/culture/remove").submit();
		 }else if(oper === "list"){
			 formObj.find("#cno").remove();
			 formObj.attr("action", "/culture/list/"+mno).attr("method","get").submit();
		 } 
	 });
	 
	 $(".originPictureWrapper").on("click", function(e){
		$(".originPicture").animate({width:'0%', height:'0%'}, 1000); 
		setTimeout(function(){
			$(".originPictureWrapper").hide();
		},1000);
	 });
	
 });
 </script>               	
<%@ include file="../includes/footer.jsp"  %>