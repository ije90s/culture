<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
<%@ include file="../includes/header.jsp"  %>
 					<div class="container-fluid">
                        <h3 class="mt-4">회원정보 상세</h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header">* 비공개된 문화기록은 상세로 넘어가지 않습니다.</div>
                            <div class="card-body">      
                           		<div class="form-group">
                                	<label class="small mb-1" for="id">아이디</label>
                                    <input class="form-control py-4" id="id" type="text" value='${member.id}' readonly/>
                                </div>                       
								<div class="form-group">
                                	<label class="small mb-1" for="name">이름</label>
                                    <input class="form-control py-4" id="name" type="text" value='${member.name}' readonly/>
                                </div>
                                <c:if test="${member.open ne '0'}">
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
                            	</c:if>   
                                <div class="form-group">
						            <label class="small mb-1" for="state">상태</label>
						            <div id="state">
							            <c:if test="${member.state eq '0'}">일반</c:if>
							            <c:if test="${member.state eq '1'}">블락</c:if>
							            <c:if test="${member.state eq '2'}">강퇴</c:if>
							            <a type="button" class="btn btn-primary" data-oper="log">로그</a>
									</div> <!-- id="open" 끝  -->	  
								</div>	
								<div class="form-group">
								<h5>문화기록 <small id="cultureCount"></small> 게시판 <small id="boardCount"></small></h5>
								</div>  
								<div class="form-group">
									<label class="small mb-1">문화기록</label>
									<div>
										<table id="culture" class="table table-bordered" width="100%" cellspacing="0">
	            						<thead><tr><td>종류</td><td>제목</td><td>날짜</td></tr></thead>
	            						<tbody></tbody>
	            						</table>
									</div>
								</div>	
								<div class="form-group">
									<label class="small mb-1">게시판</label>
									<div>
										<table id="board" class="table table-bordered" width="100%" cellspacing="0">
	            						<thead><tr><td>종류</td><td>제목</td><td>날짜</td></tr></thead>
	            						<tbody></tbody>
	            						</table>
									</div>
								</div>																                                                                                                                                                                                             
                                <div class="form-group mt-4 mb-0 text-right">
									<button type="button" class="btn btn-secondary" data-oper="list">목록</button>
                                </div>                  				
                            </div> <!-- card-body 끝  -->           
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->
               	 
<form id="mainFrom" role="form" method="get">
	<input type="hidden" name="mno" value="${member.mno}" />
	<input type="hidden" name="pageNum" value="${cri.pageNum}" />
	<input type="hidden" name="amount" value="${cri.amount}" />
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>         
<script src="/resources/scripts/member.js"></script>
<script>
$(document).ready(function(){
	
	var form = $("#mainFrom"); 
	var mno = '<c:out value="${member.mno}"/>';
	$(".btn").click(function(e){
		e.preventDefault(); 
		var oper=$(this).data("oper");
		
		if(oper=="list"){
			form.find("input[name='mno']").remove();
			form.attr("action", "/member/list").submit();
		}else if(oper == "log"){
			form.find("input[name='mno']").remove();
			form.find("input[name='pageNum']").val(1); 
			form.find("input[name='amount']").val(10); 
			form.find("input[name='type']").val(""); 
			form.find("input[name='keyword']").val(""); 
			form.append("<input type='hidden' name='target' value='${member.id}'/>"); 
			form.append("<input type='hidden' name='subPage' value='1'/>"); 
			form.attr("action", "/log/get").submit();
		}
	});
	
	var writer = '<c:out value="${member.id}"/>'; 
	var categories = ["culture", writer];
	for(var i=0;i<categories.length;i++){
		showTopList(categories[i]); 
	}
	
	function showTopList(category){
		var str="", kind="", href=""; 
		if(category=="culture"){
			var top = {
				id : writer,	
				category : category
			};	
			console.log(top);
			memberService.cultureList(top, function(culture){				
				for(var j=0;j<culture.length;j++){
					switch(culture[j].kind){
						case 1 : kind="공연";break;
						case 2 : kind="영화";break;
						case 3 : kind="독서";break;
						case 4 : kind="관람";break;
						case 5 : kind="스포츠";break;
						case 6 : kind="기타";break;
						default : kind="";
					}	
					//console.log(culture[j].open);
					if(culture[j].open!=0) 
						href= "/culture/get?cno="+culture[j].cno;
					else
						href='javascript:alert("비공개 게시글입니다.")';
					str+="<tr>";
					str+="<td>"+kind+"</td><td><a href='"+href+"'>"+culture[j].title+"</a></td>";
					str+="<td>"+memberService.displyTime(culture[j].cdate)+"</td>"; 
					str+="</tr>";	
				}	
				$("#"+category+" tbody").html(str);			
			}); 
		}else{
			memberService.boardList(category, function(board){
				for(var j=0;j<board.length;j++){
					switch(board[j].kind){
					case "free" : kind="자유게시판";break;
					case "question" : kind="질문&답변";break;
					case "share" : kind="공유마당";break;
					default : kind="";
					}	
					str+="<tr>";
					str+="<td>"+kind+"</td><td><a href='/board/get?bno="+board[j].bno+"'>"+board[j].title+"</a></td><td>"+memberService.displyTime(board[j].rdate)+"</td>"; 
					str+="</tr>";
				}
				$("#board tbody").html(str);		
			});			
		}
	}
	memberService.cultureCount(writer, function(data){
		$("#cultureCount").append(" <kbd>"+data+"</kbd>");
	});
	
	memberService.boardCount(writer, function(data){
		$("#boardCount").append(" <kbd>"+data+"</kbd>");
	});
});
</script>  
<%@ include file="../includes/footer.jsp"  %>