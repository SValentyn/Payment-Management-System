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
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
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

    <!-- Alert loginError -->
    <c:if test="${loginError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="login.alertFailed"/></strong> <fmt:message key="login.alertLoginError"/></p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

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

                                <div class="form-group group-btn" style="margin-bottom: 35px;">
                                    <form action="/" role="form" method="POST" style="width: 100%;">
                                        <input type="hidden" name="command" value="login">
                                        <input type="hidden" name="full_phone" value="0000000000">
                                        <input type="hidden" name="password" value="000000">

                                        <button type="submit" class="btn btn-default" onfocus="this.blur()">
                                            Beta-User
                                        </button>
                                    </form>

                                    <form action="/" role="form" method="POST" style="width: 100%;">
                                        <input type="hidden" name="command" value="login">
                                        <input type="hidden" name="full_phone" value="1111111111">
                                        <input type="hidden" name="password" value="111111">

                                        <button type="submit" class="btn btn-default" onfocus="this.blur()">
                                            Beta-Admin
                                        </button>
                                    </form>
                                </div>

                                <fmt:message key="login.phone" var="phone"/>
                                <fmt:message key="login.password" var="password"/>
                                <fmt:message key="login.submit" var="submit"/>
                                <fmt:message key="login.correct" var="correct"/>
                                <fmt:message key="login.phoneError" var="phoneError"/>
                                <fmt:message key="login.passwordError" var="passwordError"/>

                                <form action="/" role="form" method="POST">
                                    <input type="hidden" name="command" value="login"/>

                                    <!-- Login -->
                                    <input id="login" name="login" type="tel" class="form-control"
                                           style="padding-left: 94px; margin-bottom: 18px;"
                                           onkeypress="onlyNumbers()"
                                           value="${loginValue}"/>
                                    <label for="login" class="valid-error-label">
                                        <span id="valid-msg-login" class="hide">${correct} ✓</span>
                                        <span id="error-msg-login" class="hide">${phoneError}</span>
                                    </label>

                                    <!-- Password -->
                                    <div class="password-input">
                                        <input type="password" id="password" name="password" class="form-control"
                                               style="margin-top: 10px;" placeholder="${password}*"
                                               value=${passwordValue}>
                                        <a href="#" class="password-control"
                                           onclick="return show_hide_password(this);"></a>
                                    </div>
                                    <label for="password" class="valid-error-label">
                                        <span id="error-msg-password" class="hide">${passwordError}</span>
                                    </label>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 20px 0 0 0;">
                                        <button id="submit" type="submit" class="btn btn-primary signup"
                                                style="font-size: 18px;" onfocus="this.blur()">
                                            ${submit}
                                            <i class="glyphicon glyphicon-log-in" style="padding-left: 11px;"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="already">
                            <p><fmt:message key="login.forgotPassword"/></p>
                            <a href="?command=restore" onfocus="this.blur()">
                                <fmt:message key="login.recovery"/>
                            </a>
                            <br>
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
<script src="resources/js/validator_index.js"></script>
</body>
</html>

