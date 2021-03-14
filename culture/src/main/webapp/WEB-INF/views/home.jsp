<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ include file="./includes/header.jsp"  %>

	<div class="container-fluid">
		<h1 class="mt-4"><sec:authentication property="principal.member.name"/> 환영합니다. 
		<button id="regBtn" class="btn btn-secondary float-right">문화기록 등록</button></h1>
		<div class="card mb-4">
        	<div class="card-header">문화기록 <button class="btn btn-secondary float-right move" data-oper="culture">더보기</button></div>
            <div class="card-body">
            	<table id="culture" class="table table-bordered" width="100%" cellspacing="0">
            	<thead><tr><td>종류</td><td>제목</td><td>날짜</td></tr></thead>
            	<tbody></tbody>
            	</table>
            </div> <!-- card-body 끝  -->
        </div> <!-- card mb-4 끝 -->  
        
        <div class="card-deck mb-4"> 
        	<div class="card">
	        	<div class="card-header">공지사항 <button class="btn btn-secondary float-right move" data-oper="notice">더보기</button></div>
	            <div class="card-body">
            	<table id="notice" class="table table-bordered" width="100%" cellspacing="0">
            	<thead><tr><td>제목</td><td>날짜</td></tr></thead>
            	<tbody></tbody>
            	</table>	            
	            </div> <!-- card-body 끝  -->
        	</div> <!-- card 끝  -->         
        	
        	<div class="card">
	        	<div class="card-header">자유게시판 <button class="btn btn-secondary float-right move" data-oper="free">더보기</button></div>
	            <div class="card-body">
            	<table id="free" class="table table-bordered" width="100%" cellspacing="0">
            	<thead><tr><td>제목</td><td>날짜</td></tr></thead>
            	<tbody></tbody>
            	</table>	            
	            </div> <!-- card-body 끝  -->
        	</div>  <!-- card 끝  -->         	               
        </div>  <!-- card-columns 끝  -->
	</div> <!-- container-fluid 끝 -->   
<form method="get">
	<input type="hidden" name="mno" value='<sec:authentication property="principal.member.mno"/>' />
</form>	
<script src="/resources/scripts/home.js"></script>
<script>
$(document).ready(function(){
	var formObj = $("form"); 
	$("#regBtn").click(function(){
		//console.log("클릭함");
		self.location="/culture/register";
	});
	
	$(".move").click(function(){
		var oper = $(this).data("oper");
		if(oper=="culture"){
			formObj.attr("action","/culture/list").submit(); 
		}else{
			formObj.find("input[name='mno']").remove();
			formObj.attr("action","/board/list").submit(); 
		}
	});
		
	var categories = ["culture", "notice", "free"];
	for(var i=0;i<categories.length;i++){
		showTopList(categories[i]); 
	}
	
	function showTopList(category){
		var str="", kind=""; 
		if(category=="culture"){
			var top = {
				mno : formObj.find("input[name='mno']").val(),	
				category : category
			};	
			homeService.cultureList(top, function(culture){				
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
					str+="<tr>";
					str+="<td>"+kind+"</td><td><a href='/culture/get?cno="+culture[j].cno+"' >"+culture[j].title+"</a></td>";
					str+="<td>"+homeService.displyTime(culture[j].cdate)+"</td>"; 
					str+="</tr>";	
				}	
				$("#"+category+" tbody").html(str);			
			}); 
		}else{
			homeService.boardList(category, function(board){
				for(var j=0;j<board.length;j++){
					str+="<tr>";
					str+="<td><a href='/board/get?bno="+board[j].bno+"'>"+board[j].title+"</a></td><td>"+homeService.displyTime(board[j].rdate)+"</td>"; 
					str+="</tr>";
				}
				$("#"+category+" tbody").html(str);		
			});			
		}
	}


	
});
</script>	
<%@ include file="./includes/footer.jsp"  %>