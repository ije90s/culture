

var msgService = (function(){
	
	function getList(type, username, page, callback, error){
		$.get("/message/pages/"+type+"/"+username+"/"+page+".json", function(result){
			if(callback){
				callback(result.msgCnt, result.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		}); 
	};
	
	function displyTime(time){
		var dateObj = new Date(time); 
		var yy = dateObj.getFullYear(); 
		var mm = dateObj.getMonth()+1; 
		var dd = dateObj.getDate(); 
		
		return [yy, '-', (mm<10?'0':'')+mm, '-', (dd<10?'0':'')+dd].join('');
		
	}	
	
	function get(mno, userid, callback, error){
		$.get("/message/"+mno+"/"+userid+".json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		}); 
	}
	
	function modify(msg, callback, error){
		$.ajax({
			type : 'put', 
			url : '/message/'+msg.mno, 
			data : JSON.stringify(msg), 
			contentType : "application/json; charset=UTF-8", 
			success : function(result, status, xhr){
				if(callback){
					callback(result); 
				}
			}, 
			error : function(xhr, status, er){
				if(error){
					error(xhr);
				}
			}
		});			
	}
	
	function remove(mno, callback, error){
		$.ajax({
			type : 'delete', 
			url : '/message/'+mno, 
			success : function(result, status, xhr){
				if(callback){
					callback(result); 
				}
			}, 
			error : function(xhr, status, er){
				if(error){
					error(xhr);
				}
			}
		});				
	}
	
	function add(msg, callback, error){
		$.ajax({
			type : 'post', 
			url : '/message/new', 
			data : JSON.stringify(msg), 
			contentType : "application/json; charset=UTF-8", 
			success : function(result, status, xhr){
				if(callback){
					callback(result); 
				}
			}, 
			error : function(xhr, status, er){
				if(error){
					error(xhr);
				}
			}
		});			
	}
	
	return {
		getList : getList,
		displyTime : displyTime,
		get : get,
		modify : modify,
		remove : remove,
		add : add
	};
})();
