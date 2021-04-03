var reportService = (function(){
	function add(report, callback, error){
		console.log("report.................");
		
		$.ajax({
			type : 'post', 
			url : '/report/new', 
			data  : JSON.stringify(report),
			contentType : "application/json; charset=utf-8", 
			success : function(result, status, xhr){
				if(callback){
					callback(result); 
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er); 
				}
			}
		});
	}	
	
	function get(kind, no, callback, error){
		console.log("get........................."); 
		
		$.get("/report/"+kind+"/"+no+".json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(); 
			}
		}); 
	}
	
	function modify(report, callback, error){
		console.log("modify................"); 
		$.ajax({
			type : 'put', 
			url : '/report/'+report.rno, 
			data : JSON.stringify(report), 
			contentType : "application/json; charset=UTF-8", 
			success : function(result, status, xhr){
				if(callback){
					callback(result); 
				}
			}, 
			error : function(xhr, status, er){
				if(error){
					error(er); 
				}
			}
		});
	}
	
	function remove(rno, callback, error){
		console.log("remove........................."); 	
		$.ajax({
			type : 'delete', 
			url : '/report/'+rno,
			success : function(result, status, xhr){
				if(callback){
					callback(result); 
				}
			}, 
			error : function(xhr, status, er){
				if(error){
					error(er); 
				}
			}
		});		
	}
	
	return {
		add:add,
		get:get,
		modify:modify,
		remove:remove
	}; 	
})(); 	