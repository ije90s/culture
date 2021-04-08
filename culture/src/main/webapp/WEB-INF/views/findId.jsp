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
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">아이디 찾기</h3></div>
                                    <div class="card-body">
                                        <div class="small mb-3 text-muted">이메일과 이름을 적어주세요.</div>
                                        <form>
                                            <div class="form-group">
                                                <label class="small mb-1" for="name">이름</label>
                                                <input class="form-control py-4" id="name" name="name" type="text" placeholder="이름을 입력하세요." />
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
		<script src="/resources/scripts/home.js"></script>
        <script>
        $(document).ready(function(){
        	var form = $("form"); 
        	$(".submit").click(function(e){
        		e.preventDefault(); 
        		var member; 
        		var name = form.find("input[name='name']").val(); 
        		var email = form.find("input[name='email']").val(); 
        		if(!name){
        			alert("이름을 입력하세요"); 
        			return; 
        		}
        		if(!email){
        			alert("이메일을 입력하세요"); 
        			return; 
        		}	
        		homeService.getId(name, email, function(data){
        			alert("아이디는 "+data.id+"입니다.");
        		}, function(error){
        			alert("해당 되는 아이디가 없습니다.");
        		});
        	});
        });
        </script>
    </body>
</html>
