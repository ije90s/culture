console.log("최근 글 가져오기"); 

var homeService = (function(){
	
	
	function cultureList(param, callback, error){
		
		var mno = param.mno; 
		var category = param.category; 
		
		$.get("/"+category+"/"+mno+"/top.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		}); 
	}
	
	function boardList(kind, callback, error){
		$.get("/board/"+kind+"/top.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		}); 
	}
	
	function countList(type, callback, error){
		$.get("/member/count/"+type+".json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		}); 		
	}
	
	function reportList(callback, error){
		$.get("/report/top.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});	
	}
	
	function chartList(callback, error){
		$.get("/unjoin/chart.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});	
	}	
	
	function loginCount(id, callback, error){
		
		$.get("/login/"+id+"/count.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});		
	}
	
	function cultureCount(mno, callback, error){
		
		$.get("/culture/"+mno+"/count.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});		
	}
	
	function boardCount(writer, callback, error){
		
		$.get("/board/writer/"+writer+"/count.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});		
	}
	
	function replyCount(replyer, callback, error){
		
		$.get("/reply/"+replyer+"/count.json", function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});		
	}			
	
	function getBoardList(writer, page, callback, error){
		console.log("getListPaging................."); 
		
		$.getJSON("/board/writer/"+writer+"/pages/"+page+".json",
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
	
	function getReplyList(replyer, page, callback, error){
		console.log("getListPaging................."); 
		
		$.getJSON("/reply/"+replyer+"/pages/"+page+".json",
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
	
	function displyTime(time){
		var dateObj = new Date(time); 
		var yy = dateObj.getFullYear(); 
		var mm = dateObj.getMonth()+1; 
		var dd = dateObj.getDate(); 
		
		return [yy, '-', (mm<10?'0':'')+mm, '-', (dd<10?'0':'')+dd].join('');
		
	}
	
	return {
		cultureList : cultureList,
		boardList : boardList,  
		displyTime : displyTime,
		countList : countList,
		reportList : reportList,
		chartList : chartList,
		loginCount : loginCount,
		cultureCount : cultureCount,
		boardCount : boardCount, 
		replyCount : replyCount,
		getBoardList : getBoardList,
		getReplyList : getReplyList
	};
})();