<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">                        
                         <c:if test="${board.kind eq 'notice' }">공지사항</c:if>
	                     <c:if test="${board.kind eq 'free' }">자유게시판</c:if>
	                     <c:if test="${board.kind eq 'question' }">질문&답변</c:if>
	                     <c:if test="${board.kind eq 'share' }">공유마당</c:if> 수정</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"><h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6></div>
                            <div class="card-body">
                            	<form id="mainForm" role="form" action="/board/modify" method="post">
                            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
                            		<input type="hidden" name="amount" value="${cri.amount}" />
                            		<input type="hidden" name="type" value="${cri.type}" />
                            		<input type="hidden" name="keyword" value="${cri.keyword}" />
									<input type="hidden" name="bno" value="${board.bno}" />
									<input type="hidden" name="writer" value="${board.writer}" />
                         			<input type="hidden" name="kind" value="${board.kind}" />								
	                            	<div class="form-group">
	                                	<label class="small mb-1" for="title">제목<medium class="invalid">*</medium></label>
	                                    <input class="form-control py-4 chk" name="title" id="title" value="${board.title}" type="text"/>
	                                    <small></small>
	                                </div>
	                                <div class="form-group">
	                                	<label class="small mb-1" for="content">내용<medium class="invalid">*</medium></label>
	                                    <textarea class="form-control chk" name="content" rows="5" id="content">${board.content}</textarea>
	                                    <small></small>
									</div>
									<div class="form-group uploadDiv">
										<label class="small mb-1" for="upload">사진첨부</label>
										<input type="file" id="upload" name="upload" data-folder="board" multiple />
									</div>
									<div class="form-group uploadResult">
										<ul class="list-group list-group-horizontal"></ul>
									</div>
	                                <div class="form-group mt-4 mb-0 text-right">
	                                	<sec:authentication property="principal" var="pinfo"/>
	                                	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
	                                		<c:if test="${pinfo.username eq board.writer || fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
	                                    		<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
	                                    	</c:if>
	                                    </sec:authorize>
										<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
	                                </div>
                                </form>                             
                            
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->   
<div class="originPictureWrapper">
	<div class="originPicture"></div>
</div>                  	
<script src="/resources/scripts/common.js"></script>   
<script src="/resources/scripts/board.js"></script>
<script>
$(document).ready(function(){
	var form = $("#mainForm");
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	
	
	$(".chk").blur(function(e){
		boardService.validate($(this)); 
	});
	hasErrors();
	
	 (function(){
			var bno = '<c:out value="${board.bno}" />';
			$.getJSON("/board/getAttachList", {bno : bno}, function(arr){
				var str = ""; 
				
				if(arr==null || arr.length==0){
					$(".uploadResult ul").html("");
					return;
				}

				$(arr[0].fileList).each(function(i, attach){
					
					if(!attach.fileType){	
					}else{
						var fileCallPath = encodeURIComponent(attach.path+"/s_"+attach.uuid+"_"+attach.fileName); 
						var originPath = attach.path+"\\"+attach.uuid+"_"+attach.fileName;
						originPath = originPath.replace(new RegExp(/\\/g),"/");  
						str+="<li class='list-group-item' data-path='"+attach.path+"'";
						str+=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str+="<div><span>"+attach.fileName+"</span>";
						str+="<button type='button' class='btn btn-warning btn-circle' data-file=\'"+attach.path+"\' data-type='image'><i class='fa fa-times'></i></button><br>";
						str+="<a href=\"javascript:showImg(\'"+originPath+"')\"><img src='/display?fileName="+fileCallPath+"' /></a>";
						str+="</div></li>"; 
					}
				});
				$(".uploadResult ul").html(str);
			});
	 })();	
		
	$(".uploadResult").on("click", "button", function(e){
		console.log("deleted file");
		
		var targetFile = $(this).data("file"); 
		var type=$(this).data("type"); 
		var targetLi = $(this).closest("li"); 
		
		if(confirm("사진을 삭제하시겠습니까?")){
			targetLi.remove();
		}
	});	
 
	$("input[type='file']").change(function(e){
		var formData = new FormData(); 
		var upload = $("input[name='upload']"); 
		var files = upload[0].files; 
			
		formData.append("folder", $(this).data("folder"));		
		
		for(var i=0;i<files.length;i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false; 
			}
			formData.append("upload",files[i]); 
		}

		$.ajax({
			url : '/uploadAction', 
			processData: false, 
			contentType : false, 
			data: formData, 
			type: 'POST', 
			dataType:'json',
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(result){
				console.log(result);
				showUploadResult(result);
			}
		});		
	});		
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper"); 
		
		if(oper == "modify"){
			if(confirm("수정하시겠습니까?")){
				var str="";
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].path' value='"+jobj.data("path")+"' />";
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].fileName' value='"+jobj.data("filename")+"'/>"; 
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].fileType' value='"+jobj.data("type")+"'/>";
				});
				
				$(".chk").each(function(e){
					boardService.validate($(this));	
				});
			
				if(!checkItem($("input[name='title']"))) return false; 
				if(!checkItem($("input[name='content']"))) return false; 
				
				form.append(str).submit();
			}
		}else{
			var pageNum = form.find("input[name='pageNum']"); 
			var amount = form.find("input[name='amount']"); 
			var type = form.find("input[name='type']");   
			var keyword = form.find("input[name='keyword']"); 
			
			form.empty();
			form.append(pageNum);
			form.append(amount);
			form.append(type);
			form.append(keyword);
			form.attr("method","get").attr("action", "/board/list/"+kind).submit();
		}
	});
	 $(".originPictureWrapper").on("click", function(e){
			$(".originPicture").animate({width:'0%', height:'0%'}, 1000); 
			setTimeout(function(){
				$(".originPictureWrapper").hide();
			},1000);
		 });	
	 
	//서버에서 받아온 error 검사
	 function hasErrors(){
	 	<spring:hasBindErrors name="board">
	 	$(".chk").each(function(){
	 		boardService.validate($(this));	
	 	}); 	
	 	</spring:hasBindErrors>			
	 }		 
});


</script>                                                        
<%@ include file="../includes/footer.jsp"  %>                            