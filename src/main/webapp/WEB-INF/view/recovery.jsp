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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
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
    <c:if test="${sended == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 559px; margin-top: 22px;">
            <p><strong>Success!</strong> A temporary login password has been sent to your phone.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <%--     + advice--%>

    <!-- Alert phoneNotExistError -->
    <c:if test="${phoneNotExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 553px; margin-top: 22px;">
            <p><strong>Failed!</strong> A user with this phone number was not found in the system.</p>
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
                        <div class="box" style="padding-bottom: 0px;">
                            <div class="content-wrap">
                                <fmt:message key="recovery.formHeader" var="formHeader"/>
                                <fmt:message key="registration.phone" var="phone"/>
                                <fmt:message key="recovery.recoveryButton" var="button"/>
                                <fmt:message key="recovery.backButton" var="backButton"/>
                                <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>

                                <h4>
                                    ${formHeader}
                                </h4>

                                <form action="" role="form" method="POST">
                                    <input type="hidden" name="command" value="restore">

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

                                    <!-- Submit -->
                                    <div class="action" style="padding: 10px 0 10px 0">
                                        <button type="submit" class="btn btn-primary signup" onfocus="this.blur()">
                                            ${button}
                                        </button>
                                    </div>

                                    <!-- Back Button -->
                                    <div class="action" style="padding: 0 0 35px 0">
                                        <button type="button" class="btn btn-default signup" onfocus="this.blur()">
                                            <a href="/">
                                                ${backButton}
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>