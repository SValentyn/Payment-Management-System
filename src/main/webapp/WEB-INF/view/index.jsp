<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="login.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
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

<div class="page-content container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="login-wrapper">
                <div class="box">
                    <div class="content-wrap">
                        <h6></h6>
                        <p></p>
                        <p></p>
                        <p></p>
                        <h6>
                            <fmt:message key="login.signin"/>
                        </h6>
                        <fmt:message key="login.phone" var="phone"/>
                        <fmt:message key="login.password" var="password"/>
                        <fmt:message key="login.submit" var="submit"/>

                        <form action="/" method="POST">
                            <input type="hidden" name="command" value="login"/>
                            <input class="form-control" name="login" type="text" placeholder="${phone}"
                                   style="margin-bottom: 18px;"
                                   value="${phoneValue}">
                            <input class="form-control" name="password" type="password" placeholder="${password}"
                                   value="${passwordValue}"/>
                            <label class="enter-error-label">
                                <c:if test="${phoneError}">
                                    <fmt:message key="login.phoneError"/>
                                </c:if>
                            </label>
                            <label class="enter-error-label">
                                <c:if test="${passwordError}">
                                    <fmt:message key="login.passwordError"/>
                                </c:if>
                            </label>
                            <label class="enter-error-label">
                                <c:if test="${loginError}">
                                    <fmt:message key="login.loginError"/>
                                </c:if>
                            </label>
                            <div class="action" style="padding-bottom: 0px;">
                                <input class="btn btn-primary signup" type="submit" value="${submit}"/>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="already">
                    <p><fmt:message key="login.dontHaveAccount"/></p>
                    <a href="?command=registration"><fmt:message key="login.signup"/></a>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>
</body>
</html>

