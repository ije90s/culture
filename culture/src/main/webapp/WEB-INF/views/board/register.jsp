<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">게시판 상세</h1>
                        <div class="card mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">
                            	<form role="form" action="/board/register" method="post">
                            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            		<input type="hidden" name="writer" value='<sec:authentication property="principal.username"/>'/>
                            		<div class="form-group">
                            			<label class="small mb-1" for="kind">구분</label>
                            			<select name="kind" id="kind">
                            				<option value="">선택</option>
                            				<option value="free">자유게시판</option>
                            				<option value="question">문의사항</option>
                            			</select>
                            		</div>
	                            	<div class="form-group">
	                                	<label class="small mb-1" for="title">제목 </label>
	                                    <input class="form-control py-4" name="title" id="title"" type="text"/>
	                                </div>
	                                <div class="form-group">
	                                	<label class="small mb-1" for="content">내용</label>
	                                    <textarea class="form-control" name="content" rows="5" id="content"></textarea>
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
<script>
$(document).ready(function(){
	
	var formObj = $("form"); 
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	
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

		formObj.append(str).submit();
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