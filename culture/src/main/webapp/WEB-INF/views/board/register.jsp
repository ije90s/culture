<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<%@ include file="../includes/header.jsp"  %>
					<style>
        			.invalid{color:red !important;}
        			</style>
                    <div class="container-fluid">
                        <h3 class="mt-4">
                            <c:if test="${kind eq 'notice' }">공지사항</c:if>
	                        <c:if test="${kind eq 'free' }">자유게시판</c:if>
	                        <c:if test="${kind eq 'question' }">질문&답변</c:if>
	                        <c:if test="${kind eq 'review' }">문화후기</c:if> 
	                    	<c:if test="${refno eq 0}">등록</c:if>
	                    	<c:if test="${refno ne 0}">답글</c:if>
	                    </h3>
                        <div class="card mb-4">
                            <div class="card-header"><h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6></div>
                            <div class="card-body">
                            	<form role="form" action="/board/register" method="post">
                            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            		<input type="hidden" name="writer" value='<sec:authentication property="principal.username"/>'/>
                            		<input type="hidden" name="kind" value="${kind}"/>
                            		<input type="hidden" name="refno" value="${refno}" />
	                            	<div class="form-group">
	                                	<label class="small mb-1" for="title">제목<medium class="invalid">*</medium></label>
	                                    <input class="form-control py-4" name="title" id="title" type="text" value="${boardVo.title}"/>
	                                    <small></small>
	                                </div>
	                                <div class="form-group">
	                                	<label class="small mb-1" for="content">내용<medium class="invalid">*</medium></label>
	                                    <textarea class="form-control" name="content" rows="5" id="content"><c:if test="${refno ne 0 }"><c:if test="${!fn:contains(boardVo.content, '답글')}">============답글===========</c:if></c:if>${boardVo.content}</textarea>
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
	                                    <button type="submit" class="btn btn-primary">등록</button>
										<button type="reset" class="btn btn-secondary">취소</button>
	                                </div>
                                </form>                  				
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->   
<script src="/resources/scripts/common.js"></script>
<script src="/resources/scripts/board.js"></script>
<script>
$(document).ready(function(){
	
	var formObj = $("form"); 
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	
	$(".form-control").blur(function(e){
		boardService.validate($(this)); 
	});
	hasErrors();
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault(); 
		console.log("submit clicked");
		var str="";
		
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			str+="<input type='hidden' name='attachList[0].fileList["+i+"].path' value='"+jobj.data("path")+"' />";
			str+="<input type='hidden' name='attachList[0].fileList["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
			str+="<input type='hidden' name='attachList[0].fileList["+i+"].fileName' value='"+jobj.data("filename")+"'/>"; 
			str+="<input type='hidden' name='attachList[0].fileList["+i+"].fileType' value='"+jobj.data("type")+"'/>";
		});
		
		$(".form-control").each(function(e){
			boardService.validate($(this));	
		});
	
		if(!checkItem($("input[name='title']"))) return false; 
		if(!checkItem($("input[name='content']"))) return false; 
	
		formObj.append(str).submit();
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
	
	//서버에서 받아온 error 검사
	function hasErrors(){
		<spring:hasBindErrors name="boardVO">
		$(".form-control").each(function(){
			boardService.validate($(this));	
		}); 
		var str=""; 
		<c:forEach items="${boardVO.attachList[0].fileList}" var="obj"> 
			var path = "${obj.path}";
			var decodePath = decodeURIComponent(path);
			var fileCallPath = path+encodeURIComponent("\\s_${obj.uuid}_${obj.fileName}");  
			var originPath = decodePath+"\\${obj.uuid}_${obj.fileName}";
			originPath = originPath.replace(new RegExp(/\\/g),"/");  
			
			str+="<li class='list-group-item' data-path='"+decodePath+"'";
			str+=" data-uuid='${obj.uuid}' data-filename='${obj.fileName}' data-type='${obj.fileType}'/>";
			str+="<div><span>${obj.fileName}</span>";
			str+="<button type='button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'></i></button><br>";
			str+="<a href=\"javascript:showImg(\'"+originPath+"')\"><img src='/display?fileName="+fileCallPath+"' /></a>";
			str+="</div></li>"; 
		</c:forEach>
		$(".uploadResult ul").append(str);
		
		</spring:hasBindErrors>			
	}	
	
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
	

	$(".uploadResult").on("click", "button", function(e){
		console.log("deleted file");
		
		var targetFile = $(this).data("file"); 
		var type=$(this).data("type"); 
		var targetLi = $(this).closest("li"); 
		
		$.ajax({
			url : '/deleteFile', 
			data : {fileName:targetFile, type:type}, 
			dataType : 'text', 
			type : 'POST', 
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success : function(result){
				targetLi.remove();
				alert("삭제되었습니다.");
				
			}
		});
	});		
});
</script>         
<%@ include file="../includes/footer.jsp"  %> 