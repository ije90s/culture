<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Error Page</title>
        <link href="/resources/dist/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <div id="layoutError">
            <div id="layoutError_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="text-center mt-4">
                                    <h1 class="display-1">
                                    <c:if test="${not empty msg}">${msg }</c:if> 
                                    <c:if test="${empty msg }">${requestScope['javax.servlet.error.status_code']}</c:if>
                                    </h1>
                                    <c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
                                    <img class="mb-4 img-error" src="/resources/image/error-404-monochrome.svg" />
                                    </c:if>
                                    <p class="lead">
                                    	<c:if test="${empty msg}">
											<c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
												잘못 된 요청입니다.
											</c:if>												
											<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
												요청하신 페이지를 찾을 수 없습니다.   
											</c:if>											
											<c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
												요청된 메소드가 허용되지 않습니다.
											</c:if>											
											<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
												서버에 오류가 발생하여 요청을 수행할 수 없습니다.
											</c:if>											
											<c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
												서비스를 사용할 수 없습니다.
											</c:if>
										</c:if>
										<c:if test="${not empty msg }">접근할 수 없습니다.</c:if>                   
                                    </p>
                                    <a href="javascript:history.back(-1);"><i class="fas fa-arrow-left mr-1"></i>이전화면으로</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/resources/dist/js/scripts.js"></script>
    </body>
</html>
