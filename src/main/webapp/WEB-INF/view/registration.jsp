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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css" >
</head>
<body class="login-bg">
<div class="header">
    <div class="container" style="margin-left: 0px;margin-right: 0px;">
        <div class="row">
            <div class="col-md-12">
                <div class="logo" style="display: flex">
                    <a href="/"><img src="resources/images/logo-white.png" alt="Logotype"/></a>
                    <h1>Payment Management System</h1>
                </div>
            </div>
        </div>
    </div>
    <form class="language-form">
        <select id="language" name="language" onchange="submit()">
            <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
            <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
            <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
        </select>
    </form>
</div>

<!-- Alert Success -->
<c:if test="${created == true}">
    <div id="alert" class="alert alert-success fade in" role="alert">
        <p><strong>Success!</strong> Account created. Try <a href="/" class="alert-link">logging</a> into your account.</p>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>

<!-- Alert userAlreadyRegisteredError -->
<c:if test="${userAlreadyRegisteredError == true}">
    <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 466px; margin-top: 20px;">
        <p><strong>Failed!</strong> A user with such a phone is already registered.</p>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</c:if>

<div class="page-content container" >
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="login-wrapper" style="top: 60px;">
                <div class="box" style="padding-bottom: 0px;">
                    <div class="content-wrap">
                        <fmt:message key="registration.name" var="name"/>
                        <fmt:message key="registration.surname" var="surname"/>
                        <fmt:message key="registration.phone" var="phone"/>
                        <fmt:message key="registration.email" var="email"/>
                        <fmt:message key="registration.password" var="password"/>
                        <fmt:message key="registration.confirmation" var="confirmation"/>

                        <h6>
                            <fmt:message key="registration.registration"/>
                        </h6>

                        <form action="" method="POST">
                            <input id="name" name="name" class="form-control" type="text" placeholder="${name}*"
                                   value="${nameValue}">
                            <label for="name" class="reg-error-label">
                                <c:if test="${nameError}">
                                    <fmt:message key="registration.nameError"/>
                                </c:if>&nbsp;
                            </label>

                            <input id="surname" name="surname" class="form-control" type="text"
                                   placeholder="${surname}*"
                                   value="${surnameValue}">
                            <label for="surname" class="reg-error-label">
                                <c:if test="${surnameError}">
                                    <fmt:message key="registration.surnameError"/>
                                </c:if>&nbsp;
                            </label>

                            <input id="phone" name="phone" class="form-control" type="text" placeholder="${phone}*"
                                   value="${phoneValue}">
                            <label for="phone" class="reg-error-label">
                                <c:if test="${phoneError}">
                                    <fmt:message key="registration.phoneError"/>
                                </c:if>&nbsp;
                            </label>

                            <input id="email" name="email" class="form-control" type="email" placeholder="${email}"
                                   pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                                   value="${emailValue}">
                            <label for="email" class="reg-error-label">&nbsp;</label>

                            <input id="password" name="password" class="form-control" type="password"
                                   placeholder="${password}*" value=${passwordValue}>
                            <label for="password" class="reg-error-label">
                                <c:if test="${passwordError}">
                                    <fmt:message key="registration.passwordError"/>
                                </c:if>&nbsp;
                            </label>

                            <input id="passwordConfirmation" name="passwordConfirmation"
                                   class="form-control" type="password"
                                   placeholder="${confirmation}*" value=${passwordConfirmationValue}>
                            <label for="passwordConfirmation" class="reg-error-label">
                                <c:if test="${passwordConfirmationError}">
                                    <fmt:message key="registration.passwordConfirmationError"/>
                                </c:if>&nbsp;
                            </label>

                            <div class="action">
                                <button type="submit" class="btn btn-primary signup">
                                    <fmt:message key="registration.button"/>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="already">
                    <p><fmt:message key="registration.haveAccountAlready"/></p>
                    <a href="/"><fmt:message key="registration.login"/></a>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>

<script src="https://code.jquery.com/jquery.js"></script>
<script src="resources/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/js/custom.js"></script>
</body>
</html>