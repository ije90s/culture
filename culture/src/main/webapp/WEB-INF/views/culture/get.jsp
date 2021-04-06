<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
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
					.warningWrapper{
						position:absolute; 
						display:none; 
						justify-content:center; 
						align-items:center; 
						top:0%;
						width:100%;
						height:100%; 
 						background-color:gray; 
						z-index:100; 
						background:rgba(255,255,255,0.6); 
					}
					.warningDiv{
						position:relative; 
						display:flex; 
						justify-content:center; 
						align-items:center; 
						padding : 5px 0;
						top:15%;
						left : 5%;
						width : 30%;
						background-color:white; 
						border : 1px solid gray;
					}
					.invalid{color:red !important;}
					</style>
                    <div class="container-fluid">
                        <h3 class="mt-4">
                        <sec:authentication property="principal" var="pinfo"/>
                        <sec:authorize access="isAuthenticated()">
                        	<c:if test="${pinfo.member.mno eq culture.mno}">나의 </c:if>
                        	<c:if test="${pinfo.member.mno ne culture.mno}">문화</c:if>
                        </sec:authorize>기록 상세</h3>
                        <div class="card mb-4">
                            <div class="card-header">
                            	<c:if test="${culture.open ne '0' }">
	                                <h6 id="report" style="cursor:pointer;">
		                            	<i class="fas fa-bullhorn" style="color:red"></i> 
		                            	<c:if test="${culture.report eq 'N' }"> 신고하기</c:if>
		                            	<c:if test="${culture.report ne 'N' }"> 신고확인중</c:if>
	                                </h6>
                                </c:if>
                            </div>
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
                                             	<sec:authorize access="isAuthenticated()">
                                             		<c:if test="${pinfo.member.mno eq culture.mno || fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
	                                            		<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
	                                            		<button type="button" class="btn btn-danger" data-oper="remove">삭제</button>
	                                            		<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                            		</c:if>
                                            	</sec:authorize>
                                            </div>                       
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->
<div class="warningWrapper">
	<div class="warningDiv">
		<form id="reportForm">
	    	<div class="form-group">
	        	<label class="small mb-1" for="title">제목<medium class="invalid">*</medium></label>
	            <input class="form-control py-4 chk" name="title" id="title" type="text" value="${reportVO.title}"/>
	            <small></small>
	        </div>
	        <div class="form-group">
	            <label class="small mb-1" for="content">내용<medium class="invalid">*</medium></label>
	            <textarea class="form-control chk" name="content" rows="5" id="content">${reportVO.content}</textarea>
	            <small></small>
	        </div>
	        <div class="form-group mt-4 mb-0 text-right">
		        <button type="button" class="btn btn-primary btn-sm" id="regBtn" data-oper="reg">등록</button>
		        <button type="button" class="btn btn-warning  btn-sm" id="modBtn" data-oper="mod">수정</button>
		        <button type="button" class="btn btn-danger  btn-sm" id="delBtn" data-oper="del">삭제</button>
		        <button type="button" class="btn btn-secondary  btn-sm"  data-oper="close">닫기</button>
	         </div>        
	    </form>
    </div>
</div>                	
<div class="originPictureWrapper">
	<div class="originPicture"></div>
