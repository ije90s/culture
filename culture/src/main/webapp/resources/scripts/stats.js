console.log("stats Module..........."); 

var statsService= (function(){
	
	function getList(param, callback, error){
		
		var tab = param.tab||"mon";
		var id = param.id;
		var sdate = param.sdate; 
		var edate = param.edate; 
		
		$.getJSON("/culture/"+tab+"/"+id+"/"+sdate+"/"+edate+".json", 
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
	
	function get(param, callback, error){
		var id = param.id;
		var sdate = param.sdate;
		$.get("/culture/"+id+"/"+sdate+".json", function(result){
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