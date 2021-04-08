<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%@ include file="../includes/header.jsp"  %>

                    <div class="container-fluid">
                        <h3 class="mt-4">나의 기록
                        <div class="btn-group float-right">
                         	<button type="button" class="btn btn-outline-primary">리스트</button>
  							<button type="button" class="btn btn-outline-primary active">통계</button>
                        </div>
                        </h3>
                        <div class="card mt-4 mb-4">
                            <div class="card-header">
                                <input type="text" name="sdate" id="sdate" readonly/>
                                <button id="regBtn" class="btn btn-secondary float-right">등록</button>
                            </div>
                            <div class="card-body">
     							<div class="container">
     								<ul class="nav nav-tabs" role="tablist">
									    <li class="nav-item">
									      <a class="nav-link active" data-toggle="tab" data-tab="mon" href="#mon">월별</a>
									    </li>
									    <li class="nav-item">
									      <a class="nav-link" data-toggle="tab" data-tab="year" href="#year">연별</a>
									    </li>
									    <li class="nav-item">
									      <a class="nav-link" data-toggle="tab" data-tab="chart" href="#chart">차트</a>
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
<!-- The Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">상세내용</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <table class="table table-bordered" width="100%" cellspacing="0">
        <thead><tr><td>구분</td><td>제목</td><td>내용</td></tr></thead>
        <tbody></tbody>
        </table>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>            	
<!-- The Modal 끝 -->                   	
                	     	
<style>
.ui-datepicker-trigger {
	width:25px; 
	height:25px;
	margin-left:5px;
}
table.ui-datepicker-calendar { display:none; }
</style>
<script type="text/javascript" src="/resources/scripts/stats.js"></script>                	            
<script>

console.log("=============================");

var tab="mon", sdate="", edate=""; 
var today = new Date(); 
var year = today.getFullYear(); 
var month = today.getMonth()+1; 
if(month < 10) month = "0"+month; 	
	
sdate = year+"-"+month+"-01"; 
edate = year+"-"+month+"-31";	
var writer = '<sec:authentication property="principal.username"/>';

$(document).ready(function(){	
	var datepicker_default = {
            closeText : "닫기",
            prevText : "이전달",
            nextText : "다음달",
            currentText : "오늘",
            changeMonth: true,
            changeYear: true,
            monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
            monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
            dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
            dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
            dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
            weekHeader : "주",
            firstDay : 0,
            isRTL : false,
            showMonthAfterYear : true,
            yearSuffix : '',
             
            showOn: 'both',
            buttonImage:'/resources/image/calendar.png',
            buttonImageOnly: true,
             
            showButtonPanel: true
        }
      
     datepicker_default.closeText = "선택";
     datepicker_default.dateFormat = "yy-mm";
     datepicker_default.onClose = function (dateText, inst) {
        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
        $(this).datepicker('setDate', new Date(year, month, 1));
		tab = $(".nav-tabs a.active").data("tab");
		sdate = $(this).val()+"-01"; 
		edate = $(this).val()+"-31";	
		showList(tab, sdate, edate);
     }
      
     datepicker_default.beforeShow = function () {
     	var selectDate = $("#sdate").val().split("-");
        var year = Number(selectDate[0]);
        var month = Number(selectDate[1]) - 1;
        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
     }
 
    $("#sdate").datepicker(datepicker_default);	
	$("#sdate").val(sdate.substr(0,sdate.length-3));
	
	showList(tab, sdate, edate);

	$('.nav-tabs a').click(function(){
		tab = $(this).data("tab"); 
		sdate = $("#sdate").val()+"-01";
		edate = $("#sdate").val()+"-31";
		showList(tab, sdate, edate);
	});	
	
	
	
	$("#year tbody").on("dblclick",".move", function(){
		var date = $(this).data("date"); 
		tab = "mon"; 
		sdate = date+"-01"; 
		edate = date+"-31"; 
		$("#sdate").val(date);
		showList(tab, sdate, edate);
		$('.nav-tabs a[href="#'+tab+'"]').tab('show');
	});
	
	var modal = $(".modal"); 
	var modalThead = modal.find("thead"); 
	var modalTbody = modal.find("tbody");
	
	$("#mon tbody").on("dblclick",".move", function(){
		var date = $(this).data("date");
		var str; 
		modalThead.html("<tr><td>구분</td><td>제목</td><td>평점</td></tr>");
		statsService.get({id:writer, sdate:date}, function(list){
			for(var i=0, len=list.length||0; i<len;i++){
				switch(list[i].kind){
				case 1 : kind="공연";break;
				case 2 : kind="영화";break;
				case 3 : kind="독서";break;
				case 4 : kind="관람";break;
				case 5 : kind="스포츠";break;
				case 6 : kind="기타";break;
				default : kind="";
				}	

				str+="<tr><td>"+kind+"</td>";
				str+="<td><a href='/culture/get?cno="+list[i].cno+"'>"+list[i].title+"</a></td>";
				str+="<td>"+list[i].rank+"점</td></tr>";		
			}
			modalTbody.html(str);
			$(".modal").modal("show");
		});
	}); 
	
	$("#myChartContainer").on("dblclick","#myChart", function(){
		var str; 
		modalThead.html("<tr><td>구분</td><td>합계</td><td>비율</td></tr>");
		statsService.getList({tab:tab, id:writer, sdate:sdate, edate:edate}, function(list){
			for(var i=0, len=list.length||0; i<len;i++){
				switch(list[i].kind){
				case 1 : kind="공연";break;
				case 2 : kind="영화";break;
				case 3 : kind="독서";break;
				case 4 : kind="관람";break;
				case 5 : kind="스포츠";break;
				case 6 : kind="기타";break;
				default : kind="";
				}	
				
				if(kind!=""){
					str+="<tr><td>"+kind+"</td><td>"+list[i].sum+"건</td><td>"+list[i].ratio+"%</td></tr>";	
				}			
			}
			modalTbody.html(str);
			$(".modal").modal("show");
		}); 	
	}); 
	
	$(".btn-group").on("click", "button", function(e){
		e.preventDefault(); 
		var text = $(this).text(); 
		//var mno = '<sec:authentication property="principal.member.mno"/>';
		if(text == "리스트"){
			self.location="/culture/list/"+writer; 	
		}else{
			self.location="/culture/stats/"+writer; 	
		}
	});	
	
	$("#regBtn").click(function(){
		self.location="/culture/register";
	});
	
});

