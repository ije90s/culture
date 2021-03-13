<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">나의 기록 등록</h1>
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-check-circle"></i> 자유롭게 기입하세요 </div>
                            <div class="card-body">
									<form role="form" action="/culture/register" method="post">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="mno" value='<sec:authentication property="principal.member.mno"/>' />
									        <div class="form-group">
                                                <label class="small mb-1" for="cdate">날짜</label>
                                                <input class="form-control py-4" name="cdate" id="cdate" type="date"/>
                                            </div>
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="kind">종류</label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="1">공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="2">영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="3">독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="4">관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="5">스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="kind" value="6">기타
														</label>
													</div>
												</div>																																																							                                            			
                                            </div>
                                           <div class="form-group">
                                                <label class="small mb-1" for="title">제목</label>
                                                <input class="form-control py-4" name="title" id="title" type="text"/>
                                            </div>
                                            <div class="form-group">
                                            	<label class="small mb-1" for="rank">평점</label>
                                            	<div id="rank">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="1">1점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="2">2점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="3">3점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="4">4점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="rank" value="5">5점
														</label>
													</div>	
												</div>																																																							                                            			
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content"></textarea>
											</div>
											<div class="form-group uploadDiv">
												<label class="small mb-1" for="upload">사진첨부</label>
												<input type="file" id="upload" name="upload" multiple />
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
                	
<script>

var uploadResult = $(".uploadResult ul"); 

function showUploadResult(uploadResultArr){
	var str="";  
	$(uploadResultArr).each(function(i, obj){
		
		if(!obj.image){
			
		}else{
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName); 
			var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
			originPath = originPath.replace(new RegExp(/\\/g),"/");  
			str+="<li class='list-group-item' data-path='"+obj.uploadPath+"'";
			str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'/>";
			str+="<div><span>"+obj.fileName+"</span>";
			str+="<button type='button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'></i></button><br>";
			str+="<a href=\"javascript:showImg(\'"+originPath+"')\"><img src='/display?fileName="+fileCallPath+"' /></a>";
			str+="</div></li>"; 
		}
	});

	uploadResult.append(str);
}

function showImg(originPath){
	
	$(".modal-body").html("<img src='/display?fileName="+originPath+"'/>"); 
	$("#myModal").modal("show");
}

$(document).ready(function(){
	
	var formObj = $("form"); 
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
	
	var regex = new RegExp("(.*?)\.(jpg|png|gif|bmp)$"); 
	var maxSize = 5242880; 
	function checkExtension(fileName, fileSize){
		if(fileSize > maxSize){
			alert("파일 사이즈가 초과되었습니다."); 
			return false; 
		}
		
		if(!regex.test(fileName)){
			alert("사진 파일 형식만 가능합니다.");
			return false; 
		}
		
		return true; 
	}
	
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}"; 
	
	$("input[type='file']").change(function(e){
		var formData = new FormData(); 
		var upload = $("input[name='upload']"); 
		var files = upload[0].files; 
		
		//console.log(files);		
		formData.append("folder", "culture");		
		
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