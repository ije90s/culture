var logService = (function(){
	
	function get(target, subPage, callback, error){
		console.log("get........................."); 
		
		$.get("/log/"+target+"/pages/"+subPage+".json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(); 
			}
		}); 
	}	
	
	
	function displyTime(time){
		var dateObj = new Date(time); 
		var yy = dateObj.getFullYear(); 
		var mm = dateObj.getMonth()+1; 
		var dd = dateObj.getDate(); 
		
		return [yy, '-', (mm<10?'0':'')+mm, '-', (dd<10?'0':'')+dd].join('');
		
	}
	
	return {
		get : get, 
		displyTime : displyTime
	}
})();
	