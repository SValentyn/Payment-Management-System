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
    <title><fmt:message key="registration.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
    <link rel="stylesheet" href="resources/css/style_registrationPage.css">
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
    <c:if test="${response eq 'registrationSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="registration.success"/>!</strong>
                <fmt:message key="registration.alertAccountCreated"/>
                <a href="/" class="alert-link"><fmt:message key="registration.logging"/></a>
                <fmt:message key="registration.intoYourAccount"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert incorrectRegistrationData -->
    <c:if test="${response eq 'incorrectRegistrationData'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="registration.failed"/>!</strong>
                <fmt:message key="registration.alertIncorrectRegistrationDataError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${response eq 'phoneExistError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="registration.failed"/>!</strong>
                <fmt:message key="registration.alertPhoneExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert emailExistError -->
    <c:if test="${response eq 'emailExistError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="registration.failed"/>!</strong>
                <fmt:message key="registration.alertEmailExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert registrationError -->
    <c:if test="${response eq 'registrationError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert" style="margin-top: 22px;">
            <p><strong><fmt:message key="registration.failed"/>!</strong>
                <fmt:message key="registration.alertRegistrationError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="login-bg">
        <div class="page-content container-fluid">
            <div class="row justify-content-center">
                <div class="col-xl-6">
                    <div class="row">
                        <div class="login-wrapper" style="top: 22px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="registration.formHeader" var="registration"/>
                                    <fmt:message key="registration.name" var="name"/>
                                    <fmt:message key="registration.surname" var="surname"/>
                                    <fmt:message key="registration.email" var="email"/>
                                    <fmt:message key="registration.password" var="password"/>
                                    <fmt:message key="registration.confirmation" var="confirmation"/>
                                    <fmt:message key="registration.nameError" var="nameError"/>
                                    <fmt:message key="registration.surnameError" var="surnameError"/>
                                    <fmt:message key="registration.phoneError" var="loginError"/>
                                    <fmt:message key="registration.emailError" var="emailError"/>
                                    <fmt:message key="registration.passwordError" var="passwordError"/>
                                    <fmt:message key="registration.passwordConfirmationError"
                                                 var="passwordConfirmationError"/>
                                    <fmt:message key="registration.signupButton" var="signupButton"/>
                                    <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                    <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                    <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                    <fmt:message key="registration.tooltipPassword" var="tooltipPassword"/>
                                    <fmt:message key="registration.tooltipPasswordConfirmation"
                                                 var="tooltipPasswordConfirmation"/>
                                    <fmt:message key="registration.correct" var="correct"/>

                                    <h4>
                                        ${registration}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="registration">

                                        <!-- Name -->
                                        <div class="form-row">
                                            <div class="col-md-6">
                                                <input id="name" name="name" class="form-control"
                                                       type="text" data-toggle="tooltip-left"
                                                       data-title="${tooltipOnlyLetters}"
                                                       maxlength="24" placeholder="${name}*"
                                                       value="${nameValue}"/>
                                                <label for="name" class="default-label">
                                                    <span id="valid-msg-name" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-name"
                                                          class="error-msg invisible">${nameError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Surname -->
                                            <div class="col-md-6">
                                                <input id="surname" name="surname" class="form-control"
                                                       type="text" data-toggle="tooltip"
                                                       data-title="${tooltipOnlyLetters}"
                                                       maxlength="32" placeholder="${surname}*"
                                                       value="${surnameValue}"/>
                                                <label for="surname" class="default-label">
                                                    <span id="valid-msg-surname" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-surname"
                                                          class="error-msg invisible">${surnameError}
                                                    </span>
                                                </label>
                                            </div>
                                        </div>

                                        <!-- Phone -->
                                        <div class="form-row">
                                            <div class="col-md-6" style="margin-top: 8px">
                                                <input id="phone" name="phone" type="tel" class="form-control"
                                                       data-toggle="tooltip-left" data-title="${tooltipPhone}"
                                                       onkeypress="onlyNumbers()"
                                                       value="${phoneValue}"/>
                                                <label for="phone" class="default-label">
                                                    <span id="valid-msg-phone" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-phone"
                                                          class="error-msg invisible">${loginError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Email -->
                                            <div class="col-md-6">
                                                <input id="email" name="email" class="form-control"
                                                       type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                                       maxlength="45" placeholder="${email}"
                                                       value="${emailValue}"/>
                                                <label for="email" class="default-label">
                                                    <span id="valid-msg-email" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-email" class="error-msg invisible">
                                                        ${emailError}
                                                    </span>
                                                </label>
                                            </div>
                                        </div>

                                        <!-- Password -->
                                        <div class="row justify-content-center" style="margin-top: 20px;">
                                            <div class="col-md-6">
                                                <div class="password-input">
                                                    <input id="password" name="password" type="password"
                                                           class="form-control"
                                                           data-toggle="tooltip" data-title="${tooltipPassword}"
                                                           placeholder="${password}*"
                                                           value="${passwordValue}"/>
                                                    <a href="#" class="password-control" style="top: 7px;"
                                                       onfocus="this.blur()"
                                                       onclick="return show_hide_password(this);"></a>
                                                </div>
                                                <label for="password" class="default-label">
                                                    <span id="valid-msg-password" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-password"
                                                          class="error-msg invisible">${passwordError}</span>
                                                </label>
                                            </div>
                                        </div>

                                        <!-- Password Confirmation -->
                                        <div class="row justify-content-center">
                                            <div class="col-md-6 ">
                                                <div class="password-input">
                                                    <input id="passwordConfirmation" name="passwordConfirmation"
                                                           type="password" class="form-control"
                                                           data-toggle="tooltip"
                                                           data-title="${tooltipPasswordConfirmation}"
                                                           placeholder="${confirmation}*"
                                                           value="${passwordConfirmationValue}"/>
                                                    <a href="#" class="password-control" style="top: 7px;"
                                                       onfocus="this.blur()"
                                                       onclick="return show_hide_passwordConfirmation(this);"></a>
                                                </div>
                                                <label for="passwordConfirmation" class="default-label">
                                                    <span id="valid-msg-passwordConfirmation"
                                                          class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-passwordConfirmation"
                                                          class="error-msg invisible">${passwordConfirmationError}</span>
                                                </label>
                                            </div>
                                        </div>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 25px 0 0 0;">
                                            <button id="submit" type="submit"
                                                    class="btn btn-primary signup" style="width: 44%;">
                                                ${signupButton}
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="already">
                                <p><fmt:message key="registration.haveAccountAlready"/></p>
                                <a href="/" onfocus="this.blur()">
                                    <fmt:message key="registration.login"/>
                                </a>
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
<script src="resources/js/validator_registrationPage.js"></script>
</html>