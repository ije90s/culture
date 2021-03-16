<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">나의 기록 수정</h1>
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-check-circle"></i> 자유롭게 수정하세요</div>
                            <div class="card-body">
                            	<form role="form" action="/board/modify" method="post">
                            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            		<input type="hidden" name="writer" value="${board.writer}" />
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
									<div class="form-group uploadDiv">
										<label class="small mb-1" for="upload">사진첨부</label>
										<input type="file" id="upload" name="upload" data-folder="board" multiple />
									</div>
									<div class="form-group uploadResult">
										<ul class="list-group list-group-horizontal"></ul>
									</div>
	                                <div class="form-group mt-4 mb-0 text-right">
	                                	<sec:authentication property="principal" var="pinfo"/>
	                                	<sec:authorize access="isAuthenticated()">
	                                		<c:if test="${pinfo.username eq board.writer}">
	                                    		<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
	                                    	</c:if>
	                                    </sec:authorize>
										<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
	                                </div>
                                </form>                             
                            
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->   
                	
<script src="/resources/scripts/common.js"></script>   
<script>
$(document).ready(function(){
	var form = $("form");
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	
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
				form.append(str).submit();
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