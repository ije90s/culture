<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<%@ include file="./includes/header.jsp"  %>

	<div class="container-fluid">
		<sec:authorize access="hasAnyRole('ROLE_MEMBER','ROLE_USER')">      
			<h3 class="mt-4"><sec:authentication property="principal.member.name"/> 환영합니다. 
			<button id="regBtn" class="btn btn-primary float-right">문화기록 등록</button></h3>			
			<div class="card mt-4 mb-4">
	        	<div class="card-header"><h6>문화기록<button class="btn btn-secondary float-right move" data-oper="culture">더보기</button></h6></div>
	            <div class="card-body">
	            	<table id="culture" class="table table-bordered" width="100%" cellspacing="0">
	            	<thead><tr><td>종류</td><td>제목</td><td>날짜</td></tr></thead>
	            	<tbody></tbody>
	            	</table>
	            </div> <!-- card-body 끝  -->
	        </div> <!-- card mb-4 끝 -->  
	        
	        <div class="card-deck mb-4"> 
	        	<div class="card">
		        	<div class="card-header"><h6>공지사항<button class="btn btn-secondary float-right move" data-oper="notice">더보기</button></h6></div>
		            <div class="card-body">
	            	<table id="notice" class="table table-bordered" width="100%" cellspacing="0">
	            	<thead><tr><td>제목</td><td>날짜</td></tr></thead>
	            	<tbody></tbody>
	            	</table>	            
		            </div> <!-- card-body 끝  -->
	        	</div> <!-- card 끝  -->         
	        	
	        	<div class="card">
		        	<div class="card-header"><h6>자유게시판<button class="btn btn-secondary float-right move" data-oper="free">더보기</button></h6></div>
		            <div class="card-body">
	            	<table id="free" class="table table-bordered" width="100%" cellspacing="0">
	            	<thead><tr><td>제목</td><td>날짜</td></tr></thead>
	            	<tbody></tbody>
	            	</table>	            
		            </div> <!-- card-body 끝  -->
	        	</div>  <!-- card 끝  -->         	               
	        </div>  <!-- card-columns 끝  -->
        </sec:authorize> <!-- sec:authorize 끝  -->
        
        <!-- admin 시작 -->
        <sec:authorize access="hasRole('ROLE_ADMIN')">  
        <h3 class="mt-4"><sec:authentication property="principal.member.name"/> 환영합니다.</h3>    
        <div class="row">
        	<div class="col-xl-3 col-md-6">
            	<div class="card bg-primary text-white mb-4">
                	<div id="total" class="card-body"></div>
                    	<div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">총 가입자</div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-warning text-white mb-4">
                    	<div id="block" class="card-body"></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">블락회원</div>
                        </div>
                    </div>
                </div>
				<div class="col-xl-3 col-md-6">
                    <div class="card bg-success text-white mb-4">
                    	<div id="normal" class="card-body"></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">일반회원</div>
                        </div>
                    </div>
                </div>                
                <div class="col-xl-3 col-md-6">
                    <div class="card bg-danger text-white mb-4">
                    	<div id="exit" class="card-body"></div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                            <div class="small text-white">강퇴회원</div>
                        </div>
                     </div>
               </div>
        </div>
		<div class="card mt-4 mb-4">
	   		<div class="card-header"><h6>신고리스트<button class="btn btn-secondary float-right move" data-oper="report">더보기</button></h6></div>
	        <div class="card-body">
	        	<table id="report" class="table table-bordered" width="100%" cellspacing="0">
	           	<thead><tr><td>NO.</td><td>제목</td><td>날짜</td></tr></thead>
	            <tbody></tbody>
	            </table>
	        </div> <!-- card-body 끝  -->
	    </div> <!-- card mb-4 끝 -->    
	    <div class="card mt-4 mb-4">
	    	<div class="card-header">탈퇴사유</div>
	    	<div class="card-body" id="myChartContainer"><canvas id="myChart" width="400" height="400"></canvas></div>
	    </div>      
        </sec:authorize>
        <!-- admin 끝-->
	</div> <!-- container-fluid 끝 -->   
<form method="get">
	<input type="hidden" name="mno" value='<sec:authentication property="principal.member.mno"/>' />
</form>	
<script src="/resources/scripts/home.js"></script>
<script>
$(document).ready(function(){
	var formObj = $("form"); 
	var mno = formObj.find("input[name='mno']").val(); 
	$("#regBtn").click(function(){
		self.location="/culture/register";
	});
	
	$(".move").click(function(){
		var oper = $(this).data("oper");
		if(oper=="culture"){
			self.location="/culture/list/"+mno;
		}else if(oper == "report"){
			self.location="/report/list/all";
		}else{
			self.location="/board/list/"+oper;
		}
	});
		
	var categories = ["culture", "notice", "free"];
	<sec:authorize access="hasAnyRole('ROLE_MEMBER','ROLE_USER')">      
		for(var i=0;i<categories.length;i++){
			showTopList('member', categories[i]); 
		}
	</sec:authorize>
		
	<sec:authorize access="hasAnyRole('ROLE_ADMIN')">      
	var member = ["N", "B", "E", ""];
	for(var i=0;i<member.length;i++){
		showCountList(member[i]);
	}
	showTopList('admin', 'report');
	var reasons = [], datas = [], colors = [];
	var reason = "",  color = ""; 
	homeService.chartList(function(list){
		for(var i=0; i<list.length;i++){
			switch(list[i].reason){
			case 1 : reason="서비스 불만족"; color="#ff6384"; break;
			case 2 : reason="쓰기 불편"; color="#ffce56"; break; 
			case 3 : reason="개인 불만족"; color="#36a2eb"; break;
			case 4 : reason="사용 자주 하지 않음"; color="#cc65fe"; break; 
			case 5 : reason="기타"; color="red"; break; 
			default : reason=""; color="";
			}		
			reasons[i]=reason; 
			colors[i]=color;
			datas[i]=list[i].cnt;
			$("#myChart").remove(); 
			$("#myChartContainer").append('<canvas id="myChart" width="100" height="100"></canvas>');
			var ctx = document.getElementById('myChart');
			var myChart = new Chart(ctx, {
				type: 'doughnut', 
				data: {
					labels:reasons,
					datasets:[{
						backgroundColor:colors,
						data:datas
					}]
				},
				options: {}
			});
		}	
	});		
	</sec:authorize>
	
	function showTopList(gubun, category){
		var str="", kind=""; 
		if(gubun == "member"){
			if(category=="culture"){
				var top = {
					mno : mno,	
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
		}else{
			homeService.reportList(function(report){				
				for(var j=0;j<report.length;j++){
					str+="<tr>";
					str+="<td>"+report[j].rno+"</td><td><a href='/report/get?rno="+report[j].rno+"' >"+report[j].title+"</a></td>";
					str+="<td>"+homeService.displyTime(report[j].rdate)+"</td>"; 
					str+="</tr>";	
				}	
				$("#"+category+" tbody").html(str);			
			}); 			
		}

	}	
	
	function showCountList(member){
		homeService.countList(member, function(data){
			if(member=="N"){
				$("#normal").html(data+"명"); 
			}else if(member=="B"){
				$("#block").html(data+"명"); 
			}else if(member=="E"){
				$("#exit").html(data+"명"); 
			}else{
				$("#total").html(data+"명"); 
			}
		});		
	}	
});
</script>	
<%@ include file="./includes/footer.jsp"  %>