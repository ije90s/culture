<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="../includes/header.jsp"  %>
					<style>
        			.invalid{color:red !important;}
        			</style>
                    <div class="container-fluid">
                        <h3 class="mt-4">나의 기록 등록</h3>
                        <div class="card mb-4">
                            <div class="card-header"><h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6></div>
                            <div class="card-body">
									<form role="form" action="/culture/register" method="post">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="mno" value='<sec:authentication property="principal.member.mno"/>' />
									        <div class="form-group">
                                                <label class="small mb-1" for="cdate">날짜<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4 chk" name="cdate" id="cdate" type="date" value="${cultureVO.cdate}"/>
                                                <small></small>
                                            </div>
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="kind">종류<medium class="invalid">*</medium></label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="1" <c:if test="${fn:contains(cultureVO.kind, '1')}">checked</c:if>>공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="2" <c:if test="${fn:contains(cultureVO.kind, '2')}">checked</c:if>>영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="3" <c:if test="${fn:contains(cultureVO.kind, '3')}">checked</c:if>>독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="4" <c:if test="${fn:contains(cultureVO.kind, '4')}">checked</c:if>>관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="5" <c:if test="${fn:contains(cultureVO.kind, '5')}">checked</c:if>>스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="6" <c:if test="${fn:contains(cultureVO.kind, '6')}">checked</c:if>>기타
														</label>
													</div><br>
													<small class="kind"></small>
												</div>																																																							                                            			
                                            </div>
                                           <div class="form-group">
                                                <label class="small mb-1" for="title">제목<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4 chk" name="title" id="title" type="text" value="${cultureVO.title}" />
                                                <small></small>
                                            </div>
                                            <div class="form-group">
                                            	<label class="small mb-1" for="rank">평점</label>
                                            	<input type="hidden" name="rank" />
                                            	<div id="rank">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="1" <c:if test="${fn:contains(cultureVO.rank, '1')}">checked</c:if>>1점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="2" <c:if test="${fn:contains(cultureVO.rank, '2')}">checked</c:if>>2점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="3" <c:if test="${fn:contains(cultureVO.rank, '3')}">checked</c:if>>3점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="4" <c:if test="${fn:contains(cultureVO.rank, '4')}">checked</c:if>>4점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="5" <c:if test="${fn:contains(cultureVO.rank, '5')}">checked</c:if>>5점
														</label>
													</div>	
												</div>																																																							                                            			
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content">${cultureVO.content}</textarea>
											</div>
											<div class="form-group uploadDiv">
												<label class="small mb-1" for="upload">사진첨부</label>
												<input type="file" id="upload" name="upload" data-folder="culture" multiple/>
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
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">원본이미지</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->                    	
<script src="/resources/scripts/common.js"></script>        
<script src="/resources/scripts/culture.js"></script>   	
<script>

$(document).ready(function(){
	
	var formObj = $("form"); 
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	
	$(".chk").blur(function(e){
		cultureService.validate($(this));	
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
	
		$(".chk").each(function(e){
			cultureService.validate($(this));	
		});
		
		if(!checkItem($("input[name='cdate']"))) return false;
		if(!checkItem($("input[name='kind']"))) return false;
		if(!checkItem($("input[name='title']"))) return false;
		
		if(!$("input[name=crank]").is(":checked")) $("input[name=rank]").val("0"); 
	
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
		<spring:hasBindErrors name="cultureVO">
		$(".chk").each(function(){
			cultureService.validate($(this));	
		}); 
		var str=""; 
		<c:forEach items="${cultureVO.attachList[0].fileList}" var="obj"> 
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