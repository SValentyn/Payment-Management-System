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
    <title><fmt:message key="recovery.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
    <link rel="stylesheet" href="resources/css/style_recoveryPage.css">
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

    <!-- Alert Success -->
    <c:if test="${response eq 'passwordSent'}">
        <div id="alert" class="alert alert-success fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="recovery.success"/>!</strong>
                <fmt:message key="recovery.alertPasswordSent"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert loginNotExist -->
    <c:if test="${response eq 'loginNotExist'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="recovery.failed"/>!</strong>
                <fmt:message key="login.alertLoginNotExistError"/>
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
                    <div class="login-wrapper" style="top: 30px;">
                        <div class="box" style="max-width: 85%;">
                            <div class="content-wrap">
                                <fmt:message key="recovery.formHeader" var="formHeader"/>
                                <fmt:message key="recovery.recoveryButton" var="recoveryButton"/>
                                <fmt:message key="recovery.backButton" var="backButton"/>
                                <fmt:message key="login.loginError" var="loginError"/>
                                <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                <fmt:message key="login.correct" var="correct"/>

                                <h4>
                                    ${formHeader}
                                </h4>

                                <form action="" method="POST" role="form">
                                    <input type="hidden" name="command" value="recovery">

                                    <!-- Login -->
                                    <div>
                                        <input id="login" name="login" type="text" class="form-control"
                                               data-toggle="tooltip" data-title="${tooltipPhone}"
                                               onkeypress="onlyNumbers();"
                                               value="${loginValue}">
                                        <label for="login" class="default-label">
                                            <span id="valid-msg-login" class="valid-msg invisible">
                                                ${correct}<img src="resources/images/correct.png" alt="">
                                            </span>
                                            <span id="error-msg-login" class="error-msg invisible">
                                                ${loginError}
                                            </span>
                                        </label>
                                    </div>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 25px 0 10px 0">
                                        <button id="submit" type="submit" class="btn btn-primary signup">
                                            ${recoveryButton}
                                        </button>
                                    </div>
                                </form>

                                <!-- Back Button -->
                                <div class="action back-btn">
                                    <form action="/" method="GET" role="form">
                                        <button type="submit" class="btn btn-primary signup btn-default">
                                            ${backButton}
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/validator_recoveryPage.js"></script>
</html>