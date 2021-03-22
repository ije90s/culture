

var cultureService = (function(){
	function validate(t){
		var space = /\s/g;
		var reg = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		var name=t.attr("name"); 
		var value=t.val(); 
		var small = t.siblings('small'); 
		var msg="", tag="valid"; 
		if(name=="cdate"){
			if(value==""){
				msg = "날짜를 입력하세요.";
				tag = "invalid";
			}else if(value.match(space)){
				msg = "공백이 포함되어 있습니다."; 
				tag = "invalid";
			}else if(!reg.test(value)){
				msg = "형식이 맞지 않습니다."; 
				tag = "invalid"; 
			}
		}else if(name=="kind"){
			small=$(".kind");
			var str=""; 
			if(!t.is(':checked') && str!=""){
				msg = "종류를 선택하세요.";
				tag = "invalid";
			}else {
				msg = "";
				tag = "";
				str = t.is(':checked'); 
			}
		}else{
			if(value==""){
				msg = "제목을 입력하세요.";
				tag = "invalid";
			}else if(value.length > 25){
				msg = "최대 25자까지 가능합니다.";
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