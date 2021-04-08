<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>문화일기</title>
        <link href="/resources/dist/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
   		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">비밀번호 찾기</h3></div>
                                    <div class="card-body">
                                        <div class="small mb-3 text-muted">입력한 이메일로 임시 비밀번호가 발급됩니다.</div>
                                        <form>
                                            <div class="form-group">
                                                <label class="small mb-1" for="id">아이디</label>
                                                <input class="form-control py-4" id="id" name="id" type="text" placeholder="아이디를 입력하세요." />
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="email">이메일</label>
                                                <input class="form-control py-4" id="email" name="email" type="email" placeholder="이메일을 입력하세요." />
                                            </div>
                                            <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <a class="small" href="/customLogin">로그인화면으로</a>
                                                <a class="btn btn-primary submit" href="#">확인</a>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center">
                                        <div class="small"><a href="/member/join">계정이 필요하신가요? 회원가입으로</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script>
        $(document).ready(function(){
  
        	var csrfHeader = "${_csrf.headerName}";
        	var csrfToken = "${_csrf.token}";
        	
        	$(document).ajaxSend(function(e, xhr, options){
        		xhr.setRequestHeader(csrfHeader, csrfToken);
        	});      	
        	var form = $("form"); 
        	
        	$(".submit").click(function(e){
        		var id = form.find("input[name='id']").val(); 
        		var email = form.find("input[name='email']").val(); 
        		if(!id){alert("아이디를 입력하세요."); return;}
        		if(!email){alert("이메일을 입력하세요."); return;}
        		$.ajax({
    				url : "/member/findPw",
    				type : "POST",
    				data : {
    					id : id,
    					email : email
    				},
    				success : function(result) {
    					alert(result);
    				},
    			})
        	});
        });
        </script>
    </body>
</html>