function showList(tab, sdate, edate){ 
	var kind, date, color; 
	var kinds = [], datas = [], colors = []; 
	if(tab === "year"){
		sdate = year+"-01-01"; 
		edate = year+"-"+month+"-31";  
	}	
	$("#sdate").val(sdate.substr(0,sdate.length-3));
	showTab(tab, sdate, edate);
	statsService.getList({tab:tab, id:writer, sdate:sdate, edate:edate}, function(list){
		for(var i=0, len=list.length||0; i<len;i++){
			//console.log(list[i]);
			switch(list[i].kind){
			case 1 : kind="공연"; color="#ff6384"; break;
			case 2 : kind="영화"; color="#ffce56"; break; 
			case 3 : kind="독서"; color="#36a2eb"; break;
			case 4 : kind="관람"; color="#cc65fe"; break; 
			case 5 : kind="스포츠"; color="red"; break; 
			case 6 : kind="기타";color="blue"; break; 
			default : kind=""; color="";
			}		
			if(tab === "mon"){
				$("#col_"+list[i].day).append("<li>"+kind+" "+list[i].sum+"건</li>");
			}else if(tab == "year"){
				$("#tr_"+list[i].day+" ul").append("<li>"+kind+" "+list[i].sum+"건</li>");		
			}else{
				if(kind!= ""){
					kinds[i]=kind; 
					datas[i]=list[i].ratio;
					colors[i]=color;
				}
				$("#myChart").remove(); 
				$("#myChartContainer").append('<canvas id="myChart" width="400" height="400"></canvas>');
				var ctx = document.getElementById('myChart');
				var myChart = new Chart(ctx, {
					type: 'doughnut', 
					data: {
						labels:kinds,
						datasets:[{
							backgroundColor:colors,
							data:datas
						}]
					},
					options: {}
				});	
			}	
		}
	});	
}
//달력 출력
function showTab(tab, sdate, edate){
	var tableStr = "";
	var year=sdate.substr(0,4); 
	var mon=sdate.substr(5,2);
	var emon=edate.substr(5,2);
	var setmon=parseInt(mon)-1;
	var fstDate = new Date(year, setmon, 1); 
	var fstDay = fstDate.getDay();
	var count=1, lstDay=28;
	//윤달 체크 
	if(mon==2 && (year%4==0 || year%100==0 || year%400==0)){lstDay=29;}
	var mon_len=new Array(31,lstDay,31,30,31,30,31,31,30,31,30,31); 
	if(tab == "mon"){
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
						tableStr+="<td width='100' height='100'><ul id='col_"+moment(nowDate).format('yyyy-MM-DD')+"' data-date='"+moment(nowDate).format('yyyy-MM-DD')+"' class='move'  style='list-style:none;'>";
						tableStr+="<li align='right' style='color:"+color+";'>"+(count++)+"</li>";
						tableStr+="</ul></td>";
					}
				}else{
					tableStr+="<td width='100' height='100'></td>";
				}
				if((j+1)%7==0) tableStr+="</tr>"; 
			}
		}
	}else if(tab == "year"){
		
		for(var i=1;i<=parseInt(emon);i++){
			var mon2=i; 
			if(i<10) mon2="0"+i; 
			tableStr+="<tr id='tr_"+year+"-"+mon2+"' data-date='"+year+"-"+mon2+"' class='move'>"; 
			tableStr+="<td>"+year+"년 "+mon2+"월</td>"; 
			tableStr+="<td><ul style='list-style:none;'></ul></td>"; 
			tableStr+="</tr>"; 
		}
	}
	$("#"+tab+" tbody").html(tableStr);		
}	
</script>
<%@ include file="../includes/footer.jsp"  %>                	        