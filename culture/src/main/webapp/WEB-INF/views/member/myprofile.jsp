<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ include file="../includes/header.jsp"  %>
					<div class="container">
						<h1>회원정보</h1>
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
                            	<div>사진</div>
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
											<input type="checkbox" class="form-check-input" name="favorites1" value="1"  disabled>공연
											</label>
										</div>
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites2" value="2" disabled>영화
											</label>
										</div>
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites3" value="3" disabled>독서
											</label>
										</div>	
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites4" value="4" disabled>관람
											</label>
										</div>	
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites5" value="5" disabled>스포츠
											</label>
										</div>	
	                                    <div class="form-check-inline">
											<label class="form-check-label">
											<input type="checkbox" class="form-check-input" name="favorites6" value="6" disabled>기타
											</label>
										</div>
									</div> <!-- id="favorites" 끝  -->								
                            	</div> <!--  form-group 그룹 끝-->                                                        
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
      	<form method="post">
      	<input type="hidden" name="mno" value="${member.mno }" />
      	<input type="hidden" name="id" value="${member.id }" />
      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 		<div class="form-group modify">
     		<label>이름</label>
     		<input class="form-control" name="name" value="${member.name }"/>
     	</div>
   		<div class="form-group modify">
     		<label>휴대폰</label>
     		<input class="form-control" name="phone" value="${member.phone }"/>
     	</div>
     	<div class="form-group modify">
  			<label>이메일</label>
     		<input class="form-control" name="email" value="${member.email }"/>   	
     	</div>    	
        <div class="form-group modify">
            <label class="small mb-1" for="favorites">관심사</label>
            <div id="favorites">
	            <div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="favorites1" name="favorites" value="1">공연
					</label>
				</div>
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="favorites2" name="favorites" value="2">영화
					</label>
			    </div>
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="favorites3" name="favorites" value="3">독서
					</label>
			    </div>	
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="favorites4" name="favorites" value="4">관람
					</label>
				</div>	
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="favorites5" name="favorites" value="5">스포츠
					</label>
				</div>	
	            <div class="form-check-inline">
					<label class="form-check-label">
					<input type="checkbox" class="form-check-input" id="favorites6" name="favorites" value="6">기타
					</label>
				</div>
			</div> <!-- id="favorites" 끝  -->	  
		</div>
		<div class="form-group changePw">
  			<label>기존 비밀번호</label>
     		<input class="form-control" name="originPw" type="password" value="${member.pw}" readonly/>   	
     	</div>    	
		<div class="form-group changePw">
  			<label>새 비밀번호</label>
     		<input class="form-control" name="pw" type="password"/>   	
     	</div>  
		<div class="form-group changePw">
  			<label>새 비밀번호 확인</label>
     		<input class="form-control" name="pwConfirm" type="password"/>   	
     	</div> 
     	<div id="chkPw" class="changePw"></div>      	
     	<div class="form-group unjoin">
     		<label class="small mb-1" for="reason">탈퇴사유</label>
     		<select name="reason" id="reason">
     			<option value="">선택</option>
     			<option value="1">서비스 불만족</option>
     			<option value="2">쓰기 불편</option>
     			<option value="3">개인 불만족</option>
     			<option value="4">사용 자주 하지 않음</option>
     			<option value="5">기타</option>
     		</select>
     	</div>
     	<div class="form-group unjoin"> 
     		<label class="small mb-1" for="memo">내용</label>
     		<textarea class="form-control" name="memo" rows="5" id="memo"></textarea>
     	</div>     			
		</form>   	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-warning">수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->       					
					
<script>
$(document).ready(function(){
	var favorites = '<c:out value="${member.favorites}" />';
	showFavorte('main', favorites);
	function showFavorte(tab, favorites){
		
		for(var i=1; i<7;i++){
			if(favorites.includes(i)){
				if(tab == "main"){
					$("input[name='favorites"+i+"']").attr("checked", true);
				}else{
					$("#favorites"+i).attr("checked", true);
				}
				
			}
		}		
	}
	var modal = $(".modal"); 
	var modalTitle = $(".modal-title");
	var modalBody = $(".modal-body"); 
	var modalBtn = $(".btn-warning"); 
	$(".move").on("click", function(e){
		e.preventDefault();
		var href = $(this).attr("href"); 
		modal.data("link", href); 
		if(href=="modify"){
			modalTitle.html("정보변경");
			showFavorte("modal", favorites);
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
	
	var form = $("form"); 
	var pw = modal.find("input[name='pw']"); 
	var pwConfirm = modal.find("input[name='pwConfirm']");
	$(".btn").on("click",function(e){
		e.preventDefault(); 
		var link = modal.data("link");
		var msg = ""; 
		if(link == "modify"){
			msg = "수정하시겠습니까?"; 
		}else if(link == "changePw"){
			msg = "변경하시겠습니까?"; 
		}else {
			msg = "탈퇴하시겠습니까?"; 
		}
		if(confirm(msg)){
			form.attr("action", "/member/"+link).submit();
		}
		
	});
	
	pw.on("blur", function(e){
		if($(this).val() == ""){
			$("#chkPw").html("새 비밀번호 또는 새 비밀번호확인을 입력하세요.");
		}
	});
	pwConfirm.on("blur", function(e){
		if($(this).val() == ""){
			$("#chkPw").html("새 비밀번호 또는 새 비밀번호확인을 입력하세요.");
		}
		
		if(pw.val()!=pwConfirm.val()){
			$("#chkPw").html("새 비밀번호와 확인이 일치하지 않습니다.");
		}else{
			$("#chkPw").html("새 비밀번호 등록 가능합니다.");
		}
	});	
});
</script>					
<%@ include file="../includes/footer.jsp"  %>