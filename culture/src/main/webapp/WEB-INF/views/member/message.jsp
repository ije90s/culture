<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="../includes/header.jsp"  %>
					<div class="container">
						<h3 class="mt-4">내 쪽지함</h3>
						<div class="card mt-4 mb-4">
                            <div class="card-header">
                            	<div class="float-right"> 
	                            	<ul class="list-group list-group-horizontal">
	                            		<li class="list-group-item"><a class="move" href="T">받은쪽지</a></li>
	                            		<li class="list-group-item"><a class="move" href="S">보낸쪽지</a></li>
	                            	</ul>
                            	</div>
                            </div>
                            <div class="card-body">
                            	<div class="table-responsive">
                            	<table id="mtable" class="table table-bordered" width="100%" cellspacing="0">
								</table>
                            	</div>
                            </div> <!-- card-body 끝 -->
                            <div class="card-footer"></div> <!-- card-footer 끝  -->
                        </div>  <!-- card mb-4 끝 -->
					</div> <!-- container 끝 -->
					
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
      	<button type="button" class="btn btn-success" id="reBtn">답장</button>
      	<button type="button" class="btn btn-warning" id="modBtn">수정</button>
      	<button type="button" class="btn btn-danger" id="delBtn">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 --> 			
<script src="/resources/scripts/message.js"></script>					
<script>
$(document).ready(function(){
	var table =$("#mtable"); 
	var username = null; 
	var pageNum=1; 
	var type = "T"; 
	var msgPageFooter = $(".card-footer"); 
	<sec:authorize access="isAuthenticated()">
	username = '<sec:authentication property="principal.username" />'; 
	</sec:authorize>
	
	showList(type, 1);
	
	function showList(tab, page){
		var str=""; 
		//table.html("");
		type = tab;
		if(type=="T"){
			str+="<thead><tr><td>NO.</td><td>보낸사람</td><td>내용</td><td>보낸날짜</td></tr></thead><tbody>"; 
		}else{
			str+="<thead><tr><td>NO.</td><td>받은사람</td><td>내용</td><td>보낸날짜</td><td>읽음</td></tr></thead><tboyd>"; 
		}
		msgService.getList(type, username, page, function(msgCnt, list){	
			if(list==null || list.length==0){
				str+="<tr><td colspan='5'>받은 쪽지가 없습니다.</td></tr>";
				return; 
			}
			
			for(var i=0;i<list.length;i++){
				var readchk = ""; 
				var user=list[i].sender; 
				if(type!="T") user=list[i].target;
				if(list[i].odate!=null) readchk="읽음";
				
				str+="<tr mno='"+list[i].mno+"' style='cursor:pointer;'><td>"+list[i].mno+"</td><td>"+user+"</td><td>"+list[i].message+"</td><td>"+msgService.displyTime(list[i].sdate)+"</td>";
				if(type!="T") 
					str+="<td>"+readchk+"</td>";
				str+="</tr>";
			}
			str+="</tbody>";
			table.html(str); 
			showMsgPage(msgCnt);
		});	
	}
	
	
	//페이징
	function showMsgPage(msgCnt){
		var endNum = Math.ceil(pageNum/10.0)*10; 
		var startNum = endNum -9; 
		
		var prev = startNum != 1; 
		var next = false; 
				
		if(endNum * 10 >= msgCnt){
			endNum = Math.ceil(msgCnt/10.0); 
		}
		
		if(endNum* 10 < msgCnt){
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
		
		//console.log(str); 
		msgPageFooter.html(str);
	}	
	
	var modal = $(".modal"); 
	var modalSender = $(".modal").find("input[name='sender']"); 
	var modalTarget = $(".modal").find("input[name='target']"); 
	var modalMSG = $(".modal").find("input[name='message']"); 
	var modalModBtn = $("#modBtn"); 
	var modalDelBtn = $("#delBtn"); 
	var modalReBtn = $("#reBtn"); 	
	
	var csrfHeader = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});
	
	$(".move").on("click", function(e){
		e.preventDefault(); 
		var href=$(this).attr("href"); 
		pageNum=1;
		showList(href, pageNum);
	});
	
	$("#mtable").on("click", "tr", function(e){
		
		var mno = $(this).attr("mno"); 
		if(!username){
			alert("로그인 이후에 수정 가능합니다.");
			return false; 
		}
		
		msgService.get(mno, username,  function(data){
			modalSender.attr("readonly", "readonly").val(data.sender); 
			modalTarget.attr("readonly", "readonly").val(data.target); 
			modalMSG.val(data.message);
			modal.data("mno", mno); 
			if(type=="T"){
				modal.find(modalReBtn).show(); 
				if(data.cno!=0) modal.find(modalReBtn).hide(); 
				modal.find(modalModBtn).hide();
			}else{
				modal.find(modalReBtn).hide(); 
				modal.find(modalModBtn).text("수정").show();
				if(data.odate!=null) modal.find(modalModBtn).hide();
			}
			modal.find(modalDelBtn).show(); 
			$(".modal").modal("show");
		});		
	});
	
	modalModBtn.on("click", function(e){
		var mno = modal.data("mno"); 
		var text = $(this).text(); 
		var msg; 

		if(text == "수정"){
			msg={
				message : modalMSG.val(),
				mno : mno
			};
				
			if(!username){
				alert("로그인 이후에 수정 가능합니다.");
				return false; 
			}
				
			msgService.modify(msg, function(result){
				alert("수정되었습니다."); 
				modal.modal("hide"); 
				showList("T", pageNum);
			});		
		}else{
			msg={
				sender : modalSender.val(), 
				target : modalTarget.val(), 
				message : modalMSG.val(), 
				refno : mno
			}
		
			if(!username){
				alert("로그인 이후에 수정 가능합니다.");
				return false; 
			}
			
			msgService.add(msg, function(result){
				alert("등록되었습니다.");
				modal.modal("hide"); 
				pageNum=1;
				showList("S",pageNum);
			});
		}
	});
	
	modalDelBtn.on("click", function(e){
		var mno = modal.data("mno"); 
		if(!username){
			alert("로그인 이후에 수정 가능합니다.");
			return false; 
		}
		
		msgService.remove(mno, function(result){
			alert("삭제되었습니다.");
			modal.modal("hide"); 
			showList(type,pageNum);
		});
	});
	
	modalReBtn.on("click", function(e){
		var send = modalSender.val(); 
		var target = modalTarget.val();

		modalSender.val(target);
		modalTarget.val(send);
		modalMSG.val(""); 
		modal.find(modalDelBtn).hide(); 
		modal.find(modalReBtn).hide();
		modal.find(modalModBtn).text("등록").show();		
	});
	
	
	msgPageFooter.on("click", "li a", function(e){
		e.preventDefault(); 

		var targetPageNum = $(this).attr("href"); 
		pageNum = targetPageNum;
		showList(type, targetPageNum);
	});	
	
});
</script>
<%@ include file="../includes/footer.jsp"  %>					