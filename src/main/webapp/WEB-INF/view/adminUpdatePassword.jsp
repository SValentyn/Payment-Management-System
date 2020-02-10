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
                                    <fmt:message key="user.updateData.changePasswordButton" var="updatePasswordButton"/>
                                    <fmt:message key="registration.tooltipPassword" var="tooltipNewPassword"/>
                                    <fmt:message key="registration.tooltipPasswordConfirmation"
                                                 var="tooltipPasswordConfirmation"/>
                                    <fmt:message key="user.updateData.tooltipPassword" var="tooltipOldPassword"/>

                                    <h4>
                                        ${formHeader}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="updatePassword">

                                        <!-- New Password -->
                                        <input id="newPassword" name="newPassword"
                                               class="form-control" style="margin: 0;" type="password"
                                               data-toggle="tooltip" data-title="${tooltipNewPassword}"
                                               placeholder="${newPassword}*"
                                               value=${newPasswordValue}>
                                        <label for="newPassword" class="default-label">
                                            <c:if test="${newPasswordError}">
                                                <fmt:message key="registration.passwordError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Password Confirmation -->
                                        <input id="passwordConfirmation" name="passwordConfirmation"
                                               class="form-control" style="margin: 5px 0 0 0;" type="password"
                                               data-toggle="tooltip" data-title="${tooltipPasswordConfirmation}"
                                               placeholder="${confirmation}*"
                                               value=${passwordConfirmationValue}>
                                        <label for="passwordConfirmation" class="default-label">
                                            <c:if test="${passwordConfirmationError}">
                                                <fmt:message key="registration.passwordConfirmationError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Old Password -->
                                        <input id="oldPassword" name="oldPassword"
                                               class="form-control" style="margin: 5px 0 0 0;" type="password"
                                               data-toggle="tooltip" data-title="${tooltipOldPassword}"
                                               placeholder="${oldPassword}*"
                                               value=${oldPasswordValue}>
                                        <label for="oldPassword" class="default-label">
                                            <c:if test="${oldPasswordError}">
                                                <fmt:message key="user.changePassword.oldPasswordError"/>
                                            </c:if>
                                        </label>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 15px 0 5px 0">
                                            <button type="submit" class="btn btn-primary signup" onfocus="this.blur()">
                                                ${updatePasswordButton}
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
</html>