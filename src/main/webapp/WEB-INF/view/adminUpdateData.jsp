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
    <title><fmt:message key="user.updateData.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${updated == true}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertDataUpdated"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${phoneExistError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertPhoneExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert updateDataError -->
    <c:if test="${updateDataError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertDataUpdateError"/>
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
                                    <fmt:message key="user.updateData.formHeader" var="formHeader"/>
                                    <fmt:message key="registration.name" var="name"/>
                                    <fmt:message key="registration.surname" var="surname"/>
                                    <fmt:message key="registration.email" var="email"/>
                                    <fmt:message key="user.updateData.password" var="password"/>
                                    <fmt:message key="user.updateData.updateDataButton" var="updateDataButton"/>
                                    <fmt:message key="user.updateData.changePasswordButton" var="changePasswordButton"/>
                                    <fmt:message key="registration.nameError" var="nameError"/>
                                    <fmt:message key="registration.surnameError" var="surnameError"/>
                                    <fmt:message key="registration.phoneError" var="phoneError"/>
                                    <fmt:message key="registration.emailError" var="emailError"/>
                                    <fmt:message key="registration.passwordError" var="passwordError"/>
                                    <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                    <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                    <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                    <fmt:message key="user.updateData.tooltipPassword" var="tooltipPassword"/>
                                    <fmt:message key="registration.correct" var="correct"/>

                                    <h4>
                                        ${formHeader}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="profile">

                                        <!-- Name -->
                                        <div>
                                            <input id="name" name="name" class="form-control"
                                                   type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                                   maxlength="24" placeholder="${name}*"
                                                   value="${nameValue}"/>
                                            <label for="name" class="default-label">
                                                <span id="valid-msg-name" class="hide">${correct} ✓</span>
                                                <span id="error-msg-name" class="hide">${nameError}</span>
                                            </label>
                                        </div>

                                        <!-- Surname -->
                                        <div style="margin-bottom: 8px;">
                                            <input id="surname" name="surname" class="form-control"
                                                   type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                                   maxlength="24" placeholder="${surname}*"
                                                   value="${surnameValue}"/>
                                            <label for="surname" class="default-label">
                                                <span id="valid-msg-surname" class="hide">${correct} ✓</span>
                                                <span id="error-msg-surname" class="hide">${surnameError}</span>
                                            </label>
                                        </div>

                                        <!-- Phone -->
                                        <div>
                                            <input id="phone" name="phone" type="tel" class="form-control"
                                                   style="padding-left: 94px;" data-toggle="tooltip"
                                                   data-title="${tooltipPhone}"
                                                   onkeypress="onlyNumbers()"
                                                   value="${phoneValue}"/>
                                            <label for="phone" class="default-label">
                                                <span id="valid-msg-phone" class="hide">${correct} ✓</span>
                                                <span id="error-msg-phone" class="hide">${phoneError}</span>
                                            </label>
                                        </div>

                                        <!-- Email -->
                                        <div>
                                            <input id="email" name="email" class="form-control"
                                                   type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                                   maxlength="45"
                                                   placeholder="${email}"
                                                   value="${emailValue}"/>
                                            <label for="email" class="default-label">
                                                <span id="valid-msg-email" class="hide">${correct} ✓</span>
                                                <span id="error-msg-email" class="hide">${emailError}</span>
                                            </label>
                                        </div>

                                        <!-- Password -->
                                        <div>
                                            <div class="password-input">
                                                <input id="password" name="password" class="form-control"
                                                       type="password"
                                                       data-toggle="tooltip" data-title="${tooltipPassword}"
                                                       placeholder="${password}*"
                                                       value="${passwordValue}"/>
                                                <a href="#" class="password-control" style="top: 9px;"
                                                   onfocus="this.blur()"
                                                   onclick="return show_hide_password(this);"></a>
                                            </div>
                                            <label for="password" class="default-label">
                                                <span id="valid-msg-password" class="hide">${correct} ✓</span>
                                                <span id="error-msg-password" class="hide">${passwordError}</span>
                                                <span id="passwordNotMatchError">
                                                    <c:if test="${passwordNotMatchError}">
                                                        <fmt:message key="user.updateData.passwordError"/>

                                                        <script>
                                                            document.querySelector("#passwordNotMatchError").classList.remove("hide");
                                                            document.querySelector("#valid-msg-password").classList.add("hide");
                                                            document.querySelector("#error-msg-password").classList.add("hide");
                                                        </script>
                                                    </c:if>
                                                </span>
                                            </label>
                                        </div>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 20px 0 10px 0">
                                            <button id="submit" type="submit" class="btn btn-primary signup">
                                                ${updateDataButton}
                                            </button>
                                        </div>

                                        <!-- Change Password Button -->
                                        <div class="action">
                                            <button type="button" class="btn btn-default signup">
                                                <a href="?command=updatePassword">
                                                    ${changePasswordButton}
                                                </a>
                                            </button>
                                        </div>
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
<script src="resources/js/validator_adminUpdateData.js"></script>
</html>