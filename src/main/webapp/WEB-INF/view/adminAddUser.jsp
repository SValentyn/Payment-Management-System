<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="admin.addUser.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${added == true}">
        <div id="alert" class="alert alert-success fade in" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertUserAdded"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${phoneExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertPhoneExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert addUserError -->
    <c:if test="${addUserError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="registration.failed"/></strong>
                <fmt:message key="admin.addUser.alertAddUserError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="page-content container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-wrapper">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="admin.addUser.addNewUser" var="addNewUser"/>
                                    <fmt:message key="registration.name" var="name"/>
                                    <fmt:message key="registration.surname" var="surname"/>
                                    <fmt:message key="registration.email" var="email"/>
                                    <fmt:message key="admin.addUser.button" var="button"/>
                                    <fmt:message key="admin.addUser.backButton" var="backButton"/>
                                    <fmt:message key="admin.addUser.nameError" var="nameError"/>
                                    <fmt:message key="admin.addUser.surnameError" var="surnameError"/>
                                    <fmt:message key="registration.phoneError" var="phoneError"/>
                                    <fmt:message key="registration.emailError" var="emailError"/>
                                    <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                    <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                    <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                    <fmt:message key="registration.correct" var="correct"/>

                                    <h4>
                                        ${addNewUser}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="addUser">

                                        <!-- Name -->
                                        <input id="name" name="name" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                               maxlength="24" placeholder="${name}*"
                                               value="${nameValue}"/>
                                        <label for="name" class="default-label">
                                            <span id="valid-msg-name" class="hide">${correct} ✓</span>
                                            <span id="error-msg-name" class="hide">${nameError}</span>
                                        </label>

                                        <!-- Surname -->
                                        <input id="surname" name="surname" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                               maxlength="24" placeholder="${surname}*"
                                               value="${surnameValue}"/>
                                        <label for="surname" class="default-label">
                                            <span id="valid-msg-surname" class="hide">${correct} ✓</span>
                                            <span id="error-msg-surname" class="hide">${surnameError}</span>
                                        </label>

                                        <!-- Phone -->
                                        <div style="margin-top: 1px;">
                                            <input id="phone" name="phone" type="tel" class="form-control"
                                                   style="padding-left: 94px;"
                                                   data-toggle="tooltip" data-title="${tooltipPhone}"
                                                   onkeypress="onlyNumbers()"
                                                   value="${phoneValue}"/>
                                            <label for="phone" class="default-label">
                                                <span id="valid-msg-phone" class="hide">${correct} ✓</span>
                                                <span id="error-msg-phone" class="hide">${phoneError}</span>
                                            </label>
                                        </div>

                                        <!-- Email -->
                                        <input id="email" name="email" class="form-control"
                                               type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                               maxlength="45" placeholder="${email}"
                                               value="${emailValue}"/>
                                        <label for="email" class="default-label">
                                            <span id="valid-msg-email" class="hide">${correct} ✓</span>
                                            <span id="error-msg-email" class="hide">${emailError}</span>
                                        </label>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 20px 0 10px 0;">
                                            <button id="submit" type="submit" class="btn btn-primary signup"
                                                    style="padding: 0;" onfocus="this.blur()">
                                                ${button}
                                            </button>
                                        </div>

                                        <!-- Back -->
                                        <c:choose>
                                            <c:when test="${created == true}">
                                                <div class="action" style="padding: 0 0 10px 0;">
                                                    <button type="button" class="btn btn-default signup"
                                                            onfocus="this.blur()">
                                                        <a href="?command=attachAccount&userId=${userId}">
                                                                ${backButton}
                                                        </a>
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="action" style="padding: 0 0 10px 0;">
                                                    <button type="button" class="btn btn-default signup"
                                                            disabled="disabled" onfocus="this.blur()">
                                                        <a href="?command=attachAccount&userId=${userId}">
                                                                ${backButton}
                                                        </a>
                                                    </button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
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
<script src="resources/js/validator_adminAddUser.js"></script>
</body>
</html>