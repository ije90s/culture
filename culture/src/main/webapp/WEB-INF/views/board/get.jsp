<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ include file="../includes/header.jsp"  %>
					<style>
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
                        <h3 class="mt-4">
                         <c:if test="${board.kind eq 'notice' }">공지사항</c:if>
	                     <c:if test="${board.kind eq 'free' }">자유게시판</c:if>
	                     <c:if test="${board.kind eq 'question' }">질문&답변</c:if>
	                     <c:if test="${board.kind eq 'share' }">공유마당</c:if> 상세</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">                            
                            	<div class="form-group">
                                	<label class="small mb-1" for="title">제목 </label>
                                    <input class="form-control py-4" name="title" id="title" type="text" value='${board.title}' readonly/>
                                </div>
                                <div class="form-group">
                                	<label class="small mb-1" for="content">내용</label>
                                    <textarea class="form-control" name="content" rows="5" id="content" readonly>${board.content}</textarea>
								</div>
								<div class="form-group uploadResult">
									<ul class="list-group list-group-horizontal"></ul>
								</div>
                                <div class="form-group mt-4 mb-0 text-right">
                                	<sec:authentication property="principal" var="pinfo"/>
                                	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
                                			<button type="button" class="btn btn-success" data-oper="reply">답글</button>
                                		<c:if test="${pinfo.username eq board.writer || fn:contains(pinfo.member.authList, 'ROLE_ADMIN')}">
		                                    <button type="button" class="btn btn-primary" data-oper="modify">수정</button>
		                                    <button type="button" class="btn btn-danger" data-oper="remove">삭제</button>
	                                    </c:if>
                                    </sec:authorize>
									<button type="button" class="btn btn-secondary"  data-oper="list" data-kind="${board.kind}">목록</button>
                                </div>                  				
                            </div> <!-- card-body 끝  -->
                            <!-- 댓글 시작 -->
                            <div class="card-header">
                            	<div>
	                            	<i class="fa fa-comments fa-fw"></i> 댓글
	                           		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')">
	                             		<button id="regBtn" class="btn btn-secondary float-right">새글</button>
	                             	</sec:authorize>
                             	</div>
                             	<div><h6>* 원댓글을 삭제하면 모든 답댓글이 삭제됩니다.</h6></div>
                            </div>
                            <div class="card-body"> 
                            	<ul class="chat list-group list-group-flush">
                            		<li class="list-group-item" data-rno="12">
                            			<div>
                            				<div class="header">
                            					<strong class="primary-font">user00</strong>
                            					<small class="float-right text-muted">2021-01-01 13:13</small>
                            				</div>
                            				<p>Good job!</p>
                            			</div>
                            		</li>                            		
                            	</ul>
                            </div> <!-- card-body 끝  -->
                            <div class="card-footer">
                            
                            </div> <!-- card-footer 끝  -->
                            <!-- 댓글 끝 -->
                            
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->
<div class="originPictureWrapper">
	<div class="originPicture"></div>
</div>                	 
<form id="mainFrom" role="form" method="get">
	<input type="hidden" name="bno" value="${board.bno}" />
	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
	<input type="hidden" name="amount" value="${cri.amount}" />
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>           
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
     	<div class="form-group reply">
     		<label>댓글</label>
     		<input class="form-control" name="reply" />
     	</div>
   		<div class="form-group">
     		<label>아이디</label>
     		<input class="form-control" name="replyer" readonly />
     	</div>
     	<div>
  			<label>작성일</label>
     		<input class="form-control" name="rdate" />   	
     	</div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-success" id="reBtn">답댓글</button>
      	<button type="button" class="btn btn-warning" id="modBtn">수정</button>
      	<button type="button" class="btn btn-danger" id="delBtn">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->     
<script src="/resources/scripts/reply.js"></script>      
<script src="/resources/scripts/common.js"></script>	  
<script>


