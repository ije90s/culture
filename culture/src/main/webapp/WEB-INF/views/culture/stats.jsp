<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp"  %>

                    <div class="container-fluid">
                        <h1 class="mt-4">나의 </h1>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fa fa-indent mr-1"></i> 통계형 
                                <button id="regBtn" class="btn btn-secondary float-right">등록</button>
                            </div>
                            <div class="card-body">
                            	<!-- div class="table-responsive">
                             		<table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                        <tr><td>날짜</td><td>종류</td><td>건수</td></tr>
                            			</thead>
                            			<tbody>
	     									<c:forEach var="culture" items="${list}">     
	     									<tr><td>${culture.day}</td><td>${culture.kind}</td>
	     									<td>${culture.sum}</td></tr>
	     									</c:forEach>
     									</tbody>
     								</table>
     							</div-->
     							<div class="container">
     								<ul class="nav nav-tabs" role="tablist">
									    <li class="nav-item">
									      <a class="nav-link active" data-toggle="tab" href="#mon">월별</a>
									    </li>
									    <li class="nav-item">
									      <a class="nav-link" data-toggle="tab" href="#year">연별</a>
									    </li>
									    <li class="nav-item">
									      <a class="nav-link" data-toggle="tab" href="#chart">차트</a>
									    </li>
								    </ul>
								    
								    <!-- Tab panes -->
									<div class="tab-content">
										<div id="mon" class="container tab-pane active"><br>
									      <%@ include file="month.jsp"  %>
									    </div>
									    <div id="year" class="container tab-pane fade"><br>
									      <%@ include file="year.jsp"  %>      
									    </div>
									    <div id="chart" class="container tab-pane fade"><br>
									     <%@ include file="chart.jsp"  %>
									    </div>
									</div>
     							</div>
                     		</div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->
<script>
$(document).ready(function(){
	

	printCal("2021-03-01");

    <c:forEach items="${list}" var="info">
		var kind = "";
		<c:choose>
		<c:when test="${info.kind eq '1'}">kind="공연";</c:when>
		<c:when test="${info.kind eq '2'}">kind="영화";</c:when>
		<c:when test="${info.kind eq '3'}">kind="독서";</c:when>
		<c:when test="${info.kind eq '4'}">kind="관람";</c:when>
		<c:when test="${info.kind eq '5'}">kind="스포츠";</c:when>
		<c:when test="${info.kind eq '6'}">kind="기타";</c:when>
		<c:otherwise>kind="";</c:otherwise>
		</c:choose>
		$("#col_${info.day}").append("<li>"+kind+"&nbsp;${info.sum}건</li>");
	</c:forEach>

});

//달력 출력
function printCal(sdate){
	var tableStr = "";
	var year=sdate.substr(0,4); 
	var mon=sdate.substr(5,2);
	var setmon=parseInt(mon)-1;
	var fstDate = new Date(year, setmon, 1); 
	var fstDay = fstDate.getDay();
	var count=1, lstDay=28;
	//윤달 체크 
	if(mon==2 && (year%4==0 || year%100==0 || year%400==0)){lstDay=29;}
	var mon_len=new Array(31,lstDay,31,30,31,30,31,31,30,31,30,31); 
	for(var i=0;i<6;i++){
		tableStr+="<tr>"; 
		for(var j=0;j<7;j++){
			if(count<=mon_len[setmon]){
				if(i==0 && j<fstDay){
					tableStr+="<td width='100' height='100'></td>"; 
				}else{
					var nowDate = new Date(year, setmon, count); 
					var nowDay = nowDate.getDay();
					var color="black";
					if(nowDay==0){color="red";
					}else if(nowDay==6){color="blue";}
					tableStr+="<td width='100' height='100'><ul id='col_"+moment(nowDate).format('yyyy-MM-DD')+"' style='list-style:none;'>";
					tableStr+="<li align='right' style='color:"+color+";'>"+(count++)+"</li>";
					tableStr+="</ul></td>";
				}
			}else{
				tableStr+="<td width='100' height='100'></td>";
			}
			if((j+1)%7==0) tableStr+="</tr>"; 
		}
	}
	$("#calendar").html(tableStr);		
}	
</script>                	   
<%@ include file="../includes/footer.jsp"  %>                	        