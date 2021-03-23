

var boardService = (function(){
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
		validate : validate
	};
})(); 