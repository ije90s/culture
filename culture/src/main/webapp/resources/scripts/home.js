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

	function displyTime(time){
		var dateObj = new Date(time); 
		var yy = dateObj.getFullYear(); 
		var mm = dateObj.getMonth(); 
		var dd = dateObj.getDate(); 
		
		return [yy, '-', (mm<10?'0':'')+mm, '-', (dd<10?'0':'')+dd].join('');
		
	}
	
	return {
		cultureList : cultureList,
		boardList : boardList,  
		displyTime : displyTime
	};
})();