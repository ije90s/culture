<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
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
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.min.js"></script>    
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="/">문화일기</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form id="searchTotalForm" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0" action="/search" method="get">
            	<input type="hidden" name="type" value="TC" />
                <div class="input-group">
		            <input class="form-control" type="text" id="searchText" name="keyword" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" />
	                <div class="input-group-append">
						<button id="searchBtn" class="btn btn-primary" type="button"><i class="fas fa-search"></i></button>
	                </div>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <sec:authorize access="isAuthenticated()">
                        	<a class="dropdown-item" href='/member/myprofile/<sec:authentication property="principal.username"/>'>나의 정보</a>
		                        <sec:authorize access="hasRole('ROLE_MEMBER')">
		                        <a class="dropdown-item" href="/activity">나의 활동</a>
		                        <a class="dropdown-item" href='/report/list/<sec:authentication property="principal.username"/>?tab=all'>신고리스트</a>
		                        </sec:authorize>
                        		<div class="dropdown-divider"></div>
                        		<a class="dropdown-item" href="#" onclick="document.getElementById('logoutForm').submit();"><i class="fa fa-toggle-off"></i> Logout</a>
	                        	<form id="logoutForm" action="/customLogout" method="POST">
	   								<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
								</form>
                        </sec:authorize>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                        	<sec:authorize access="isAuthenticated()">
	                        	<sec:authorize access="hasRole('ROLE_ADMIN')">
		                            <div class="sb-sidenav-menu-heading">회원</div>
		                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#memberLayouts" aria-expanded="false" aria-controls="collapseLayouts">
		                                                                        회원관리
		                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
		                            </a>
		                            <div class="collapse" id="memberLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
		                                <nav class="sb-sidenav-menu-nested nav">
		                                    <a class="nav-link" href='/member/list'>회원정보</a>
		                                    <a class="nav-link" href='/log/list'>회원로그</a>
		                                </nav>
		                            </div>
	                            </sec:authorize> 
	                            <sec:authorize access="hasAnyRole('ROLE_MEMBER','ROLE_USER')">                   
		                            <div class="sb-sidenav-menu-heading">문화기록</div>
		                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
		                                                                        나의 기록
		                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
		                            </a>
		                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
		                                <nav class="sb-sidenav-menu-nested nav">
		                                    <a class="nav-link" href='/culture/list/<sec:authentication property="principal.username"/>'>리스트</a>
		                                    <a class="nav-link" href='/culture/stats/<sec:authentication property="principal.username"/>'>통계</a>
		                                </nav>
		                            </div>
		                        </sec:authorize>    
	                            <div class="sb-sidenav-menu-heading">게시판</div>
	                            <a class="nav-link" href="/board/list/notice">공지사항</a>
	                            <a class="nav-link" href="/board/list/free">자유게시판</a>
	                            <a class="nav-link" href="/board/list/question">질문&답변</a>
	                            <a class="nav-link" href="/board/list/share">공유마당</a>
	                            <sec:authorize access="hasRole('ROLE_ADMIN')"> 
	                             <div class="sb-sidenav-menu-heading">그 외</div>
	                             <a class="nav-link" href="/culture/list/all">문화기록</a>  
		                         <a class="nav-link" href="/report/list/all?tab=all">신고리스트</a>
		        			     <a class="nav-link" href="/unjoin/list">탈퇴리스트</a>            
		                        </sec:authorize> 
	                        </sec:authorize>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
            	<main>
