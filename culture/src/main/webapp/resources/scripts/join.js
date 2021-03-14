console.log("회원가입 유효성 검사"); 

var joinService = (function(){
	
	function chkId(id, callback, error){
		
		$.get("/member/"+id, function(result){
			if(callback){
				callback(result); 
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(er); 
			}
		});	
	}
	
	
	return {
		chkId : chkId
	};
})();