</div>                	               	
 <form id="mainForm" role="form" method="post">
 	<input type="hidden" id="cno" name="cno" value="${culture.cno}" />
 	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
 	<input type="hidden" name="amount" value="${cri.amount}" />
 	<input type="hidden" name="type" value="${cri.type }"/>
 	<input type="hidden" name="keyword" value="${cri.keyword }" />
 </form>   
 <script src="/resources/scripts/common.js"></script>
 <script src="/resources/scripts/report.js"></script>
 <script>
 $(document).ready(function(){
	 
	 var formObj = $("#mainForm");
	 var formRe = $("#reportForm");
	 var mno = '<sec:authentication property="principal.member.mno"/>'; 
	 var auth = null; 
	 <sec:authorize access="isAuthenticated()">
		auth = '<sec:authentication property="principal.member.authList" />';
	 </sec:authorize>	
	 if(auth.includes("ADMIN")) mno = "0";	
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
	
	var csrfHeader = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
		
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});	 
	 

	$(".chk").blur(function(e){
		reportService.validate($(this)); 
	});
	

	//invalid 항목 검사
	function checkItem(item){
		if(item.siblings('small').hasClass("invalid")){
			item.focus(); 
			return false; 
		}else {
			return true; 
		}	
	}		
	
	 $(".btn").on("click",function(e){
		 e.preventDefault(); 
		 var oper = $(this).data("oper"); 
		 //console.log(oper);
		 if(oper === "modify"){
			 formObj.attr("action", "/culture/modify").attr("method", "get").submit();
		 }else if(oper === "remove"){
			 formObj.append('<input type="hidden" id="${_csrf.parameterName}" name="${_csrf.parameterName}" value="${_csrf.token}" />');
			 formObj.append('<input type="hidden" name="object" value="'+mno+'"/>');
			 formObj.attr("action", "/culture/remove").submit();
		 }else if(oper === "list"){
			 formObj.find("#cno").remove();
			 formObj.attr("action", "/culture/list/"+mno).attr("method","get").submit();
		 }else if(oper == "reg"){

			 $(".chk").blur(function(e){
			   reportService.validate($(this)); 
		     });
					 
			 if(!checkItem(formRe.find("input[name='title']"))) return false;		
		     if(!checkItem(formRe.find("#content"))) return false;				 
			 
			 var report; 
			 var reporter = '<sec:authentication property="principal.username"/>'; 
			 var no = '<c:out value="${culture.cno}" />';
			 var title = formRe.find("input[name='title']").val();
			 var content = formRe.find("#content").val();
			 
			 report = {
				title : title, 
				content : content, 
				reporter : reporter, 
				kind : "culture", 
				no : no, 
				mid : reporter
			 };
			 console.log(report);
			 
			 reportService.add(report, function(data){
				alert("등록되었습니다.");
				location.reload();
			 }, function(error){
					alert("입력값을 확인하세요.");
					$(".chk").each(function(){
						reportService.validate($(this));
					});
				 });		 
		 }else if(oper == "mod"){	 	 
		
			 $(".chk").blur(function(e){
				reportService.validate($(this)); 
			 });
				 
		     if(!checkItem(formRe.find("input[name='title']"))) return false;		
			 if(!checkItem(formRe.find("#content"))) return false;				 
			 
			 var report; 
			 var title = formRe.find("input[name='title']").val();
			 var content = formRe.find("#content").val();
			 var rno = formRe.find("input[name='rno']").val();
			 var state = formRe.find("input[name='state']").val();
			 var reason = formRe.find("input[name='reason']").val();
			 var mid = formRe.find("input[name='mid']").val();
	
			 
			 report = {
				title : title, 
				content : content, 
				rno : rno, 
				state : state, 
				reason : reason, 
				mid : mid
			 }; 
			 console.log(report);
			 reportService.modify(report, function(data){
				alert("수정되었습니다.");  
				location.reload();
			 }, function(error){
				alert("입력값을 확인하세요.");
				$(".chk").each(function(){
					reportService.validate($(this));
				});
			 });
			 
		 }else if(oper == "del"){
			 var report; 
			 var title = formRe.find("input[name='title']").val();
			 var content = formRe.find("#content").val();
			 var rno = formRe.find("input[name='rno']").val();
			 var state = formRe.find("input[name='state']").val();
			 var reason = formRe.find("input[name='reason']").val();
			 var mid = formRe.find("input[name='mid']").val();
	
			 report = {
				title : title, 
				content : content, 
				rno : rno, 
				state : state, 
				reason : reason, 
				mid : mid
			 }; 			 
			 reportService.remove(report, function(data){
					alert("삭제되었습니다.");  
					location.reload();
			 });
		 }else if(oper == "close"){
			 formRe.find("input[name='title']").val(""); 
			 formRe.find("#content").val("");
			 $(".warningWrapper").hide(); 
		 }
	 });
	 
	 $(".originPictureWrapper").on("click", function(e){
		$(".originPicture").animate({width:'0%', height:'0%'}, 1000); 
		setTimeout(function(){
			$(".originPictureWrapper").hide();
		},1000);
	 });
	 
	 $("#report").on("click",function(e){
		 e.preventDefault();
		 var oper = $(this).text(); 
		 //console.log(oper);
		 if(oper.includes("신고하기")){
			if(auth.includes("MEMBER")){
				formRe.find("#regBtn").show();
				formRe.find("#modBtn").hide();
				formRe.find("#delBtn").hide();
				$(".warningWrapper").show(); 				
			}else{
				alert("신고할 수 없습니다.");
			}
		 }else{
			 var reporter = '<sec:authentication property="principal.username"/>'; 
			 var no = '<c:out value="${culture.cno}" />'; 
			 reportService.get("culture", no, function(data){
				 if(reporter == data.reporter){
					 if(data.state == "0"){
						 formRe.find("input[name='title']").val(data.title); 
						 formRe.find("#content").val(data.content); 
						 formRe.append("<input type='hidden' name='rno' value='"+data.rno+"'/>");
						 formRe.append("<input type='hidden' name='state' value='0'/>");
						 formRe.append("<input type='hidden' name='reason' value=''/>");
						 formRe.append("<input type='hidden' name='mid' value='"+reporter+"'/>");
						 formRe.find("#regBtn").hide();
						 formRe.find("#modBtn").show();
						 formRe.find("#delBtn").show();
						 $(".warningWrapper").show(); 	
					 }else{
						 alert("수정할 수 없습니다."); 
					 }					 
				 }else{
					 alert("신고 처리중입니다.");
				 }

			 });
		 }
	 });	
 });
 </script>               	
<%@ include file="../includes/footer.jsp"  %>