<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>     
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>회원가입</title>
        <link href="/resources/dist/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <style>
        .invalid{color:red !important;}
        .valid{color:green !important;}
        </style>
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
                                    	<h6><medium class="invalid">*</medium>(별표)가 있는 항목만 필수값입니다.</h6>
                                        <form action="/member/join" method="post"  onsubmit="return joinSubmit();">
                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <div class="form-group">
                                                <label class="small mb-1" for="id">아이디<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4" id="id" name="id" type="text" value="${memberVO.id}" placeholder="아이디를 입력하세요."/>
                                                <small class="valid">영문(소문자만),숫자 만 가능</small>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                       <label class="small mb-1" for="pw">비밀번호<medium class="invalid">*</medium></label>
                                                	   <input class="form-control py-4" id="pw" name="pw" type="password"  value="${memberVO.pw}"  placeholder="비밀번호를 입력하세요." />
                                                	   <small class="valid">영문(대/소문자),숫자,특수문자 가능</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="pw2">비밀번호 재확인<medium class="invalid">*</medium></label>
                                                        <input class="form-control py-4" id="pw2" name="pw2" type="password"  placeholder="비밀번호 재확인을 입력하세요."/>
                                                        <small class="valid">영문(대/소문자),숫자,특수문자 가능</small>
                                                    </div>
                                                </div>  
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="name">이름<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4" id="name" name="name" type="text" maxlength="8"  value="${memberVO.name}" placeholder="이름을 입력하세요."/>
                                                <small class="valid"></small>
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="phone">휴대폰<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4" id="phone" name="phone" type="phone"  value="${memberVO.phone}" placeholder="01012341234" />
                                                <small class="valid">숫자만 가능</small>
                                            </div>                                                                                                                                      
                                            <div class="form-group">
                                                <label class="small mb-1" for="email">이메일<medium class="invalid">*</medium></label>
                                                <input class="form-control py-4" id="email" name="email" type="email"  value="${memberVO.email}"  placeholder="aaa@gmail.com" />
                                                <small class="valid">이메일 형식에 맞춰 입력</small>
                                            </div>
                                           	<div class="form-group">
                                           		<input type="hidden" name="favorites" />
                                                <label class="small mb-1" for="favorite">종류</label>
                                            	<div id="favorite">
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorite" value="1" <c:if test="${fn:contains(memberVO.favorites, '1')}">checked</c:if>>공연
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorite" value="2" <c:if test="${fn:contains(memberVO.favorites, '2')}">checked</c:if>>영화
														</label>
													</div>
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorite" value="3" <c:if test="${fn:contains(memberVO.favorites, '3')}">checked</c:if>>독서
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorite" value="4" <c:if test="${fn:contains(memberVO.favorites, '4')}">checked</c:if>>관람
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorite" value="5" <c:if test="${fn:contains(memberVO.favorites, '5')}">checked</c:if>>스포츠
														</label>
													</div>	
	                                            	<div class="form-check-inline">
														<label class="form-check-label">
															<input type="checkbox" class="form-check-input" name="favorite" value="6" <c:if test="${fn:contains(memberVO.favorites, '6')}">checked</c:if>>기타
														</label>
													</div>
												</div>								
                                            </div>
                                            <div class="form-group mt-4 mb-0"><button type="submit" class="btn btn-primary btn-block">회원가입</button></div>
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
        <script src="/resources/scripts/member.js"></script>
		<script>
		$(document).ready(function(){
			var form = $("form"); 
			$(".form-control").on("blur",function(){
				memberService.validate($(this));	
			});
			hasErrors();
		});
		
		function joinSubmit(){
			
			//invalid 한번 더 체크
			$(".form-control").each(function(i){
				memberService.validate($(this));
			});				
			
			//필수항목 체크
			if(!checkItem($("input[name='id']"))) return false;
			if(!checkItem($("input[name='pw']"))) return false;
			if(!checkItem($("#pw2"))) return false;
			if(!checkItem($("input[name='name']"))) return false;			
			if(!checkItem($("input[name='phone']"))) return false;
			if(!checkItem($("input[name='email']"))) return false;
			
		
			//체크된 관심사만 저장
			var checked =""; 
			$("input:checkbox[name=favorite]:checked").each(function() {
				checked+=$(this).val()+","; 
			});
			if(checked.includes(",")) checked = checked.substr(0, checked.length-1);
			$("input[name='favorites']").val(checked);
			
			
			if(confirm("가입하시겠습니까?")){
				form.sumbit(); 
			}
		}
		
		//invalid 항목 검사
		function checkItem(item){
			if(item.siblings('small').hasClass("invalid")){
				item.focus(); 
				return false; 
			}else {
				return true; 
			}	
		}
		
		//서버에서 받아온 error 검사
		function hasErrors(){
			<spring:hasBindErrors name="memberVO">
			$(".form-control").each(function(){
				memberService.validate($(this));	
			}); 
			</spring:hasBindErrors>			
		}
		</script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/dist/js/scripts.js"></script>
    </body>
</html>
