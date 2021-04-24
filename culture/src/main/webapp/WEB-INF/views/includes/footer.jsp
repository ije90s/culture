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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/dist/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script>
        $(document).ready(function(){
        	$("#searchBtn").click(function(e){
        		e.preventDefault();
        		$("#searchTotalForm").submit(); 
        	});
        	$("#searchText").keyup(function(e){
        		if(e.keyCode==13)
        			$("#searchTotalForm").submit(); 
        	});
        	


			var checkId = null; 
        	var sock = new SockJS("http://localhost:7080/echo");

        	<sec:authorize access="isAuthenticated()">
			checkId = '<sec:authentication property="principal.username" />'; 
		    </sec:authorize>
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
            			str+="<a class='dropdown-item' href='/member/messageDetail?mno="+arr[i].mno+"'>";
            			str+='<div><span class="pull-right badge badge-pill badge-primary read-check">From</span> ';
            			str+='<strong>'+arr[i].sender+'</strong></div>'; 
            			str+='<div>'+message+'</div></a>'; 
            			str+='<div class="dropdown-divider"></div>';        		
        			}
        			str+='<a class="dropdown-item" href="/member/message">더보기</a>';
					$("#notReadList").html(str);
        		}); 
        	})();
        	
        });

        </script>
    </body>
</html>