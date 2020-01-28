<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html>
<head>
    <title>Ooops...</title>
    <meta http-equiv="Content-Language" content="en"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="resources/css/styles.css" rel="stylesheet" type="text/css">
</head>
<body class="login-bg">
<div class="header">
    <div class="container" style="margin-left: 0px;margin-right: 0px;">
        <div class="row">
            <div class="col-md-12">
                <div class="logo" style="display: flex">
                    <a href="/"><img src="resources/images/logo-white.png" alt="Logotype"/></a>
                    <h1>Payment Management System</h1>
                </div>
            </div>
        </div>
    </div>
    <form class="language-form">
        <select id="language" name="language" onchange="submit()">
            <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
            <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
            <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
        </select>
    </form>
</div>
<fmt:message key="error.404" var="error_404"/>
<fmt:message key="error.500" var="error_500"/>

<c:set var="code" value="${requestScope['javax.servlet.error.status_code']}" scope="page"/>
<c:if test="${code == '404'}">
    <c:set var="errorMessage" value="${error_404}" scope="page"/>
</c:if>
<c:if test="${code == '500'}">
    <c:set var="errorMessage" value="${error_500}" scope="page"/>
</c:if>

<div style="text-align: center; margin-top: 180px;">
    <span id="error_detail_message">
         <c:if test="${not empty code}">
             <h1 class="code">●&nbsp;&nbsp;<c:out value="${code}"/>&nbsp;&nbsp;●</h1>
         </c:if>

         <c:if test="${not empty errorMessage}">
             <h1 style="margin-bottom: 60px;"><c:out value="${errorMessage}"/></h1>
         </c:if>
    </span>
    <a class="back-homepage" href="/">GO TO HOMEPAGE</a>
</div>
<jsp:include page="template/footer.jsp"/>
</body>
</html>