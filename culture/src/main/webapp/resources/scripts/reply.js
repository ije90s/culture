console.log("Reply Module...........");

var replyService = (function(){
	
	function add(reply, callback){
		console.log("reply.................");
		
		$.ajax({
			type : 'post', 
			url : '/reply/new', 
			data  : JSON.stringify(reply),
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
	
	function getListPaging(param, callback, error){
		console.log("getListPaging................."); 
		
		var bno = param.bno; 
		var page = param.page||1; 
		
		$.getJSON("/reply/pages/"+bno+"/"+page+".json",
			function(data){
				if(callback){
					//callback(data); 
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error(); 
				}
			}); 
	}
	
	function remove(rno, replyer, callback, error){
		console.log("remove........................."); 
		
		$.ajax({
			type : 'delete', 
			url : '/reply/'+rno,
			data : JSON.stringify({rno:rno, replyer:replyer}), 
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
	
	function modify(reply, callback, error){
		console.log("modify................"); 
		$.ajax({
			type : 'put', 
			url : '/reply/'+reply.rno, 
			data : JSON.stringify(reply), 
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
	
	function get(rno, callback, error){
		console.log("get........................."); 
		
		$.get("/reply/"+rno+".json", function(result){
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
		var str = ""; 
		var yy = dateObj.getFullYear(); 
		var mm = dateObj.getMonth()+1; 
		var dd = dateObj.getDate(); 
		var hh = dateObj.getHours(); 
		var mi = dateObj.getMinutes(); 
		var ss = dateObj.getSeconds(); 
		
		return [yy, '-', (mm<10?'0':'')+mm, '-', (dd<10?'0':'')+dd, ' ', (hh<10?'0':'')+hh, ":", (mi<10?'0':'')+mi, ":", (ss<10?'0':'')+ss].join('');
		
	}
	

	return {
		add:add,
		getListPaging:getListPaging,
		remove:remove, 
		modify:modify,
		get:get,
		displyTime:displyTime
	}; 
})(); 
