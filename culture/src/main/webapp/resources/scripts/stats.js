console.log("stats Module..........."); 

var statsService= (function(){
	
	function getList(param, callback, error){
		
		var tab = param.tab||"mon";
		var sdate = param.sdate; 
		var edate = param.edate; 
		
		$.getJSON("/culture/"+tab+"/"+sdate+"/"+edate+".json", 
			function(data){
				if(callback){
					callback(data); 
				}
			}).fail(function(xhr, status, err){
				if(error){
					error(); 
				}
		});
	}
	
	function get(sdate, callback, error){
		$.get("/culture/"+sdate+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(); 
			}
		}); 
	}
	
	return {
		getList : getList, 
		get : get  
	}
})();