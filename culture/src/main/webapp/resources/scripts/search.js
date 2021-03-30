var serachService = (function(){
	
	function culture(param, callback, error){	
		var page=param.page;
		var type=param.type; 
		var keyword=param.keyword; 
		
		$.getJSON("/culture/search/pages/"+page+"/"+type+"/"+keyword+".json",
			function(data){
				if(callback){
					callback(data); 
				}
			}).fail(function(xhr, status, err){
				if(error){
					error(); 
				}
		});
	};
	
	function board(param, callback, error){	
		var tab=param.tab;
		var page=param.page;
		var type=param.type; 
		var keyword=param.keyword; 
		
		$.getJSON("/board/search/"+tab+"/pages/"+page+"/"+type+"/"+keyword+".json",
			function(data){
				if(callback){
					callback(data); 
				}
			}).fail(function(xhr, status, err){
				if(error){
					error(); 
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
	
	return {
		culture : culture,
		displyTime : displyTime,
		board : board
	}
})();	