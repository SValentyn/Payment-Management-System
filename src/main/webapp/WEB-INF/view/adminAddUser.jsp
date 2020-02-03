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
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert -->
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 438px;">
            <p><strong>Success!</strong> The user has been added to the system.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${phoneExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 460px;">
            <p><strong>Failed!</strong> A user with that phone number already exists.</p>
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
                        <div class="login-wrapper" style="top: 0px;">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="admin.addUser.addNewUser" var="addNewUser"/>
                                    <fmt:message key="registration.name" var="name"/>
                                    <fmt:message key="registration.surname" var="surname"/>
                                    <fmt:message key="registration.phone" var="phone"/>
                                    <fmt:message key="registration.email" var="email"/>
                                    <fmt:message key="registration.password" var="password"/>
                                    <fmt:message key="registration.confirmation" var="confirmation"/>
                                    <fmt:message key="admin.addUser.button" var="button"/>
                                    <fmt:message key="admin.addUser.backButton" var="backButton"/>
                                    <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                    <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                    <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                    <fmt:message key="registration.tooltipPassword" var="tooltipPassword"/>
                                    <fmt:message key="registration.tooltipPasswordConfirmation"
                                                 var="tooltipPasswordConfirmation"/>

                                    <h4>
                                        ${addNewUser}
                                    </h4>

                                    <form action="/" method="POST">
                                        <input type="hidden" name="command" value="addUser">

                                        <!-- Name -->
                                        <input id="name" name="name" class="form-control" style="height: 36px;"
                                               type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                               pattern="[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}" minlength="1" maxlength="24"
                                               placeholder="${name}*"
                                               value="${nameValue}"
                                        >
                                        <label for="name" class="reg-error-label">
                                            <c:if test="${nameError}">
                                                <fmt:message key="registration.nameError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Surname -->
                                        <input id="surname" name="surname" class="form-control" style="height: 36px;"
                                               type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                               pattern="[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}" minlength="1" maxlength="24"
                                               placeholder="${surname}*"
                                               value="${surnameValue}">
                                        <label for="surname" class="reg-error-label">
                                            <c:if test="${surnameError}">
                                                <fmt:message key="registration.surnameError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Phone -->
                                        <input id="phone" name="phone" class="form-control" style="height: 36px;"
                                               type="text" data-toggle="tooltip" data-title="${tooltipPhone}"
                                               maxlength="10" onkeypress="onlyNumbers();"
                                               placeholder="${phone}*"
                                               value="${phoneValue}">
                                        <label for="phone" class="reg-error-label">
                                            <c:if test="${phoneError}">
                                                <fmt:message key="registration.phoneError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Email -->
                                        <input id="email" name="email" class="form-control" style="height: 36px;"
                                               type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" maxlength="45"
                                               placeholder="${email}"
                                               value="${emailValue}">
                                        <label for="email" class="reg-error-label"></label>&nbsp;

                                        <!-- Password -->
                                        <input id="password" name="password" class="form-control" style="height: 36px;"
                                               type="password" data-toggle="tooltip" data-title="${tooltipPassword}"
                                               placeholder="${password}*"
                                               value=${passwordValue}>
                                        <label for="password" class="reg-error-label">
                                            <c:if test="${passwordError}">
                                                <fmt:message key="registration.passwordError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Password Confirmation -->
                                        <input id="passwordConfirmation" name="passwordConfirmation"
                                               class="form-control" style="height: 36px;" type="password"
                                               data-toggle="tooltip" data-title="${tooltipPasswordConfirmation}"
                                               placeholder="${confirmation}*"
                                               value=${passwordConfirmationValue}>
                                        <label for="passwordConfirmation" class="reg-error-label">
                                            <c:if test="${passwordConfirmationError}">
                                                <fmt:message key="registration.passwordConfirmationError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Submit -->
                                        <div class="action" style="padding-bottom: 20px;">
                                            <button type="submit" class="btn btn-primary signup"
                                                    style="height: 42px; padding: 0;" onfocus="this.blur()">
                                                ${button}
                                            </button>
                                        </div>

                                        <!-- Back -->
                                        <c:choose>
                                            <c:when test="${created == true}">
                                                <div class="action">
                                                    <button type="button" class="btn btn-default signup"
                                                            onfocus="this.blur()">
                                                        <a href="?command=addAccount&userId=${userId}">
                                                                ${backButton}
                                                        </a>
                                                    </button>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="action">
                                                    <button type="button" class="btn btn-default signup"
                                                            onfocus="this.blur()" disabled="disabled">
                                                        <a href="?command=addAccount&userId=${userId}">
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
</body>
</html>