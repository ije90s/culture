<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp"  %>
                    <div class="container-fluid">
                        <h1 class="mt-4">게시판 상세</h1>
                        <div class="card mb-4">
                            <div class="card-header"></div>
                            <div class="card-body">
                            	<form role="form" action="/board/register" method="post">
                            		<input type="hidden" name="writer" value="user01" />
                            		<div class="form-group">
                            			<label class="small mb-1" for="kind">구분</label>
                            			<select name="kind" id="kind">
                            				<option value="">선택</option>
                            				<option value="free">자유게시판</option>
                            				<option value="question">문의사항</option>
                            			</select>
                            		</div>
	                            	<div class="form-group">
	                                	<label class="small mb-1" for="title">제목 </label>
	                                    <input class="form-control py-4" name="title" id="title"" type="text"/>
	                                </div>
	                                <div class="form-group">
	                                	<label class="small mb-1" for="content">내용</label>
	                                    <textarea class="form-control" name="content" rows="5" id="content"></textarea>
									</div>
									<div class="form-group">
									사진 첨부
									</div>
	                                <div class="form-group mt-4 mb-0 text-right">
	                                    <button type="submit" class="btn btn-primary">등록</button>
										<button type="reset" class="btn btn-secondary">취소</button>
	                                </div>
                                </form>                  				
                            </div> <!-- card-body 끝  -->
                        </div> <!-- card mb-4 끝 -->                            
                	</div> <!-- container-fluid 끝 -->   
<%@ include file="../includes/footer.jsp"  %> 