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
        <title>Page Title - SB Admin</title>
        <link href="/resources/dist/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
					<div class="container">
				    	<div class="row justify-content-center">
				        	<div class="col-lg-5">
				            	<div class="card shadow-lg border-0 rounded-lg mt-5">
				                	<div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3>
				                	<h2><c:out value="${error}"/></h2>
									<h2><c:out value="${logout}"/></h2>
				                	</div>
				                    <div class="card-body">
				                    	<form method="post" action="/login">
				                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                        	<div class="form-group">
				                            	<label class="small mb-1" for="username">아이디</label>
				                                <input class="form-control py-4" id="username" name="username" type="text" placeholder="아이디를 입력하세요" />
				                            </div>
				                            <div class="form-group">
				                                <label class="small mb-1" for="password">비밀번호</label>
				                                <input class="form-control py-4" id="password" name="password" type="password" placeholder="비밀번호를 입력하세요." />
				                             </div>
				                             <div class="form-group">
				                             	<div class="custom-control custom-checkbox">
				                                	<input class="custom-control-input" id="rememberCheck" name="remember-me" type="checkbox"  />
				                                    <label class="custom-control-label" for="rememberCheck">자동로그인</label>
				                                </div>
				                             </div>
				                             <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
				                             	<a class="small" href="#">아이디/비밀번호찾기</a>
				                                <a class="btn btn-primary">로그인</a>
				                             </div>
				                        </form>
				                     </div>
				                     <div class="card-footer text-center">
				                     	<div class="small"><a href="/member/join">회원가입</a></div>
				                     </div>
				                </div>
				        	</div>
						</div>
					</div>
				 </main>
            </div>	
	 </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="resources/dist/js/scripts.js"></script>
        <script>
        $(document).ready(function(){
        	var form = $("form");
        	$(".btn-primary").on("click",function(e){
        		e.preventDefault(); 
        		console.log("로그인 클릭");
        		chkLogin();
        		form.submit();
        	});
        	
        	$("#password").keyup(function(e){
        		if(e.keyCode == 13){
        			form.submit();
        		}
        	});
        	
        	function chkLogin(){
        		if(form.find("input[name='id']").val() == ""){
        			alert("아이디를 입력하세요.");
        			return false;
        		}
        
				if(form.find("input[name='password']").val() == ""){
					alert("아이디를 입력하세요.");
					return false;
				}       
       			return true;
        	}
        });
        </script>
    </body>
</html>