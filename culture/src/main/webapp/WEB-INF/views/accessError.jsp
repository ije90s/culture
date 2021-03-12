<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="UTF-8"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Access Denined Page</title>
</head>
<body>
<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
<h2><c:out value="${msg }"/></h2>
</body>
</html>