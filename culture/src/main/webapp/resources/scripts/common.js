

	/*파일 형식 및 사이즈 체크 */
	var regex = new RegExp("(.*?)\.(jpg|png|gif|bmp)$"); 
	var maxSize = 5242880; 
	function checkExtension(fileName, fileSize){
		if(fileSize > maxSize){
			alert("파일 사이즈가 초과되었습니다."); 
			return false; 
		}
		
		if(!regex.test(fileName)){
			alert("사진 파일 형식만 가능합니다.");
			return false; 
		}
		
		return true; 
	}

	/* 파일 첨부 List Group 보여주기 */
	function showUploadResult(uploadResultArr){
		var str="";  
		$(uploadResultArr).each(function(i, obj){
			
			if(!obj.image){			
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName); 
				var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g),"/");  
				str+="<li class='list-group-item' data-path='"+obj.uploadPath+"'";
				str+=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'/>";
				str+="<div><span>"+obj.fileName+"</span>";
				str+="<button type='button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'></i></button><br>";
				str+="<a href=\"javascript:showImg(\'"+originPath+"')\"><img src='/display?fileName="+fileCallPath+"' /></a>";
				str+="</div></li>"; 
			}
		});
	
		$(".uploadResult ul").append(str);
	}

	/*이미지 원본 보기 */
	function showImg(originPath){
		$(".originPictureWrapper").css("display", "flex").show(); 
		$(".originPicture").html("<img src='/display?fileName="+originPath+"'/>")
		.animate({width:'100%', height:'100%'},1000);		
	}

	