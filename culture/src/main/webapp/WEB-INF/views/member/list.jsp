<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<%@ include file="../includes/header.jsp"  %>
					<style>
        			.invalid{color:red !important;}
        			</style>                   
                    <div class="container-fluid">
                        <h3 class="mt-4">회원리스트</h3>
                        <div class="card mb-4">
                            <div class="card-header">
                                 <form id="searchForm" action="/member/list" method="get">
                                 <input type="hidden" name="pageNum" value='<c:out value="${page.cri.pageNum }"/>' />
								 <input type="hidden" name="amount" value='<c:out value="${page.cri.amount }"/>' />
								 <div class="input-group">
                                	<select name="type" class="custom-select" style="flex:none; width:200px;">
                                	<option value="" <c:out value="${page.cri.type==null?'selected':''}"/>>선택</option>
                                	<option value="N" <c:out value="${page.cri.type eq 'N'?'selected':''}"/>>일반</option>
                                	<option value="B" <c:out value="${page.cri.type eq 'B'?'selected':''}"/>>블락</option>
                                	<option value="E" <c:out value="${page.cri.type eq 'E'?'selected':''}"/>>강퇴</option>
                                	</select>
                                	<div class="input-group-prepend"><input type="text" name="keyword" class="form-control" value='<c:out value="${page.cri.keyword}"/>' /></div>  	
									<div class="input-group-prepend"><button class="btn btn-primary">검색</button></div>
								</div>	
                                </form>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
									<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<td>NO.</td>
											<td>아이디</td>
											<td>이름</td>
											<td>가입일</td>
											<td>상태</td>
											<td></td>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${list}" var="list">
										<tr>
											<td>${list.mno}</td>
											<td>
												<a class="move" href="${list.mno}">${list.id}</a>												
											</td>
											<td>${list.name}</td>
											<td><fmt:formatDate value="${list.rdate}" pattern="yyyy-MM-dd"/></td>
											<td>
											<a class="get" href="${list.lno}" data-id="${list.id}" data-auth="${list.authList[0].auth}" data-state="${list.state}"><c:if test="${list.state eq '0'}">일반</c:if>
											<c:if test="${list.state eq '1'}">블락</c:if>
											<c:if test="${list.state eq '2'}">강퇴</c:if>
											</a>
											</td>
											<td>	
												<button type="button" class="btn btn-success change" data-id="${list.id}" data-auth="${list.authList[0].auth}" data-state="${list.state}">변경</button>
											</td>
										</tr>
										</c:forEach>
									</tbody>
									</table> <!-- table 끝 -->
								 </div> <!-- table-responsive 끝  -->           
								 
								 <div class="float-right"> <!-- paging 처리 -->
                                  <ul class="pagination">
                                  	<c:if test="${page.pre}">
                                  		<li class="page-item"><a class="page-link" href="${page.start-1}">Previous</a></li>
                                  	</c:if>
                                  	
								    <c:forEach var="num" begin="${page.start}" end="${page.end}">
								    	<li class='page-item ${page.cri.pageNum eq num? "active":""}'><a class='page-link' href="${num}">${num}</a></li>
								    </c:forEach>
								    
								    <c:if test="${page.next}">
								    	<li class="page-item"><a class="page-link" href="${page.end+1}">Next</a></li>
								    </c:if>
  								  </ul>
                                </div> <!-- paging 처리 끝 -->      
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->   
       	
<form id="listForm" method="get">
	<input type="hidden" name="pageNum" value="${page.cri.pageNum }"/>
	<input type="hidden" name="amount" value="${page.cri.amount }"/>
	<input type="hidden" name="type" value="${page.cri.type }"/>
	<input type="hidden" name="keyword" value="${page.cri.keyword }"/>
