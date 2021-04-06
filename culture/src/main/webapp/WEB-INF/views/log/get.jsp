<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp"  %>
					<div class="container-fluid">
                        <h3 class="mt-4">${target} 로그 상세</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">      
 								<div class="table-responsive">
									<table class="table" width="100%" cellspacing="0">
									<thead>
										<tr>							
											<td rowspan="2">구분</td>
											<td rowspan="2">권한</td>
											<td rowspan="2">기간</td>
											<td rowspan="2">등록자</td>
											<td rowspan="2">등록일</td>
											<td rowspan="2">수정자</td>
											<td rowspan="2">수정일</td>
										</tr>
									</thead>
									<tbody id="logBody"></tbody>
									</table> <!-- table 끝 -->
								 </div> <!-- table-responsive 끝  -->       
								 <div class="float-right">
								 	<button type="button" class="btn btn-success" data-oper="more">더보기</button>
								 	<button type="button" class="btn btn-secondary" data-oper="list">목록</button>
								 </div>                      				
                            </div> <!-- card-body 끝  -->           
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->            	 
<form id="mainForm" role="form" method="get">
	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
	<input type="hidden" name="amount" value="${cri.amount}" />
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form> 
<script src="/resources/scripts/log.js"></script>
<script>
$(document).ready(function(){
	var target = '<c:out value="${target}" />';
	var subPage = '<c:out value="${subPage}" />';
	showList(target, subPage); 
	var form = $("#mainForm"); 
	$(".btn").on("click", function(e){
		e.preventDefault(); 
		var oper = $(this).data("oper"); 
		console.log(oper);
		if(oper == "list"){
			form.attr("action", "/log/list").submit();
		}else if(oper=="more"){
			var length = $(".move").length; 
			subPage = Math.ceil(parseInt(length)/3)+1; 
			showList(target, subPage); 
		}
	});	
	
	function showList(target, subPage){
		var logBody = $("#logBody");  
		var str = ""; 
		logService.get(target, subPage, function(log){
			if(log==null || log.length==0){
				alert("내용이 없습니다.");
				return; 
			}
			
			for(var i=0;i<log.length;i++){
				var kind=""; 
				var auth=""; 
				var oldauth = ""; 
				var state = ""; 
				if(log[i].kind=="R"){kind="등급";
				}else if(log[i].kind=="B"){kind="블락";
				}else{kind="강퇴";}
				
				if(log[i].auth=="ROLE_USER"){auth="유저";
				}else if(log[i].auth=="ROLE_MEMBER"){auth="멤버";
				}else if(log[i].auth=="ROLE_ADMIN"){auth="관리자";}
				
				if(log[i].oldauth=="ROLE_USER"){oldauth="유저";
				}else if(log[i].oldauth=="ROLE_MEMBER"){oldauth="멤버";
				}else if(log[i].oldauth=="ROLE_ADMIN"){oldauth="관리자";}
				
				str+="<tr class='move'>";
				str+="<td>"+kind+"</td>";
				if(kind == "등급"){
					str+="<td>전: "+oldauth+" 후: "+auth+"</td>"; 
				}else{str+="<td>"+oldauth+"</td>"; }
				if(log[i].sdate==null){
					str+="<td></td>";
				}else{
					str+="<td>"+logService.displyTime(log[i].sdate)+" ~ "+logService.displyTime(log[i].edate)+"</td>";
				}
				str+="<td>"+log[i].rid+"</td>";
				str+="<td>"+logService.displyTime(log[i].rdate)+"</td>"; 
				str+="<td>"+log[i].mid+"</td>";
				str+="<td>"+logService.displyTime(log[i].mdate)+"</td>"; 	
				str+="</tr>"; 
				str+="<tr class='table-primary'>"; 
				str+="<td colspan='6'>"+log[i].content+"</td>";		
				str+='<td><button type="button" class="btn btn-warning" onclick="lnoSubmit(\'modify\', '+log[i].lno+')">수정</button> ';
				str+='<button type="button" class="btn btn-danger" onclick="lnoSubmit(\'remove\', '+log[i].lno+')">삭제</button></td>';
				str+="</tr>"; 
			}
			logBody.append(str);
		});
	}
});

function lnoSubmit(oper, lno){
	var form = $("#mainForm"); 
	if(oper=="modify"){
		form.append("<input type='hidden' name='lno' value='"+lno+"' />"); 
		form.attr("action", "/log/modify").submit();
	}else{
		form.append("<input type='hidden' name='lno' value='"+lno+"' />");
		form.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />');
		form.attr("action", "/log/remove").attr("method", "post").submit();
	}
}
</script>       
<%@ include file="../includes/footer.jsp"  %>