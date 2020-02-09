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
                            <img src="resources/images/logo-white.png" alt="Logotype"/>
                        </a>
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

    <!-- Alert Success -->
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 493px; margin-top: 22px;">
            <p><strong>Success!</strong> Account created. Try <a href="/" class="alert-link">logging</a>
                into your account.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${phoneExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 466px; margin-top: 22px;">
            <p><strong>Failed!</strong> A user with such a phone is already registered.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert registrationError -->
    <c:if test="${registrationError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 494px; margin-top: 22px;">
            <p><strong>Failed!</strong> Sorry, but we were unable to register you. Try later.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="login-bg">
        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper" style="top: 22px;">
                        <div class="box" style="padding-bottom: 0;">
                            <div class="content-wrap">
                                <fmt:message key="registration.formHeader" var="registration"/>
                                <fmt:message key="registration.name" var="name"/>
                                <fmt:message key="registration.surname" var="surname"/>
                                <fmt:message key="registration.email" var="email"/>
                                <fmt:message key="registration.password" var="password"/>
                                <fmt:message key="registration.confirmation" var="confirmation"/>
                                <fmt:message key="registration.nameError" var="nameError"/>
                                <fmt:message key="registration.surnameError" var="surnameError"/>
                                <fmt:message key="registration.phoneError" var="phoneError"/>
                                <fmt:message key="registration.emailError" var="emailError"/>
                                <fmt:message key="registration.passwordError" var="passwordError"/>
                                <fmt:message key="registration.passwordConfirmationError"
                                             var="passwordConfirmationError"/>
                                <fmt:message key="registration.correct" var="correct"/>
                                <fmt:message key="registration.signupButton" var="signupButton"/>
                                <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                <fmt:message key="registration.tooltipPassword" var="tooltipPassword"/>
                                <fmt:message key="registration.tooltipPasswordConfirmation"
                                             var="tooltipPasswordConfirmation"/>

                                <h4>
                                    ${registration}
                                </h4>

                                <form action="" role="form" method="POST">
                                    <input type="hidden" name="command" value="registration">

                                    <!-- Name -->
                                    <input id="name" name="name" class="form-control" style="height: 36px;"
                                           type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                           maxlength="24" placeholder="${name}*"
                                           value="${nameValue}"/>
                                    <label for="name" class="reg-error-label">
                                        <span id="valid-msg-name" class="hide">${correct} ✓</span>
                                        <span id="error-msg-name" class="hide">${nameError}</span>
                                    </label>

                                    <!-- Surname -->
                                    <input id="surname" name="surname" class="form-control" style="height: 36px;"
                                           type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                           maxlength="24" placeholder="${surname}*"
                                           value="${surnameValue}">
                                    <label for="surname" class="reg-error-label">
                                        <span id="valid-msg-surname" class="hide">${correct} ✓</span>
                                        <span id="error-msg-surname" class="hide">${surnameError}</span>
                                    </label>

                                    <!-- Phone -->
                                    <input id="phone" name="phone" type="tel" class="form-control"
                                           style="height: 36px; padding-left: 94px;"
                                           data-toggle="tooltip" data-title="${tooltipPhone}"
                                           onkeypress="onlyNumbers()"
                                           value="${phoneValue}"/>
                                    <label for="phone" class="reg-error-label">
                                        <span id="valid-msg-phone" class="hide">${correct} ✓</span>
                                        <span id="error-msg-phone" class="hide">${phoneError}</span>
                                    </label>

                                    <!-- Email -->
                                    <input id="email" name="email" class="form-control" style="height: 36px;"
                                           type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                           maxlength="45" placeholder="${email}"
                                           value="${emailValue}">
                                    <label for="email" class="reg-error-label">
                                        <span id="valid-msg-email" class="hide">${correct} ✓</span>
                                        <span id="error-msg-email" class="hide">${emailError}</span>
                                    </label>

                                    <!-- Password -->
                                    <input id="password" name="password" class="form-control" style="height: 36px;"
                                           type="password" data-toggle="tooltip" data-title="${tooltipPassword}"
                                           placeholder="${password}*"
                                           value=${passwordValue}>
                                    <label for="password" class="reg-error-label">
                                        <span id="valid-msg-password" class="hide">${correct} ✓</span>
                                        <span id="error-msg-password" class="hide">${passwordError}</span>
                                    </label>

                                    <!-- Password Confirmation -->
                                    <input id="passwordConfirmation" name="passwordConfirmation"
                                           class="form-control" style="height: 36px;" type="password"
                                           data-toggle="tooltip" data-title="${tooltipPasswordConfirmation}"
                                           placeholder="${confirmation}*"
                                           value=${passwordConfirmationValue}>
                                    <label for="passwordConfirmation" class="reg-error-label">
                                        <span id="valid-msg-passwordConfirmation" class="hide">${correct} ✓</span>
                                        <span id="error-msg-passwordConfirmation" class="hide">
                                            ${passwordConfirmationError}
                                        </span>
                                    </label>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 17px 0 30px 0">
                                        <button id="submit" type="submit"
                                                class="btn btn-primary signup" onfocus="this.blur()">
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
    <jsp:include page="template/footer.jsp"/>
</div>
<script src="resources/js/validator_registration.js"></script>
</body>
</html>