</form>                	
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">상태 변경 로그</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
     	<div class="form-group">
     		<label>구분<medium class="invalid">*</medium></label>
     		<div id="kind">
	            <div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input chk" name="kind" value="R" checked>등급
					</label>
				</div>
				<div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input chk" name="kind" value="B" <c:if test="${memberLogVO.kind eq 'B'}">checked</c:if>>블락
					</label>
				</div>
				<div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input chk" name="kind" value="E" <c:if test="${memberLogVO.kind eq 'E'}">checked</c:if>>강퇴
					</label>
				</div>
				<small class="kind"></small>
			</div>
     	</div>
     	<div class="form-group ranking">
     		<label>등급<medium class="invalid">*</medium></label>
     		<div id="auth">
	            <div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input chk" name="auth" value="ROLE_USER" <c:if test="${memberLogVO.auth eq 'ROLE_USER'}">checked</c:if>>유저
					</label>
				</div>
				<div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input chk" name="auth" value="ROLE_MEMBER" <c:if test="${memberLogVO.auth eq 'ROLE_MEMBER'}">checked</c:if>>멤버
					</label>
				</div>
				<div class="form-check-inline">
	            	<label class="form-check-label">
					<input type="radio" class="form-check-input chk" name="auth" value="ROLE_ADMIN" <c:if test="${memberLogVO.auth eq 'ROLE_ADMIN'}">checked</c:if>>관리자
					</label>
				</div><br>
				<small class="auth"></small>
			</div>
     	</div>   
     	<div class="form-group block">
     		<label>시작일<medium class="invalid">*</medium></label>
     		<input class="form-control chk" name="sdate" type="date" value="${memberLogVO.sdate}"/> 
     		<small></small>
     	</div>
     	<div class="form-group block">
     		<label>끝일<medium class="invalid">*</medium></label>
     		<input class="form-control chk" name="edate" type="date" value="${memberLogVO.edate}"/> 
     		<small></small>
     	</div>  	
   		<div class="form-group">
     		<label>내용<medium class="invalid">*</medium></label>
  			<textarea class="form-control chk" name="content" rows="5" id="content">${memberLogVO.content}</textarea>
  			<small></small>
     	</div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-warning" id="regBtn">등록</button>
      	<button type="button" class="btn btn-warning" id="modBtn">수정</button>
      	<button type="button" class="btn btn-danger" id="delBtn">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->      
