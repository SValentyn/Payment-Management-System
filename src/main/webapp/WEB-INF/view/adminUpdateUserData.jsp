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
    <title><fmt:message key="admin.updateUserData.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${response eq 'dataUpdatedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertUserDataUpdated"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetUserId -->
    <c:if test="${response eq 'unableGetUserId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetUserIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert invalidData -->
    <c:if test="${response eq 'invalidData'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="registration.failed"/>!</strong>
                <fmt:message key="admin.page.alertInvalidDataError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${response eq 'phoneExistError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertPhoneExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert emailExistError -->
    <c:if test="${response eq 'emailExistError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="registration.failed"/>!</strong>
                <fmt:message key="admin.page.alertEmailExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert dataUpdatedError -->
    <c:if test="${response eq 'dataUpdatedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUpdateUserDataError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <div class="page-content container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-xl-6 offset-xl-2 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <fmt:message key="admin.updateUserData.formHeader" var="formHeader"/>
                                        <fmt:message key="registration.name" var="name"/>
                                        <fmt:message key="registration.surname" var="surname"/>
                                        <fmt:message key="registration.email" var="email"/>
                                        <fmt:message key="user.updateData.updateDataButton" var="updateDataButton"/>
                                        <fmt:message key="registration.nameError" var="nameError"/>
                                        <fmt:message key="registration.surnameError" var="surnameError"/>
                                        <fmt:message key="registration.phoneError" var="loginError"/>
                                        <fmt:message key="registration.emailError" var="emailError"/>
                                        <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                        <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                        <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                        <fmt:message key="registration.correct" var="correct"/>
                                        <fmt:message key="admin.attachAccount.returnToUserProfile"
                                                     var="returnToUserProfile"/>

                                        <h4>
                                            ${formHeader}
                                        </h4>

                                        <form action="/" role="form" method="POST">
                                            <input type="hidden" name="command" value="updateUserData">

                                            <!-- User Id -->
                                            <input id="userId" name="userId" type="hidden" value="${userId}"/>

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
                                                        <span id="error-msg-name" class="error-msg invisible">
                                                            ${nameError}
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
                                                        <span id="error-msg-surname" class="error-msg invisible">
                                                            ${surnameError}
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>

                                            <!-- Phone -->
                                            <div class="row justify-content-center">
                                                <div class="col-md-9" style="margin-top: 8px">
                                                    <input id="phone" name="phone" type="tel" class="form-control"
                                                           data-toggle="tooltip" data-title="${tooltipPhone}"
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
                                            </div>

                                            <!-- Email -->
                                            <div class="row justify-content-center">
                                                <div class="col-md-9">
                                                    <input id="email" name="email" class="form-control"
                                                           type="email" data-toggle="tooltip"
                                                           data-title="${tooltipEmail}"
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

                                            <!-- Submit -->
                                            <c:choose>
                                                <c:when test="${response ne 'unableGetUserId'}">
                                                    <div class="action" style="padding: 25px 0 10px 0">
                                                        <button id="submit" type="submit" class="btn btn-primary signup"
                                                                style="width: 56%;">
                                                                ${updateDataButton}
                                                        </button>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="action" style="padding: 25px 0 10px 0">
                                                        <button type="submit" class="btn btn-primary signup disabled"
                                                                style="width: 56%;">
                                                                ${updateDataButton}
                                                        </button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>

                                        <!-- Return to User Profile -->
                                        <c:choose>
                                            <c:when test="${response ne 'unableGetUserId'}">
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUser">
                                                        <input type="hidden" name="userId" value="${userId}">
                                                        <button type="submit" class="btn btn-primary signup btn-default"
                                                                style="width: 56%;">
                                                                ${returnToUserProfile}
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUser">
                                                        <input type="hidden" name="userId" value="${userId}">
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default disabled"
                                                                style="width: 56%;">
                                                                ${returnToUserProfile}
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
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
<script src="resources/js/validator_adminUpdateUserData.js"></script>
</html>