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
    <style>
        .bs-tooltip-right {
            margin-left: 11px;
        }
    </style>
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
                <div class="col-auto">
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
    <c:if test="${sended == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="recovery.success"/>!</strong>
                <fmt:message key="recovery.alertPasswordSent"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneNotExistError -->
    <c:if test="${phoneNotExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="recovery.failed"/>!</strong>
                <fmt:message key="recovery.alertPhoneNotExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="login-bg">
        <div class="page-content container-fluid">
            <div class="row justify-content-center">
                <div class="col-xl-3">
                    <div class="login-wrapper" style="top: 30px;">
                        <div class="box">
                            <div class="content-wrap">
                                <fmt:message key="recovery.formHeader" var="formHeader"/>
                                <fmt:message key="recovery.recoveryButton" var="button"/>
                                <fmt:message key="recovery.backButton" var="backButton"/>
                                <fmt:message key="login.phoneError" var="phoneError"/>
                                <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                <fmt:message key="login.correct" var="correct"/>

                                <h4>
                                    ${formHeader}
                                </h4>

                                <form action="" role="form" method="POST" novalidate>
                                    <input type="hidden" name="command" value="recovery">

                                    <!-- Phone -->
                                    <div>
                                        <input id="phone" name="phone" class="form-control"
                                               type="text" onkeypress="onlyNumbers();"
                                               data-toggle="tooltip" data-title="${tooltipPhone}"
                                               value="${phoneValue}">
                                        <label for="phone" class="default-label">
                                            <span id="valid-msg-phone" class="valid-msg invisible">
                                                ${correct}<img src="resources/images/correct.png" alt="">
                                            </span>
                                            <span id="error-msg-phone" class="error-msg invisible">${phoneError}</span>
                                        </label>
                                    </div>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 25px 0 10px 0">
                                        <button id="submit" type="submit" class="btn btn-primary signup">
                                            ${button}
                                        </button>
                                    </div>
                                </form>

                                <!-- Back Button -->
                                <div class="action" style="padding: 0 0 10px 0">
                                    <form action="/" method="GET">
                                        <input type="submit" class="btn btn-default signup" value="${backButton}">
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
<script src="resources/js/validator_recovery.js"></script>
</html>