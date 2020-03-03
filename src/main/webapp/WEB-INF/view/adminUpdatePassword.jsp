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
    <title><fmt:message key="user.changePassword.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${updated == true}">
        <div id="alert" class="alert alert-success fade in" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertPasswordUpdated"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert passwordUpdateError -->
    <c:if test="${passwordUpdateError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertPasswordUpdateError"/>
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
                                    <fmt:message key="user.changePassword.formHeader" var="formHeader"/>
                                    <fmt:message key="user.changePassword.newPassword" var="newPassword"/>
                                    <fmt:message key="registration.confirmation" var="confirmation"/>
                                    <fmt:message key="user.changePassword.oldPassword" var="oldPassword"/>
                                    <fmt:message key="user.updateData.changePasswordButton" var="changePasswordButton"/>
                                    <fmt:message key="registration.passwordError" var="passwordError"/>
                                    <fmt:message key="registration.passwordConfirmationError"
                                                 var="passwordConfirmationError"/>
                                    <fmt:message key="user.changePassword.oldPasswordError" var="oldPasswordError"/>
                                    <fmt:message key="registration.tooltipPassword" var="tooltipNewPassword"/>
                                    <fmt:message key="registration.tooltipPasswordConfirmation"
                                                 var="tooltipPasswordConfirmation"/>
                                    <fmt:message key="user.changePassword.tooltipOldPassword" var="tooltipOldPassword"/>
                                    <fmt:message key="registration.correct" var="correct"/>

                                    <h4>
                                        ${formHeader}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="updatePassword">

                                        <!-- New Password -->
                                        <div>
                                            <div class="password-input">
                                                <input id="newPassword" name="newPassword" type="password"
                                                       class="form-control" style="height: 40px; margin: 0;"
                                                       data-toggle="tooltip" data-title="${tooltipNewPassword}"
                                                       placeholder="${newPassword}*"
                                                       value="${newPasswordValue}"/>
                                                <a href="#" class="password-control" style="top: 9px;"
                                                   onfocus="this.blur()"
                                                   onclick="return show_hide_newPassword(this);"></a>
                                            </div>
                                            <label for="newPassword" class="default-label">
                                                <span id="valid-msg-newPassword" class="hide">${correct} ✓</span>
                                                <span id="error-msg-newPassword" class="hide">${passwordError}</span>
                                            </label>
                                        </div>

                                        <!-- Password Confirmation -->
                                        <div>
                                            <div class="password-input">
                                                <input id="passwordConfirmation" name="passwordConfirmation"
                                                       class="form-control" type="password"
                                                       style="height: 40px; margin: 8px 0 0 0;"
                                                       data-toggle="tooltip" data-title="${tooltipPasswordConfirmation}"
                                                       placeholder="${confirmation}*"
                                                       value="${passwordConfirmationValue}"/>
                                                <a href="#" class="password-control" style="top: 9px;"
                                                   onfocus="this.blur()"
                                                   onclick="return show_hide_passwordConfirmation(this);"></a>
                                            </div>
                                            <label for="passwordConfirmation" class="default-label">
                                                <span id="valid-msg-passwordConfirmation"
                                                      class="hide">${correct} ✓</span>
                                                <span id="error-msg-passwordConfirmation" class="hide">
                                                    ${passwordConfirmationError}
                                                </span>
                                            </label>
                                        </div>

                                        <!-- Old Password -->
                                        <div>
                                            <div class="password-input">
                                                <input id="oldPassword" name="oldPassword" type="password"
                                                       class="form-control" style="height: 40px; margin: 8px 0 0 0;"
                                                       data-toggle="tooltip" data-title="${tooltipOldPassword}"
                                                       placeholder="${oldPassword}*"
                                                       value="${oldPasswordValue}"/>
                                                <a href="#" class="password-control" style="top: 9px;"
                                                   onfocus="this.blur()"
                                                   onclick="return show_hide_oldPassword(this);"></a>
                                            </div>
                                            <label for="oldPassword" class="default-label">
                                                <span id="valid-msg-oldPassword" class="hide">${correct} ✓</span>
                                                <span id="error-msg-oldPassword" class="hide">${passwordError}</span>
                                                <span id="passwordNotMatchError">
                                                <c:if test="${passwordNotMatchError}">
                                                    ${oldPasswordError}

                                                    <script>
                                                        document.querySelector("#passwordNotMatchError").classList.remove("hide");
                                                        document.querySelector("#valid-msg-oldPassword").classList.add("hide");
                                                        document.querySelector("#error-msg-oldPassword").classList.add("hide");
                                                    </script>
                                                </c:if>
                                            </span>
                                            </label>
                                        </div>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 25px 0 5px 0">
                                            <button id="submit" type="submit" class="btn btn-primary signup">
                                                ${changePasswordButton}
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
<script src="resources/js/validator_adminUpdatePassword.js"></script>
</body>
</html>