<script src="/resources/scripts/member.js"></script>      	             	
<script>
$(document).ready(function(){
	
	var search = $("#searchForm"); 
	$("#searchForm button").on("click", function(e){
		e.preventDefault(); 	
	
		if(!search.find("option:selected").val()){
			alert("종류를 선택하세요."); 
			return false; 
		}
			
		if(!search.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요."); 
			return false; 
		}
		search.find("input[name='pageNum']").val("1");
		search.attr("action", "/member/list").submit();			
	});

	
	var form = $("#listForm"); 
	$(".move").click(function(e){
		e.preventDefault();
		var mno = $(this).attr("href");
		console.log(mno);
		form.append("<input type='hidden' name='mno' value='"+mno+"'/>");
		form.attr("action", "/member/get").submit();
	}); 
	 
	$(".page-link").click(function(e){
		e.preventDefault(); 
		var selectedPageNum = $(this).attr("href"); 
		form.find("input[name='pageNum']").val(selectedPageNum);
		form.attr("action", "/member/list").submit();
	});
		
	var modal = $(".modal"); 
	var ranking = modal.find(".ranking"); 
	var block = modal.find(".block"); 
	
	var sdate = modal.find("input[name='sdate']"); 
	var edate = modal.find("input[name='edate']"); 
	var content = modal.find("#content"); 
	
	var regBtn = modal.find("#regBtn"); 
	var modBtn = modal.find("#modBtn"); 
	var delBtn = modal.find("#delBtn"); 
	$(".change").click(function(e){
		e.preventDefault();	
		ranking.show(); 
		block.hide(); 	
		$("input:radio[name='kind']:radio[value='R']").prop('checked', true);
		$("input:radio[name='auth']").prop('checked', false);
		sdate.val(""); 
		edate.val("");
		content.val(""); 
		regBtn.show(); 
		modBtn.hide(); 
		delBtn.hide(); 	
		modal.data("target", $(this).data("id"));
		modal.data("oldauth", $(this).data("auth"));
		modal.data("state", $(this).data("state"));
		modal.modal("show"); 
	});
	
	$(".get").click(function(e){
		e.preventDefault();
		var lno = $(this).attr("href"); 
		var id = $(this).data("id");
		var oldauth = $(this).data("auth");
		var state = $(this).data("state"); 
		if(lno=="0"){
			alert("등록된 로그가 없습니다.");
		}else{
			memberService.get(lno, function(data){
				$("input:radio[name='kind']:radio[value='"+data.kind+"']").prop('checked', true); 
				if(data.kind=="R"){
					ranking.show(); 
					block.hide();
					sdate.val(""); 
					edate.val(""); 
					content.val(data.content); 
					$("input:radio[name='auth']:radio[value='"+data.auth+"']").prop('checked', true); 
				}else if(data.kind=="B"){
					ranking.hide(); 
					block.show(); 	
					sdate.val(data.sdate); 
					edate.val(data.edate); 
					content.val(data.content); 
					$("input:radio[name='auth']").prop('checked', false);
				}else{
					ranking.hide(); 
					block.hide(); 	
					sdate.val(""); 
					edate.val(""); 
					content.val(data.content); 
					$("input:radio[name='auth']").prop('checked', false);
				}
				regBtn.hide(); 
				modBtn.show(); 
				delBtn.show();
				modal.data("lno", lno);
				modal.data("target", id);
				modal.data("oldauth", oldauth);
				modal.data("state", state);
				modal.modal("show"); 
			});
		}
	});
	
	$("input[name='kind']").on("click", function(e){
		var value = $("input[name='kind']:checked").val();
		if(value=="R"){
			ranking.show(); 
			block.hide();
			sdate.val("");
			edate.val(""); 
		}else if(value=="B"){
			ranking.hide(); 
			block.show();
			$("input:radio[name='auth']").prop('checked', false);
			sdate.val("");
			edate.val(""); 
		}else{
			ranking.hide(); 
			block.hide();
			$("input:radio[name='auth']").prop('checked', false);
			sdate.val("");
			edate.val(""); 
		}	
	});

	var csrfHeader = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";	
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});	

	
	$(".chk").blur(function(e){
		memberService.validate($(this));	
	});	
	
	var log; 
	regBtn.on("click", function(e){
		
		$(".chk").each(function(e){
			memberService.validate($(this));	
		});		
		
		var kind = $("input[name='kind']:checked").val();	
		if(!kind)
			if(!checkItem($("input[name='kind']"))) return false;
			
		if(kind=="R"){
			if(!checkItem($("input[name='auth']"))) return false;
	
		}else if(kind=="B"){
			if(!checkItem($("input[name='sdate']"))) return false;
			if(!checkItem($("input[name='edate']"))) return false;
		}
		if(!checkItem($("#content"))) return false;
		
		var auth = $("input[name='auth']:checked").val(); 
		if(!auth) {auth="";}
		
		var target = modal.data("target"); 
		var oldauth = modal.data("oldauth"); 
		var state = modal.data("state");
		
		
		log={
			kind : kind, 
			auth : auth, 
			sdate : sdate.val(), 
			edate : edate.val(), 
			content : content.val(), 
			target : target, 
			oldauth : oldauth, 
			state : state, 
			rid : "admin90",
			mid : "admin90"
		}; 
		
		memberService.add(log, function(data){
			alert("등록되었습니다.");
			modal.modal("hide");
			location.reload();
		}, function(error){
			alert("입력값을 확인하세요.");
			$(".chk").each(function(){
				memberService.validate($(this));
			});
		});		
	});
	
	modBtn.on("click", function(e){
		e.preventDefault(); 
	
		$(".chk").each(function(e){
			memberService.validate($(this));	
		});		
		
		var kind = $("input[name='kind']:checked").val();	
		if(!kind)
			if(!checkItem($("input[name='kind']"))) return false;
			
		if(kind=="R"){
			if(!checkItem($("input[name='auth']"))) return false;
		}else if(kind=="B"){
			if(!checkItem($("input[name='sdate']"))) return false;
			if(!checkItem($("input[name='edate']"))) return false;
		}		
		if(!checkItem($("#content"))) return false;		
		
		var auth = $("input[name='auth']:checked").val(); 	
		if(!auth) {auth="";}
		
		var lno = modal.data("lno");		
		log={
				lno : lno,
				kind : kind, 
				auth : auth, 
				sdate : sdate.val(), 
				edate : edate.val(), 
				content : content.val(), 
				mid : "admin90"
		};
		
		memberService.modify2(log, function(data){
			alert("수정되었습니다.");
			modal.modal("hide");
			location.reload();
		}, function(error){
			alert("입력값을 확인하세요.");
			$(".chk").each(function(){
				memberService.validate($(this));
			});
		});		
	});
	
	delBtn.on("click",function(e){
		e.preventDefault(); 
		var lno = modal.data("lno");	
		memberService.remove(lno, function(data){
			alert("삭제되었습니다.");
			modal.modal("hide");
			location.reload();
		});		
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
});
</script>               	
<%@ include file="../includes/footer.jsp"  %>