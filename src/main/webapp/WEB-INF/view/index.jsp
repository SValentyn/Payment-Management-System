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
<body>
<div class="main">
    <!-- Header -->
    <div class="header header-without-margin">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="logo">
                        <a href="/" onfocus="this.blur()">
                            <img src="resources/images/logo-white.png" alt="Logotype"/></a>
                        <h1>Payment Management System</h1>
                        <form class="language-form">
                            <select id="language" name="language" onchange="submit()" onfocus="this.blur()">
                                <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
                                <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
                                <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
                            </select>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="login-bg">
        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper" style="top: 30px;">
                        <div class="box">
                            <div class="content-wrap">
                                <h4 style="margin-bottom: 22px;">
                                    <fmt:message key="login.signin"/><br>Payment Management System
                                </h4>
                                <h4>
                                    Status: <abbr style="color: red">Beta</abbr>
                                </h4>

                                <div class="form-group group-btn" style="margin-bottom: 30px;">
                                    <form action="/" role="form" method="POST" style="width: 100%;">
                                        <input type="hidden" name="command" value="login">
                                        <input type="hidden" name="login" value="0000000000">
                                        <input type="hidden" name="password" value="000000">

                                        <button type="submit" class="btn btn-default" onfocus="this.blur()">
                                            Beta-User
                                        </button>
                                    </form>

                                    <form action="/" role="form" method="POST" style="width: 100%;">
                                        <input type="hidden" name="command" value="login">
                                        <input type="hidden" name="login" value="1111111111">
                                        <input type="hidden" name="password" value="111111">

                                        <button type="submit" class="btn btn-default" onfocus="this.blur()">
                                            Beta-Admin
                                        </button>
                                    </form>
                                </div>

                                <fmt:message key="login.phone" var="phone"/>
                                <fmt:message key="login.password" var="password"/>
                                <fmt:message key="login.submit" var="submit"/>

                                <form action="/" role="form" method="POST">
                                    <input type="hidden" name="command" value="login"/>

                                    <!-- Login -->
                                    <input class="form-control" name="login" type="text"
                                           style="margin-bottom: 18px;" maxlength="10"
                                           placeholder="${phone}"
                                           value="${phoneValue}"/>

                                    <!-- Password -->
                                    <input class="form-control" name="password" type="password"
                                           placeholder="${password}"
                                           value="${passwordValue}"/>

                                    <!-- Error Label -->
                                    <label class="enter-error-label">
                                        <c:if test="${phoneError}">
                                            <fmt:message key="login.phoneError"/>
                                        </c:if>
                                        <c:if test="${passwordError}">
                                            <fmt:message key="login.passwordError"/>
                                        </c:if>
                                        <c:if test="${loginError}">
                                            <fmt:message key="login.loginError"/>
                                        </c:if>
                                    </label>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 10px 0 0 0;">
                                        <button type="submit" class="btn btn-primary signup"
                                                style="font-size: 18px;" onfocus="this.blur()">
                                            ${submit}
                                            <i class="glyphicon glyphicon-log-in" style="padding-left: 10px;"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="already">
                            <p><fmt:message key="login.dontHaveAccount"/></p>
                            <a href="?command=registration" onfocus="this.blur()">
                                <fmt:message key="login.signup"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>

