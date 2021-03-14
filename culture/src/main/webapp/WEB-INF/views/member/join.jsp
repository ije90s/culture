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
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">회원가입</h3></div>
                                    <div class="card-body">
                                        <form action="/member/join" method="post">
                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <div class="form-group">
                                                <label class="small mb-1" for="id">아이디</label>
                                                <input class="form-control py-4" id="id" name="id" type="text" aria-describedby="idHelp" placeholder="아이디를 입력하세요" />
                                                <div id="chkId"></div>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                       <label class="small mb-1" for="pw">비밀번호</label>
                                                	   <input class="form-control py-4" id="pw" name="pw" type="password" aria-describedby="pwHelp" placeholder="비밀번호를 입력하세요" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="comfirmPw">비밀번호 재확인</label>
                                                        <input class="form-control py-4" id="comfirmPw" type="password" placeholder="비밀번호를 입력하세요." />
                                                    </div>
                                                </div>
                                                <div id="chkPw"></div>
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="name">이름</label>
                                                <input class="form-control py-4" id="name" name="name" type="text" aria-describedby="nameHelp" placeholder="이름을 입력하세요" />
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="phone">휴대폰</label>
                                                <input class="form-control py-4" id="phone" name="phone" type="phone" aria-describedby="phoneHelp" placeholder="01012341234(숫자입력)" />
                                            </div>                                                                                                                                      
                                            <div class="form-group">
                                                <label class="small mb-1" for="email">이메일</label>
                                                <input class="form-control py-4" id="email" name="email" type="email" aria-describedby="emailHelp" placeholder="aaa@gmail.com" />
                                            </div>
                                           	<div class="form-group">
                                                <label class="small mb-1" for="kind">종류</label>
                                            	<div id="kind">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorites" value="1">공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorites" value="2">영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorites" value="3">독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorites" value="4">관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorites" value="5">스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorites" value="6">기타
														</label>
													</div>
												</div>								
                                            </div>
                                            <div class="form-group mt-4 mb-0"><button class="btn btn-primary btn-block">회원가입</button></div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center">
                                        <div class="small"><a href="/customLogin">계정이 있으십니까? 로그인화면으로 이동</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="/resources/scripts/join.js"></script>
        <script>
        $(document).ready(function(){
        	var form = $("form"); 
        	$(".btn").click(function(e){
        		e.preventDefault(); 
        		//console.log("클릭됨");
        		
        		if(confirm("가입하시겠습니까?")){
        			form.submit();
        		}
        	});
			//console.log(joinService);        	
        	$("#id").on("blur", function(e){
        		e.preventDefault();
        		//console.log("아이디 체크");
        		var id = $(this).val(); 
        		var chkId = $("#chkId"); 
        		if(id == ""){
        			chkId.html("아이디를 입력하세요."); 
        			return;
        		}       		
        		joinService.chkId(id, function(data){
        			if(data=="ok"){
        				chkId.html("아이디 등록가능합니다.");
        			}else{
        				chkId.html("중복된 아이디입니다.");
        			}
        		});
        	});
        	
        	$("#comfirmPw").on("blur",function(e){
        		e.preventDefault();
        		console.log("비밀번호 확인"); 
        		var pw = $("#pw").val(); 
        		var comfirmPw = $(this).val(); 
        		var chkPw = $("#chkPw"); 
        		
        		if(pw=="" || comfirmPw==""){
        			chkPw.html("비밀번호 또는 비밀번호재확인을 입력하세요.");
        			return; 
        		}
        		
        		if(pw!=comfirmPw){
        			chkPw.html("비밀번호가 일치하지 않습니다."); 
        		}else{
        			chkPw.html("비밀번호가 맞습니다.");
        		}
        	});
        });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/dist/js/scripts.js"></script>
    </body>
</html>
