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
			        .valid{color:green !important;}
			        </style>
					<div class="container">
						<h3 class="mt-4">회원정보</h3>
						<div class="card mb-4">
                            <div class="card-header">
                            	<div class="float-right"> 
	                            	<ul class="list-group list-group-horizontal">
	                            		<li class="list-group-item"><a class="move" href="modify">정보수정</a></li>
	                            		<li class="list-group-item"><a class="move" href="changePw">비밀번호변경</a></li>
	                            		<li class="list-group-item"><a class="move" href="logout">로그아웃</a></li>
	                            		<li class="list-group-item"><a class="move" href="unjoin">회원탈퇴</a></li>
	                            	</ul>
                            	</div>
                            </div>
                            <div class="card-body">
                            	<div class="form-group uploadDiv text-center">
                            		<div class="uploadResult">
	                            		<i class="fa fa-window-close deletePhoto" style="position:absolute; cursor:pointer;"></i>
	                            		<img class="rounded-circle photo">
                            		</div>
									<input type="file" id="upload" name="upload" data-folder="member" style="display:none;" />
									<i class="fas fa-user fa-fw photo default" style="font-size:200px; cursor:pointer;"></i>
								</div>
                            	<div class="form-group">
                                	<label class="small mb-1" for="name">이름</label>
                                    <input class="form-control py-4" id="name" type="text" value='${member.name}' readonly/>
                                </div>
                            	<div class="form-group">
                                	<label class="small mb-1" for="phone">휴대폰</label>
                                    <input class="form-control py-4" id="phone" type="text" value='${member.phone}' readonly/>
                                </div>
                            	<div class="form-group">
                                	<label class="small mb-1" for="email">이메일</label>
                                    <input class="form-control py-4" id="email" type="text" value='${member.email}' readonly/>
                                </div>      
                                <div class="form-group">
                                	<label class="small mb-1" for="favorites">관심사</label>
                                    <div id="favorites">
	                                	<div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites" value="1" <c:if test="${fn:contains(member.favorites, '1')}">checked</c:if>  disabled>공연
											</label>
										</div>
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites" value="2" <c:if test="${fn:contains(member.favorites, '2')}">checked</c:if> disabled>영화
											</label>
										</div>
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites" value="3" <c:if test="${fn:contains(member.favorites, '3')}">checked</c:if> disabled>독서
											</label>
										</div>	
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites" value="4" <c:if test="${fn:contains(member.favorites, '4')}">checked</c:if> disabled>관람
											</label>
										</div>	
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites" value="5" <c:if test="${fn:contains(member.favorites, '5')}">checked</c:if> disabled>스포츠
											</label>
										</div>	
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites" value="6" <c:if test="${fn:contains(member.favorites, '6')}">checked</c:if> disabled>기타
											</label>
										</div>
									</div> <!-- id="favorites" 끝  -->								
                            	</div> <!--  form-group 그룹 끝-->      
                                <div class="form-group modify">
						            <label class="small mb-1" for="open">공개여부</label>
						            <div id="open">
							            <div class="form-check-inline">
							            	<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="open" value="0" <c:if test="${member.open eq '0'}">checked</c:if> disabled>비공개
											</label>
										</div>
							            <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="open" value="1" <c:if test="${member.open eq '1'}">checked</c:if> disabled>멤버공개
											</label>
									    </div>
							            <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="open" value="2" <c:if test="${member.open eq '2'}">checked</c:if> disabled>전체공개
											</label>
									    </div>	
									</div> <!-- id="open" 끝  -->	  
								</div>		                                                  
                            </div> <!-- card-body 끝 -->
                        </div>  <!-- card mb-4 끝 -->
					</div> <!-- container 끝 -->
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
	  
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">처리결과</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body"> 	
      	<input type="hidden" name="id" id="id" value="${member.id}" />
      	<input type="hidden" name="mno" id="mno" value="${member.mno}" />
 		<div class="form-group modify">
     		<label>이름<medium class="invalid">*</medium></label>
     		<input class="form-control chk" name="name" value="${member.name }"/>
     		<small></small>
     	</div>
   		<div class="form-group modify">
     		<label>휴대폰</label>
     		<input class="form-control chk" name="phone" type="phone" value="${member.phone }"/>
     		<small></small>
     	</div>
     	<div class="form-group modify">
  			<label>이메일</label>
     		<input class="form-control chk" name="email" type="email" value="${member.email}"/>   	
     		<small></small>
     	</div>    	
        <div class="form-group modify">
            <label class="small mb-1" for="favorites">관심사</label>
            <input type="hidden" name="favorites" value="${member.favorites}"/>
            <div id="favorites">
	            <div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="checkbox" class="form-check-input" name="favorite" value="1" <c:if test="${fn:contains(member.favorites, '1')}">checked</c:if>>공연
					</label>
				</div>
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" name="favorite" value="2" <c:if test="${fn:contains(member.favorites, '2')}">checked</c:if>>영화
					</label>
			    </div>
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" name="favorite" value="3" <c:if test="${fn:contains(member.favorites, '3')}">checked</c:if>>독서
					</label>
			    </div>	
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" name="favorite" value="4" <c:if test="${fn:contains(member.favorites, '4')}">checked</c:if>>관람
					</label>
				</div>	
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" name="favorite" value="5" <c:if test="${fn:contains(member.favorites, '5')}">checked</c:if>>스포츠
					</label>
				</div>	
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" name="favorite" value="6" <c:if test="${fn:contains(member.favorites, '6')}">checked</c:if>>기타
					</label>
				</div>
			</div> <!-- id="favorites" 끝  -->	  
		</div>
        <div class="form-group modify">
            <label class="small mb-1" for="open">공개여부</label>
            <div id="open">
	            <div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input" name="open" value="0" <c:if test="${member.open eq '0'}">checked</c:if>>비공개
					</label>
				</div>
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="radio" class="form-check-input" name="open" value="1" <c:if test="${member.open eq '1'}">checked</c:if>>멤버공개
					</label>
			    </div>
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="radio" class="form-check-input" name="open" value="2" <c:if test="${member.open eq '2'}">checked</c:if>>전체공개
					</label>
			    </div>	
			</div> <!-- id="open" 끝  -->	  
		</div>		
		<div class="form-group changePw">
  			<label>기존 비밀번호</label>
     		<input class="form-control chk" name="originPw" type="password" value="${member.pw}" readonly/> 
     		<small></small>	  	
     	</div>    	
		<div class="form-group changePw">
  			<label>새 비밀번호<medium class="invalid">*</medium></label>
     		<input class="form-control chk" name="pw" id="pw" type="password"/>   
     		<small></small>	
     	</div>  
		<div class="form-group changePw">
  			<label>새 비밀번호 확인<medium class="invalid">*</medium></label>
     		<input class="form-control chk" name="pw2" id="pw2" type="password"/>   	
			<small></small>     	
     	</div>       	
     	<div class="form-group unjoin">
     		<label class="small mb-1" for="reason">탈퇴사유<medium class="invalid">*</medium></label>
     		<select name="reason" id="reason">
     			<option value="">선택</option>
     			<option value="1">서비스 불만족</option>
     			<option value="2">쓰기 불편</option>
     			<option value="3">개인 불만족</option>
     			<option value="4">사용 자주 하지 않음</option>
     			<option value="5">기타</option>
     		</select>
     		<p><small id="reasonChk"></small></p>
     	</div>
     	<div class="form-group unjoin"> 
     		<label class="small mb-1" for="memo">내용</label>
     		<textarea class="form-control" name="memo" rows="5" id="memo"></textarea>
     	</div>     			
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->       					
<form id="photoForm" method="post" action="/member/modifyPhoto">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="id" value="${member.id}" />
<input type="hidden" name="mno" value="${member.mno}" />
</form>			
<script src="/resources/scripts/common.js"></script>  	
<script src="/resources/scripts/member.js"></script>	
<script>
$(document).ready(function(){
	var csrfHeader = "${_csrf.headerName}"; 
	var csrfToken = "${_csrf.token}";

	(function(){
		var mno = '<c:out value="${member.mno}" />';
		$.getJSON("/member/getAttachList", {mno : mno}, function(arr){
	 	
			if(arr==null || arr.length==0){
				$(".uploadResult").hide();
				return;
			}
			$(arr[0].fileList).each(function(i, attach){
				var fileCallPath = encodeURIComponent(attach.path+"/s_"+attach.uuid+"_"+attach.fileName); 
				$(".uploadResult img").attr('src', '/display?fileName='+fileCallPath).attr("style","width:175px;height:200px;");
				$(".default").hide();	
			});				
		});
	})();	
	
	$(".chk").blur(function(){
		memberService.validate($(this));
	});
	
	var modal = $(".modal"); 
	var modalTitle = $(".modal-title");
	var modalBody = $(".modal-body"); 
	var modalBtn = $(".btn-primary"); 
	$(".move").on("click", function(e){
		e.preventDefault();
		var href = $(this).attr("href"); 
		modal.data("link", href); 
		if(href=="modify"){
			modalTitle.html("정보변경");
			modalBtn.text("수정");
			modal.find(".modify").show(); 
			modal.find(".changePw").hide(); 
			modal.find(".unjoin").hide();
			modal.modal("show"); 
		}else if(href=="changePw"){
			modalTitle.html("비밀번경 변경"); 
			modalBtn.text("수정");
			modal.find(".modify").hide(); 
			modal.find(".changePw").show(); 	
			modal.find(".unjoin").hide();
			modal.modal("show"); 
		}else if(href=="unjoin"){
			modalTitle.html("탈퇴사유"); 
			modalBtn.text("탈퇴");
			modal.find(".modify").hide(); 
			modal.find(".changePw").hide(); 	
			modal.find(".unjoin").show();
			modal.modal("show"); 
		}else{
			if(confirm("로그아웃 하시겠습니까?")){
				$("#logoutForm").submit();
			}
		}
	});	
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});	
	
	var mno = modal.find("input[name='mno']"); 
	var id = modal.find("input[name='id']"); 
	var pw = modal.find("input[name='pw']"); 
	var name = modal.find("input[name='name']"); 
	var phone = modal.find("input[name='phone']"); 
	var email = modal.find("input[name='email']"); 
	var favorites = modal.find("input[name='favorites']");
	var open = modal.find("input[name='open']:checked");
	var originPw = modal.find("input[name='originPw']"); 
	$(".btn-primary").click(function(e){
		e.preventDefault(); 
		var link = modal.data("link");
		var member;
		
		//invalid 한번 더 체크
		$(".chk").each(function(e){
			memberService.validate($(this));
		});	
		
		if(link == "modify"){
			if(!checkItem($("input[name='name']"))) return false;			
			//이메일, 휴대폰번호 체크
			if($("input[name='phone']").val() != "") {	
				if(!checkItem($("input[name='phone']"))) return false;
			}else{$("input[name='phone']").val("");}
			if($("input[name='email']").val() != "") {
				if(!checkItem($("input[name='email']"))) return false;
			}else{$("input[name='email']").val("");}
			
			//체크된 관심사만 저장
			var checked =""; 
			$("input:checkbox[name=favorite]:checked").each(function() {
				checked+=$(this).val()+","; 
			});
			if(checked.includes(",")) checked = checked.substr(0, checked.length-1);
			$("input[name='favorites']").val(checked);	
			
			//공개여부 체크여부 확인
			open = modal.find("input[name='open']:checked").val();
			
			member={
				mno :  mno.val(), 
				id :  id.val(), 
				pw :  originPw.val(), 
				name : name.val(), 
				phone : phone.val(), 
				email : email.val(), 
				favorites : favorites.val(),
				open : open
			};			
			memberService.modify(member,function(data){
				console.log(data);
				alert("수정되었습니다."); 
				modal.modal("hide"); 
				location.reload();
				
			}, function(error){
				alert("입력값을 확인하세요.");
				$(".chk").each(function(){
					memberService.validate($(this));
				})
			});
	
		}else if(link == "changePw"){
			if(!checkItem($("input[name='pw']"))) return false;				
			if(!checkItem($("input[name='pw2']"))) return false;	
			member={
					mno : mno.val(), 
					id : id.val(), 
					pw : pw.val(), 
					name : name.val(), 
					phone : phone.val(), 
					email : email.val(), 
					favorites : favorites.val(),
					open : open.val()
			};
			memberService.changePw(member,function(data){
				console.log(data);
				alert("수정되었습니다."); 
				modal.modal("hide"); 
				location.reload();
				
			}, function(error){
				alert("입력값을 확인하세요.");
				$(".chk").each(function(){
					memberService.validate($(this));
				})
			});
		}else {
			var reason = modal.find("#reason option:selected"); 
			var memo = modal.find("#memo");
			if(reason.val()==""){
				$("#reasonChk").html("항목을 선택하세요."); 
				$("#reasonChk").addClass("invalid"); 
				return false;
			}
			$("#reasonChk").html(""); 
			$("#reasonChk").removeClass();
			member = {
				id : id.val(), 
				reason : reason.val(), 
				memo : memo.val()
			}, 
			memberService.unjoin(member, function(data){
				console.log(data);
				if(data=="success"){
					alert("탈퇴되었습니다."); 
					modal.modal("hide"); 
					$("#logoutForm").submit();
				}	
			}, function(error){
				console.log(error.status); 
			});
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
	
	$(".photo").click(function(e){
		e.preventDefault(); 
		 $("input[name='upload']").click();
	});
	
	$("input[type='file']").change(function(){
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
				showUploadProfile(result);
			}
		});
	});	

	function showUploadProfile(uploadResultArr){
		var str="";  
		$(uploadResultArr).each(function(i, obj){	
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName); 
			var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
			originPath = originPath.replace(new RegExp(/\\/g),"/");  
				
			var files={
					path : obj.uploadPath, 
					uuid : obj.uuid,
					fileName : obj.fileName, 
					fileType : obj.image	
			};
			
			memberService.modifyPhoto(id.val(), files,  function(data){
				alert("프로필 사진이 변경되었습니다."); 
				location.reload();
			});
			
			//$(".uploadResult img").attr('src', '/display?fileName='+fileCallPath).attr("style","width:175px;height:200px;");		
		});
	}	 
	
	$(".uploadResult").on("click", ".deletePhoto", function(e){
		e.preventDefault(); 
		console.log("사진 삭제");
		memberService.deletePhoto(id.val(),  function(data){
			alert("프로필 사진이 삭제되었습니다."); 
			location.reload();
		}); 
	});
	 
});
</script>					
<%@ include file="../includes/footer.jsp"  %>