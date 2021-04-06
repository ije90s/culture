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
	
	function remove(report, callback, error){
		console.log("remove........................."); 	
		$.ajax({
			type : 'delete', 
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
	
	function validate(t){
		var name=t.attr("name"); 
		var value=t.val(); 
		var small = t.siblings('small'); 
		var msg="", tag="valid"; 
		if(name=="title"){
			if(value==""){
				msg = "제목을 입력하세요.";
				tag = "invalid";
			}else if(value > 25){
				msg = "최대 25자까지 가능합니다.";
				tag = "invalid";
			}
		}else if(name=="content"){
			if(value==""){
				msg = "내용을 입력하세요."; 
				tag = "invalid"; 
			}
		}
		small.text(msg); 
		small.removeClass();
		small.addClass(tag);
	};	
	
	return {
		add:add,
		get:get,
		modify:modify,
		remove:remove,
		validate:validate
	}; 	
})(); 	