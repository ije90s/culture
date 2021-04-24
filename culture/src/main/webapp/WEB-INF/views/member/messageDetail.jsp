<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>     
<%@ include file="../includes/header.jsp"  %>
 					<div class="container-fluid">
                        <h3 class="mt-4">쪽지 상세</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">      
                           		<div class="form-group">
                                	<label class="small mb-1" for="sender">보낸사람</label>
                                    <input class="form-control py-4" id="sender" type="text" readonly/>
                                </div>                       
								<div class="form-group">
                                	<label class="small mb-1" for="message">내용</label>
                                    <input class="form-control py-4" id="message" type="text" readonly/>
                                </div>  
                                <div class="form-group mt-4 mb-0 text-right">
									<button type="button" id="reBtn" class="btn btn-success">답장</button>
                                </div>         				
                            </div> <!-- card-body 끝  -->           
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">쪽지</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <div class="form-group">
     		<label>보낸사람</label>
     		<input class="form-control" name="sender" />
     	</div>
     	<div class="form-group">
     		<label>받은사람</label>
     		<input class="form-control" name="target" />
     	</div>
     	<div class="form-group">
     		<label>내용</label>
     		<input class="form-control" name="message" />
     	</div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-warning" id="modBtn">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->    
<script src="/resources/scripts/message.js"></script>	             	
<script>
$(document).ready(function(){
	
	var mno = '<c:out value="${mno}" />';
	var username = null;
	<sec:authorize access="isAuthenticated()">
	username = '<sec:authentication property="principal.username" />'; 
	</sec:authorize>
	
	var csrfHeader = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});
	
	msgService.get(mno, username,  function(data){
		$("#sender").val(data.sender); 
		$("#message").val(data.message);
	});		
	
	var modal = $(".modal"); 
	var modalSender = $(".modal").find("input[name='sender']"); 
	var modalTarget = $(".modal").find("input[name='target']"); 
	var modalMSG = $(".modal").find("input[name='message']"); 
	var modalModBtn = $("#modBtn"); 

	$("#reBtn").click(function(e){
		e.preventDefault(); 
		
		if(!username){
			alert("로그인 이후에 수정 가능합니다.");
			return false; 
		}
		
		msgService.get(mno, username,  function(data){
			modalSender.attr("readonly", "readonly").val(data.target); 
			modalTarget.attr("readonly", "readonly").val(data.sender); 
			modalMSG.val(""); 
			modal.modal("show");
		});		
	});
	
	$("#modBtn").on("click",function(e){
		e.preventDefault(); 
		var msg = {
			sender : modalSender.val(), 
			target : modalTarget.val(),
			message : modalMSG.val(), 
			refno : 0 
		};
		
		if(!username){
			alert("로그인 이후에 수정 가능합니다.");
			return false; 
		}
		
		msgService.add(msg, function(result){
			alert("등록되었습니다.");
			modal.modal("hide"); 
			self.location="/member/message";
		});
	});
});	
</script>  
<%@ include file="../includes/footer.jsp"  %>