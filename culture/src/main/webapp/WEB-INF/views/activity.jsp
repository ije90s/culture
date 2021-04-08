<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ include file="./includes/header.jsp"  %>

	<div class="container-fluid"> 
        <h3 class="mt-4">나의 활동</h3>    
        <div class="row">
        	<div class="col-xl-3 col-md-6">
            	<div class="card bg-primary text-white mb-4">
                	<div id="login" class="card-body"></div>
                    	<div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">로그인</div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-warning text-white mb-4">
                    	<div id="culture" class="card-body"></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">문화기록</div>
                        </div>
                    </div>
                </div>
				<div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white mb-4">
                    	<div id="board" class="card-body"></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">게시판</div>
                        </div>
                    </div>
                </div>                
               <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white mb-4">
                    	<div id="reply" class="card-body"></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">댓글</div>
                        </div>
                     </div>
               </div>
        </div>
        <div class="card mt-4 mb-4">
        	<div class="card-header"><h6>*모든 게시판 또는 댓글이 나옵니다.</h6></div>
            <div class="card-body">
		 		<div class="container">
		     		<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item"><a class="nav-link active" data-toggle="tab" data-tab="aboard" href="#allboard">게시판</a></li>
					    <li class="nav-item"><a class="nav-link" data-toggle="tab" data-tab="areply" href="#allreply">댓글</a></li>
											    
			        </ul>
					<!-- Tab panes -->
				    <div class="tab-content">
				    	<div id="allboard" class="container tab-pane active"><br>
					    <%@ include file="allBoard.jsp"  %>
					    </div>
					    <div id="allreply" class="container tab-pane fade"><br>
					    <%@ include file="allReply.jsp"  %>      
					    </div>						   
				    </div>
		     	</div> 
		    </div>
		 </div>      
	</div> <!-- container-fluid 끝 -->   

<script src="/resources/scripts/home.js"></script>
<script>
$(document).ready(function(){

	var id = null; 
	 <sec:authorize access="isAuthenticated()">
	  id = '<sec:authentication property="principal.username" />';
	 </sec:authorize>	
	  
	homeService.loginCount(id, function(data){
		$("#login").html(data+"건");
	});
	homeService.cultureCount(id, function(data){
		$("#culture").html(data+"건");
	});
	homeService.boardCount(id, function(data){
		$("#board").html(data+"건");
	});
	homeService.replyCount(id, function(data){
		$("#reply").html(data+"건");
	});	
	

	showList("board", 1);
	showList("reply", 1);

	
	$(".btn").click(function(e){
		e.preventDefault();
		var oper = $(this).data("oper");
		var trLen = $("#all"+oper+" tr").length;
		trLen = Math.ceil((parseInt(trLen)-1)/10)+1;
		showList(oper, trLen);
	});
	
	function showList(oper, page){
		if(oper == "board"){
			homeService.getBoardList(id, page, function(list){
				var str=""; 
				
				if(list.length == 0 && page != 1){
					alert("더 이상 없습니다.");
					return; 
				}
				
				for(var i=0;i<list.length;i++){
					str+="<tr><td>"+list[i].bno+"</td><td><a href='/board/get?bno="+list[i].bno+"'>"+list[i].title+"</a></td>";
					str+="<td>"+homeService.displyTime(list[i].rdate)+"</td></tr>"; 
				}
				$("#allboard tbody").append(str);
			});	
		}else{
			homeService.getReplyList(id, page, function(list){
				var str=""; 
				
				if(list.length == 0 && page != 1){
					alert("더 이상 없습니다.");
					return; 
				}
				
				for(var i=0;i<list.length;i++){
					str+="<tr><td>"+list[i].rno+"</td><td><a href='/board/get?bno="+list[i].bno+"'>"+list[i].reply+"</a></td>";
					str+="<td>"+homeService.displyTime(list[i].rdate)+"</td></tr>"; 
				}
				$("#allreply tbody").append(str);
			});			
		}
	}
	
});
</script>	
<%@ include file="./includes/footer.jsp"  %>