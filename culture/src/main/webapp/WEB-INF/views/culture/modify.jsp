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
                        <h3 class="mt-4">나의 기록 수정</h3>
                        <div class="card mb-4">
                            <div class="card-header"><h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6></div>
                            <div class="card-body">
									<form id="mainForm" role="form" action="/culture/modify" method="post">
										<input type="hidden" name="mno" value="${culture.mno}" />
										<input type="hidden" name="cno" value="${culture.cno }" />
										<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
										<input type="hidden" name="amount" value="${cri.amount}" />
										<input type="hidden" name="type" value="${cri.type}" />
										<input type="hidden" name="keyword" value="${cri.keyword}" />
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									        <div class="form-group">
                                                <label class="small mb-1" for="cdate">날짜<medium class="invalid">*</medium></label>
												<fmt:parseDate value="${culture.cdate}" var="cdate" pattern="yyyy-MM-dd"/>
                                                <input class="form-control py-4 chk" name="cdate" id="cdate" type="date" value='<fmt:formatDate value="${cdate}" pattern="yyyy-MM-dd"/>'/>
                                            </div>
                                           	<div class="form-group">
                                            	<label class="small mb-1" for="kind">종류<medium class="invalid">*</medium></label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="1" <c:if test="${culture.kind eq 1}"><c:out value="checked"/></c:if>>공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="2" <c:if test="${culture.kind eq 2}"><c:out value="checked"/></c:if>>영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="3" <c:if test="${culture.kind eq 3}"><c:out value="checked"/></c:if>>독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="4" <c:if test="${culture.kind eq 4}"><c:out value="checked"/></c:if>>관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="5" <c:if test="${culture.kind eq 5}"><c:out value="checked"/></c:if>>스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input chk" name="kind" value="6" <c:if test="${culture.kind eq 6}"><c:out value="checked"/></c:if>>기타
														</label>
													</div><br>
													<small class="kind"></small>
												</div>																																																							                                            			
                                            </div>
                                           <div class="form-group">
                                                <label class="small mb-1" for="title">제목<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4 chk" name="title" id="title" type="text" value="${culture.title}"/>
                                            	<small></small>
                                            </div>
                                            <div class="form-group">
                                            	<label class="small mb-1" for="rank">평점</label>
                                            	<input type="hidden" name="rank" value="${culture.rank}" />
                                            	<div id="rank"> 
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="1" <c:if test="${culture.rank eq 1}"><c:out value="checked"/></c:if>>1점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="2" <c:if test="${culture.rank eq 2}"><c:out value="checked"/></c:if>>2점
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="3" <c:if test="${culture.rank eq 3}"><c:out value="checked"/></c:if>>3점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="4" <c:if test="${culture.rank eq 4}"><c:out value="checked"/></c:if>>4점
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="crank" value="5" <c:if test="${culture.rank eq 5}"><c:out value="checked"/></c:if>>5점
														</label>
													</div>	
												</div>																																																							                                            			
                                            </div>
											<div class="form-group">
                                                <label class="small mb-1" for="content">내용</label>
                                                <textarea class="form-control" name="content" rows="5" id="content">${culture.content}</textarea>
											</div>
											<div class="form-group uploadDiv">
												<label class="small mb-1" for="upload">사진첨부</label>
												<input type="file" id="upload" name="upload" data-folder="culture" multiple />
											</div>
											<div class="form-group uploadResult">
												<ul class="list-group list-group-horizontal"></ul>
											</div>
						                    <div class="form-group">
                                            	<label class="small mb-1" for="open">공개여부</label>
                                            	<div id="open">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="open" value="0" <c:if test="${culture.open eq '0'}">checked</c:if>>비공개
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="open" value="1" <c:if test="${culture.open eq '1'}">checked</c:if>>멤버공개
														</label>
													</div>
												    <div class="form-check-inline">
														<label class="form-check-label">
															<input type="radio" class="form-check-input" name="open" value="2" <c:if test="${culture.open eq '2'}">checked</c:if>>전체공개
														</label>
													</div>
												</div>																																																							                                            			
                                            </div>	
                                            <div class="form-group mt-4 mb-0 text-right">
                                            	<sec:authentication property="principal" var="pinfo"/>
                                             	<sec:authorize access="isAuthenticated()">
                                             		<c:if test="${pinfo.member.mno eq culture.mno || fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
                                            			<button type="button" class="btn btn-primary" data-oper="modify">수정</button>
                                            		</c:if>
                                            	</sec:authorize>
												<button type="button" class="btn btn-secondary"  data-oper="list">목록</button>
                                            </div>
                              		</form> <!-- form 끝  -->                            
                             </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->   
<div class="originPictureWrapper"><div class="originPicture"></div></div>                 	
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
	var formObj = $("#mainForm"); 
	var mno = '<sec:authentication property="principal.member.mno"/>'; 
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";
	
	 var auth = null; 

	 <sec:authorize access="isAuthenticated()">
		auth = '<sec:authentication property="principal.member.authList" />';
	 </sec:authorize>	
	 if(auth.includes("ADMIN")) mno = "0";		
	
	
	$(".chk").blur(function(e){
		cultureService.validate($(this));	
	});
	
	<spring:hasBindErrors name="culture">
	hasErrors();
	</spring:hasBindErrors>			
	
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
 
	
	 $(".originPictureWrapper").on("click", function(e){
			$(".originPicture").animate({width:'0%', height:'0%'}, 1000); 
			setTimeout(function(){
				$(".originPictureWrapper").hide();
			},1000);
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
		console.log(oper);
		if(oper === "modify"){
			if(confirm("수정하시겠습니까?")){
				var str="";
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].path' value='"+jobj.data("path")+"' />";
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].fileName' value='"+jobj.data("filename")+"'/>"; 
					str+="<input type='hidden' name='attachList[0].fileList["+i+"].fileType' value='"+jobj.data("type")+"'/>";
				});
				
				str+="<input type='hidden' name='object' value='"+mno+"' />"; 
				
				$(".chk").each(function(e){
					cultureService.validate($(this));	
				});
				
				if(!checkItem($("input[name='cdate']"))) return false;
				if(!checkItem($("input[name='kind']"))) return false;
				if(!checkItem($("input[name='title']"))) return false;
				
				
				var crank = $("input[name='crank']:checked"); 
				if(crank.length > 0){
					$("input[name='rank']").val(crank.val()); 
				}
					
				formObj.append(str).submit();
			}
		}else{
			formObj.attr("action", "/culture/list/"+mno).attr("method", "get"); 
			var pageNum = formObj.find("input[name='pageNum']"); 
			var amount = formObj.find("input[name='amount']"); 
			var type = formObj.find("input[name='type']");   
			var keyword = formObj.find("input[name='keyword']"); 
			
			formObj.empty(); 
			formObj.append(pageNum); 
			formObj.append(amount); 
			formObj.append(type);
			formObj.append(keyword);
			formObj.submit();
		}
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
		$(".chk").each(function(){
			console.log($(this));
			cultureService.validate($(this));	
		}); 	
	}	
	
	
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>