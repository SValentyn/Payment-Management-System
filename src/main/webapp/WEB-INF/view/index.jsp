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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
    <link rel="stylesheet" href="resources/css/style_indexPage.css">
</head>
<body>
<div class="main">

    <!-- Header -->
    <div class="header header-without-margin">
        <div class="container-fluid">
            <div class="row">
                <div class="col-auto mr-auto">
                    <div class="logo">
                        <a href="/" onfocus="this.blur()">
                            <img src="resources/images/logo-white.png" alt="Logotype"/>
                        </a>
                        <h1>Payment Management System</h1>
                    </div>
                </div>
                <div class="col-auto ml-auto">
                    <nav class="navbar navbar-expand-lg">
                        <div class="collapse navbar-collapse show" role="navigation">
                            <div class="navbar-nav">
                                <div class="nav-item" style="margin-left: 10%;">
                                    <form class="language-form">
                                        <select id="language" name="language"
                                                onchange="submit()"
                                                onfocus="this.blur()">
                                            <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
                                            <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
                                            <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
                                        </select>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <!-- Alert loginNotExist -->
    <c:if test="${response eq 'loginNotExist'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="login.failed"/></strong>
                <fmt:message key="login.alertLoginNotExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert invalidData -->
    <c:if test="${response eq 'invalidData'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="login.failed"/></strong>
                <fmt:message key="login.alertInvalidLoginDataError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert authenticationError -->
    <c:if test="${response eq 'authenticationError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="login.failed"/></strong>
                <fmt:message key="login.alertAuthenticationError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="login-bg">
        <div class="page-content container-fluid">
            <div class="row justify-content-center">
                <div class="col-md-3">
                    <fmt:message key="login.signin" var="signin"/>
                    <fmt:message key="login.password" var="password"/>
                    <fmt:message key="login.submit" var="submit"/>
                    <fmt:message key="login.loginError" var="loginError"/>
                    <fmt:message key="login.passwordError" var="passwordError"/>
                    <fmt:message key="login.correct" var="correct"/>

                    <div class="login-wrapper" style="top: 30px;">
                        <div class="box" style="max-width: 75%;">
                            <div class="content-wrap">

                                <h4 style="margin-bottom: 20px;">
                                    ${signin}<br>
                                    Payment Management System
                                </h4>
                                <h4 style="margin-bottom: 20px">
                                    Status: <abbr style="color: red">Beta</abbr>
                                </h4>

                                <div class="form-group group-btn" style="height: 60px; margin-bottom: 24px;">
                                    <form action="/" role="form" method="POST" style="width: 100%; align-self: center;">
                                        <input type="hidden" name="command" value="login">
                                        <input type="hidden" name="full_phone" value="+34645364524">
                                        <input type="hidden" name="password" value="000000">
                                        <button type="submit" class="btn btn-primary signup btn-default">
                                            Beta-User
                                        </button>
                                    </form>

                                    <form action="/" role="form" method="POST" style="width: 100%; align-self: center;">
                                        <input type="hidden" name="command" value="login">
                                        <input type="hidden" name="full_phone" value="+393524594551">
                                        <input type="hidden" name="password" value="111111">
                                        <button type="submit" class="btn btn-primary signup btn-default">
                                            Beta-Admin
                                        </button>
                                    </form>
                                </div>

                                <form action="/" method="POST" role="form">
                                    <input type="hidden" name="command" value="login"/>

                                    <!-- Login -->
                                    <div>
                                        <input id="login" name="login" type="tel" class="form-control"
                                               onkeypress="onlyNumbers()"
                                               value="${loginValue}"/>
                                        <label for="login" class="default-label">
                                            <span id="valid-msg-login" class="valid-msg invisible">
                                                ${correct}<img src="resources/images/correct.png" alt="">
                                            </span>
                                            <span id="error-msg-login" class="error-msg invisible">
                                                ${loginError}
                                            </span>
                                        </label>
                                    </div>

                                    <!-- Password -->
                                    <div>
                                        <div class="password-input">
                                            <input type="password" id="password" name="password"
                                                   class="form-control" style="margin-top: 10px;"
                                                   placeholder="${password}">
                                            <a href="#" class="password-control"
                                               onfocus="this.blur()"
                                               onclick="return show_hide_password(this);"></a>
                                        </div>
                                        <label for="password" class="default-label">
                                            <span id="valid-msg-password" class="valid-msg invisible">
                                                ${correct}<img src="resources/images/correct.png" alt="">
                                            </span>
                                            <span id="error-msg-password" class="error-msg invisible">
                                                ${passwordError}
                                            </span>
                                        </label>
                                    </div>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 20px 0 0 0;">
                                        <button id="submit" type="submit" class="btn btn-primary signup"
                                                style="font-size: 18px;">
                                            ${submit}
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Block of Questions -->
                        <div class="block-questions">
                            <p style="margin-bottom: 6px;">
                                <fmt:message key="login.forgotPassword"/>
                            </p>
                            <a href="?command=recovery" onfocus="this.blur()">
                                <fmt:message key="login.recovery"/>
                            </a>
                            <br>
                            <p style="margin-bottom: 8px;">
                                <fmt:message key="login.dontHaveAccount"/>
                            </p>
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
<script src="resources/js/validator_indexPage.js"></script>
</html>

