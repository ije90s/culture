<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp"  %>

                    <div class="container-fluid">
                        <h1 class="mt-4">나의 기록</h1>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i> 리스트형
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>NO.</th>
                                                <th>종류</th>
                                                <th>제목</th>
                                                <th>내용</th>
                                                <th>날짜</th>
                                            </tr>
                                        </thead>
     									<tbody>
     									<c:forEach var="culture" items="${list}">     	
     										<tr>										
     											<td>${culture.cno}</td>
     											<td>
     												<c:if test="${culture.kind eq 1}">공연</c:if> 
     												<c:if test="${culture.kind eq 2}">영화</c:if> 
     												<c:if test="${culture.kind eq 3}">독서</c:if> 
     												<c:if test="${culture.kind eq 4}">관람</c:if> 
     												<c:if test="${culture.kind eq 5}">스포츠</c:if> 
     												<c:if test="${culture.kind eq 6}">기타</c:if> 
     											</td>
     											<td>${culture.title}</td>
     											<td>${culture.content}</td>
     											<td><fmt:formatDate value="${culture.cdate}" pattern="yyyy-MM-dd"/></td>
     										</tr>
     									</c:forEach>
                                        </tbody>
                                    </table>  <!-- table 끝  -->
                                </div> <!-- table-responsive 끝  -->
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->
                	</div> <!-- container-fluid 끝 -->   
                	
<%@ include file="../includes/footer.jsp"  %>
              