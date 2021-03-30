<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>      
<%@ include file="./includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h3 class="mt-4">통합검색</h3>
                        <div class="card mt-4 mb-4">
							<div class="card-header"><h6>문화기록 </h6></div>
                            <div class="card-body">
	                            <ul class="culture list-group list-group-flush"></ul>
	                            <button type='button' class='btn btn-success float-right' data-tab="culture">더보기</button>
                            </div>
                       </div>
                       <div class="card mb-4">
							<div class="card-header"><h6>공지사항</h6></div>
                            <div class="card-body">
	                            <ul class="notice list-group list-group-flush"></ul>
	                            <button type='button' class='btn btn-success float-right' data-tab="notice">더보기</button>
                            </div>
                       </div>
                       <div class="card mb-4">
							<div class="card-header"><h6>자유게시판</h6></div>
                            <div class="card-body">
	                            <ul class="free list-group list-group-flush"></ul>
	                            <button type='button' class='btn btn-success float-right' data-tab="free">더보기</button>
                            </div>
                       </div>
                       <div class="card mb-4">
							<div class="card-header"><h6>질문&답변</h6></div>
                            <div class="card-body">
	                            <ul class="question list-group list-group-flush"></ul>
	                            <button type='button' class='btn btn-success float-right' data-tab="question">더보기</button>
                            </div>
                       </div>
                       <div class="card mb-4">
							<div class="card-header"><h6>공유마당</h6></div>
                            <div class="card-body">
	                            <ul class="share list-group list-group-flush"></ul>
	                            <button type='button' class='btn btn-success float-right' data-tab="share">더보기</button>
                            </div>
                       </div>
                    </div>
<script src="/resources/scripts/search.js"></script>                    
 <script>
 $(document).ready(function(){
	var type='<c:out value="${type}"/>'; 
	var keyword='<c:out value="${keyword}"/>'; 
	var cultureUL = $(".culture"); 	
	var listArr = ['culture', 'notice', 'free', 'question', 'share']; 
	
	for(var i=0;i<listArr.length;i++){
		setList(listArr[i]);
	}
	$(".btn").click(function(e){
		e.preventDefault(); 
		var tab = $(this).data("tab"); 
		setList(tab);
	});
	
	function setList(tab){
		if(tab=="culture"){
			var liLen = $(".culture li").length; 	
			cri = {
				page : Math.ceil(parseInt(liLen)/3)+1, 
				type : type, 
				keyword : keyword
			};
			serachService.culture(cri, function(list){
				var str=""; 
				
				if(list==null || list.length==0){
					$(".culture").siblings(".btn").hide();
					cultureUL.append("");
					return;
				}
				for(var i=0;i<list.length;i++){
					
					var content = list[i].content;
					if(content == null) content="";
					if(content.length > 50){
						content = content.substr(0,2)+"…";
					}
					str+="<li class='list-group-item'>";
					str+="<div><div class='header'>";
					str+="<a href='/culture/get?cno="+list[i].cno+"'><strong class='primary-font'>"+list[i].title+"</strong></a>";
					str+="<small class='float-right text-muted'>"+serachService.displyTime(list[i].rdate)+"</small></div>";
					str+="<p>"+content+"</p></div>";	
					str+="</li>";
				}
				cultureUL.append(str);
			});		
		}else{
			var liLen = $("."+tab+" li").length; 	
			cri = {
				tab : tab, 
				page : Math.ceil(parseInt(liLen)/3)+1, 
				type : type, 
				keyword : keyword
			};
			serachService.board(cri, function(list){
				var str=""; 
		
				if(list==null || list.length==0){
					$("."+tab).siblings(".btn").hide();
					$("."+tab).append("");
					return;
				}
				for(var i=0;i<list.length;i++){
					
					var content = list[i].content;
					if(content == null) content="";
					if(content.length > 50){
						content = content.substr(0,2)+"…";
					}
					str+="<li class='list-group-item'>";
					str+="<div><div class='header'>";
					str+="<a href='/board/get?bno="+list[i].bno+"'><strong class='primary-font'>"+list[i].title+"</strong></a>";
					str+="<small class='float-right text-muted'>"+serachService.displyTime(list[i].rdate)+"</small></div>";
					str+="<p>"+content+"</p></div>";	
					str+="</li>";
				}
				$("."+tab).append(str);
			});					
		}		
	}
 });
 </script>
<%@ include file="./includes/footer.jsp"  %>                    