<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
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
				                	</div>
				                    <div class="card-body">
				                    	<form method="post" action="/login" class="needs-validation" novalidate>
				                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                        	<div class="form-group">
				                            	<label class="small mb-1" for="username">아이디</label>
				                                <input class="form-control py-4" id="username" name="username" type="text" placeholder="입력 후 엔터키를 누르세요." required/>
				                                <div class="invalid-feedback">아이디를 입력하세요.</div>
				                            </div>
				                            <div class="form-group">
				                                <label class="small mb-1" for="password">비밀번호</label>
				                                <input class="form-control py-4" id="password" name="password" type="password" placeholder="입력 후 엔터키를 누르세요." required />
				                                <div class="invalid-feedback">비밀번호를 입력하세요.</div>
				                             </div>
				                             <div class="form-group">
				                             	<div class="custom-control custom-checkbox">
				                                	<input class="custom-control-input" id="rememberCheck" name="remember-me" type="checkbox"/>
				                                    <label class="custom-control-label" for="rememberCheck">자동로그인</label>
				                                </div>
				                             </div>
				                             <div class="form-group align-items-center justify-content-between mt-4 mb-0">
				                             	<a class="small" href="/findId">아이디/</a><a class="small" href="/findPw">비밀번호 찾기</a>  
				                                <button type="submit" class="btn btn-primary float-right">로그인</button>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="/resources/dist/js/scripts.js"></script>
        <script>
       	  var error = '<c:out value="${error}"/>'; 
       	  var logout = '<c:out value="${logout}"/>'; 
       	  if(error!=""){
       		 alert(error);
       	  }    	  
       	  if(logout!=""){
       		 alert(logout);
       	  }
       
	     // Disable form submissions if there are invalid fields
	     (function() {
	       'use strict';
	       window.addEventListener('load', function() {
	         // Get the forms we want to add validation styles to
	         var forms = document.getElementsByClassName('needs-validation');
	         // Loop over them and prevent submission
	         var validation = Array.prototype.filter.call(forms, function(form) {
	           form.addEventListener('submit', function(event) {
	             if (form.checkValidity() === false) {
	               event.preventDefault();
	               event.stopPropagation();
	             }
	             form.classList.add('was-validated');
	           }, false);
	         });
	       }, false);
	     })();
        </script>
    </body>
</html>