$(document).ready(function(){
	var form = $("#mainFrom"); 
	
	history.pushState(null, null, location.href);
	console.log(history.state);
	window.onpopstate = function(event) {
	    history.go(1);
	};

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
						
						str+="<li class='list-group-item' data-path='"+attach.path+"'";
						str+=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'>";
						str+="<div>";
						str+="<img src='/display?fileName="+fileCallPath+"' />";
						str+="</div></li>"; 
					}
				});
				$(".uploadResult ul").html(str);
			});
	 })();	 
	 
	$(".uploadResult").on("click", "li", function(e){
		console.log("clicked");
		var liObj = $(this); 
		var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename")); 
	 	showImg(path.replace(new RegExp(/\\/g),"/"));
	});	
	
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper"); 
		//console.log(oper);
		if(oper === "modify"){
			form.attr("action", "/board/modify").submit();
		}else if(oper === "remove"){
			form.append('<input type="hidden" name="writer" value="${board.writer}" />');
			form.append('<input type="hidden" id="${_csrf.parameterName}" name="${_csrf.parameterName}" value="${_csrf.token}" />');
			form.attr("method", "post").attr("action", "/board/remove").submit();
		}else if(oper === "list"){
			var kind = $(this).data("kind"); 
			form.find("input[name='bno']").remove();
			form.attr("action", "/board/list/"+kind).submit();
		}else if(oper == "reply"){
			var level="${board.level}"; 
			form.append('<input type="hidden" name="kind" value="${board.kind}"/>');
			form.append('<input type="hidden" name="refno" value="${board.bno}" />'); 
			form.attr("action", "/board/register").submit(); 
		}
	});
		
	var bnoValue = '<c:out value="${board.bno}"/>'; 
	var replyUL = $(".chat"); 
	var pageNum = 1; 
	var replyPageFooter = $(".card-footer"); 
	showList(1); 
	function showList(page){
		
		console.log("show list "+ page);
		replyService.getListPaging({bno:bnoValue, page:page||1}, function(replyCnt, list){
			
			console.log("replyCnt:"+replyCnt); 
			console.log("list:"+list);
			console.log(list); 
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0); 
				showList(pageNum); 
				return; 
			}
			
			var str=""; 
			 
			for(var i=0;i<list.length;i++){
				var strLevel="";
				var strStep="";
				
				for(var j=1;j<list[i].level;j++){
					strStep+="&nbsp;&nbsp";
				}
				if(list[i].level > 1){
					strLevel+="<i class='fab fa-replyd'></i> ";
				}
				str+="<li class='list-group-item' data-rno='"+list[i].rno+"'>";
				str+="<div><div class='header'>";
				str+=strStep+strLevel+"<strong class='primary-font'>"+list[i].replyer+"</strong>";
				str+="<small class='float-right text-muted'>"+replyService.displyTime(list[i].rdate)+"</small></div>";
				str+="<p>"+strStep+list[i].reply+"</p></div>";	
				str+="</li>";
			}
			replyUL.html(str); 
			showReplyPage(replyCnt);
		});
	}

	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum/10.0)*10; 
		var startNum = endNum -9; 
		
		var prev = startNum != 1; 
		var next = false; 
				
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0); 
		}
		
		if(endNum* 10 < replyCnt){
			next = true; 
		}
		
		var str = "<ul class='pagination float-right'>"; 
		
		if(prev){
			str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
		}
		
		for(var i=startNum;i<=endNum;i++){
			var active = pageNum==i?"active":""; 
			str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
		}
		str+="</ul>";
		
		console.log(str); 
		replyPageFooter.html(str);
	}		
	
	
	var replyer = null; 
	var auth = null; 
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username" />'; 
		auth = '<sec:authentication property="principal.member.authList" />';
	</sec:authorize>
	var modal = $(".modal"); 
	var modalReply = $(".modal").find("input[name='reply']"); 
	var modalReplyer = $(".modal").find("input[name='replyer']"); 
	var modalRdate = $(".modal").find("input[name='rdate']"); 
	var modalModBtn = $("#modBtn"); 
	var modalDelBtn = $("#delBtn"); 
	var modalReBtn = $("#reBtn"); 
	
	var csrfHeader = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});
	
	$("#regBtn").click(function(){
		modalReply.val(""); 
		modalReplyer.val(replyer);
		modalRdate.closest("div").hide(); 
		modal.find(modalDelBtn).hide(); 
		modal.find(modalReBtn).hide();
		modal.find(modalModBtn).text("등록").show();
		modal.data("rno", 0); 
		$(".modal").modal("show");
	});
	
	modalModBtn.on("click",function(){
		
		var rno = modal.data("rno"); 
		var text = $(this).text(); 
		var reply; 
		
		if(text=="수정"){
			
			var origin = modalReplyer.val(); 
			
			reply={
					reply : modalReply.val(),
					replyer : origin, 
					rno : rno
				};
			
			if(!replyer){
				alert("로그인후 수정이 가능합니다.");
				modal.modal("hide"); 
				return;
			}
			
			//console.log("origin : "+ origin); 
			if(origin!=replyer && !auth.includes("ADMIN")){
				alert("자신이 작성한 댓글만 수정이 가능합니다."); 
				modal.modal("hide"); 
				return; 
			}			
			
			replyService.modify(reply, function(result){
				alert("수정되었습니다."); 
				modal.modal("hide"); 
				showList(pageNum);
			});					
		}else if(text=="등록"){
			
			reply = {
					reply : modalReply.val(), 
					replyer : modalReplyer.val(), 
					bno : bnoValue, 
					refno : 0
			};
					
			replyService.add(reply, function(result){
				alert("등록되었습니다."); 
				
				//modal.find("input").val(""); 
				modal.modal("hide");
				showList(-1);
			});			
		}else{
			
			reply = {
					reply : modalReply.val(), 
					replyer : modalReplyer.val(), 
					bno : bnoValue, 
					refno : rno
			};
			console.log(reply);
			
			if(auth.includes("USER")){
				alert("답글 쓸수 있는 권한이 없습니다."); 
				modal.modal("hide"); 
				return; 
			}	
					
			replyService.add(reply, function(result){
				alert("등록되었습니다."); 
				modal.modal("hide");
				showList(pageNum);
			});					
		}

	});
	
	modalDelBtn.on("click", function(e){
		
		e.preventDefault();
		
		var rno = modal.data("rno"); 
		
		if(!replyer){
			alert("로그인후 삭제가 가능합니다."); 
			modal.modal("hide"); 
			return;
		}
		
		var origin = modalReplyer.val(); 
		
		if(replyer != origin && !auth.includes("ADMIN")){
			alert("자신이 작성한 댓글만 삭제 가능합니다."); 
			modal.modal("hide"); 
			return; 
		}
		
		replyService.remove(rno, origin, function(result){
			alert("삭제되었습니다."); 
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	modalReBtn.on("click", function(e){
		e.preventDefault();
		modalReply.val(""); 
		modalReplyer.val(replyer);
		modalRdate.closest("div").hide(); 
		modal.find(modalDelBtn).hide(); 
		modal.find(modalModBtn).text("답글").show();
		modal.find(modalReBtn).hide();
		$(".modal").modal("show");	
	});
		
	$(".chat").on("click", "li", function(e){
		var rno = $(this).data("rno"); 

		replyService.get(rno, function(data){
			modalReply.val(data.reply); 
			modalReplyer.val(data.replyer); 
			modalRdate.attr("readonly", "readonly").val(replyService.displyTime(data.rdate));
			modal.data("rno", data.rno); 
			modal.find(modalModBtn).text("수정").show();
			modal.find(modalReBtn).show();
			modal.find(modalDelBtn).show(); 
			$(".modal").modal("show");
		});
	});
		
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault(); 
		console.log("page click"); 
		
		var targetPageNum = $(this).attr("href"); 
		
		console.log("targetPageNum : "+targetPageNum);
		pageNum = targetPageNum;
		showList(targetPageNum);
	});

	
	 $(".originPictureWrapper").on("click", function(e){
			$(".originPicture").animate({width:'0%', height:'0%'}, 1000); 
			setTimeout(function(){
				$(".originPictureWrapper").hide();
			},1000);
		 });	
});
</script>                	
<%@ include file="../includes/footer.jsp"  %> 