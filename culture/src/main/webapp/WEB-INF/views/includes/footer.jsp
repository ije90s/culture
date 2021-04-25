<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
   
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2020</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>  
<!-- The Modal -->
<div class="modal fade" id="myMessage" role="dialog">
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
      	<button type="button" class="btn btn-success reBtn">답장</button>
      	<button type="button" class="btn btn-warning regBtn">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 --> 	        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/dist/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script>
        var checkId = null;
        <sec:authorize access="isAuthenticated()">
		checkId = '<sec:authentication property="principal.username" />'; 
	    </sec:authorize>
	    
		var msgModal = $("#myMessage"); 
		var msgSender = msgModal.find("input[name='sender']");
		var msgTarget = msgModal.find("input[name='target']"); 
		var msgMessage = msgModal.find("input[name='message']"); 
		var msgReBtn = msgModal.find(".reBtn");
		var msgRegBtn = msgModal.find(".regBtn");
		
        $(document).ready(function(){
        	$("#searchBtn").click(function(e){
        		e.preventDefault();
        		$("#searchTotalForm").submit(); 
        	});
        	$("#searchText").keyup(function(e){
        		if(e.keyCode==13)
        			$("#searchTotalForm").submit(); 
        	});
        
        	var sock = new SockJS("http://localhost:7080/echo");	
        	if(checkId!=null)
        		connectWS();
        	
        	function connectWS(){
        		sock.onopen = function() {
        	    	console.log('연결 시작');
        	    };
        	    sock.onmessage = function(e){
        	    	var splitdata =e.data.split(":");
        	        
        	    	if(splitdata[0].indexOf("chkMsg") > -1)
        	    		if(parseInt(splitdata[1])==0){
        	    			 $(".alert-num").hide();
        	    		}else{
        	    			 $(".alert-num").text(splitdata[1].trim());
        	    		}
        	        else
        	            $(".alert-num").hide();
        	        }
        	        
        	    	sock.onclose = function(){
        	           console.log("연결 종료");
        	        }
        	        sock.onerror = function (err) {console.log('Errors : ' , err);};
        	}
        	
        	(function(){
        		$.getJSON("/message/notRead/"+checkId, function(arr){
        			
        			//console.log(arr);
        			var str=""; 
        			
        			if(arr==null && arr.length==0){
        				return; 
        			}
        			for(var i=0;i<arr.length;i++){
        				var message = arr[i].message; 
        				if(message.length>10) message=message.substr(0,10)+"…";
            			//str+="<a class='dropdown-item' href='/member/messageDetail?mno="+arr[i].mno+"'>";
            			str+="<a class='dropdown-item' href='javascript:msgCheck("+arr[i].mno+")'>";
            			str+='<div><span class="pull-right badge badge-pill badge-primary read-check">From</span> ';
            			str+='<strong>'+arr[i].sender+'</strong></div>'; 
            			str+='<div>'+message+'</div></a>'; 
            			str+='<div class="dropdown-divider"></div>';        		
        			}
        			str+='<a class="dropdown-item" href="/member/message">더보기</a>';
					$("#notReadList").html(str);
        		}); 
        	})();
        
        	msgReBtn.on("click", function(e){
        		var sender = msgSender.val(); 
        		var target = msgTarget.val();
				msgSender.val(target); 
				msgTarget.val(sender); 
				msgMessage.val(""); 
				msgReBtn.hide(); 
				msgRegBtn.show();         		
        	});
        	
        	msgRegBtn.on("click", function(e){
        		e.preventDefault(); 
        		var msg = {
        			sender : msgSender.val(), 
        			target : msgTarget.val(), 
        			message : msgMessage.val(), 
        			refno : 0 
        		};
        		
        		var csrfHeaderName ="${_csrf.headerName}"; 
        		var csrfTokenValue = "${_csrf.token}";
        		
        		(function(){
        			$.ajax({
        				type : 'post', 
        				url : '/message/new', 
        				data : JSON.stringify(msg), 
        				contentType : "application/json; charset=UTF-8", 
        				beforeSend : function(xhr){
        					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        				},
        				success : function(result, status, xhr){
        					if(result){
        						 alert("답변 완료되었습니다.");
        						 msgModal.modal("hide");
        						 location.reload();
        					}
        				}, 
        				error : function(xhr, status, er){
        					if(error){
        						error(xhr);
        					}
        				}
        			});	
        		})();
        	});
        });
        
		function msgCheck(mno){
    		(function(){
    			$.getJSON("/message/"+mno+"/"+checkId, function(result){
    				msgSender.attr("readonly", "readonly").val(result.sender); 
    				msgTarget.attr("readonly", "readonly").val(result.target); 
    				msgMessage.val(result.message); 
    				msgReBtn.show(); 
    				msgRegBtn.hide(); 
    				msgModal.data("mno", mno);
    				msgModal.modal("show"); 
    			});
    		})();
    	}
        </script>
    </body>
</html>