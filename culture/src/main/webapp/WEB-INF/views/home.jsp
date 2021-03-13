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
            
            </div> <!-- card-body 끝  -->
        </div> <!-- card mb-4 끝 -->  
        
        <div class="card-deck mb-4"> 
        	<div class="card">
	        	<div class="card-header">공지사항 <button class="btn btn-secondary float-right move" data-oper="notice">더보기</button></div>
	            <div class="card-body">
	            
	            </div> <!-- card-body 끝  -->
        	</div> <!-- card 끝  -->         
        	
        	<div class="card">
	        	<div class="card-header">자유게시판 <button class="btn btn-secondary float-right move" data-oper="free">더보기</button></div>
	            <div class="card-body">
	            
	            </div> <!-- card-body 끝  -->
        	</div>  <!-- card 끝  -->         	               
        </div>  <!-- card-columns 끝  -->
	</div> <!-- container-fluid 끝 -->   
<form method="get">
	<input type="hidden" name="mno" value='<sec:authentication property="principal.member.mno"/>' />
</form>	
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
});
</script>	
<%@ include file="./includes/footer.jsp"  %>