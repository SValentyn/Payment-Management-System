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
    <title><fmt:message key="login.title"/></title>
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
                        <a href="/"><img src="resources/images/logo-white.png" alt="Logotype"/></a>
                        <h1>Payment Management System</h1>
                        <form class="language-form">
                            <select id="language" name="language" onchange="submit()">
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

    <div class="login-bg">
        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper" style="top: 30px;">
                        <div class="box">
                            <div class="content-wrap">
                                <h4>Payment Management System</h4>
                                <h4>Status: Beta</h4>
                                <p>User: 00000</p>
                                <p>Admin: 11111</p>

                                <h4>
                                    <fmt:message key="login.signin"/>
                                </h4>

                                <fmt:message key="login.phone" var="phone"/>
                                <fmt:message key="login.password" var="password"/>
                                <fmt:message key="login.submit" var="submit"/>

                                <form action="/" method="POST">
                                    <input type="hidden" name="command" value="login"/>

                                    <!-- Login -->
                                    <input class="form-control" name="login" type="text" style="margin-bottom: 18px;"
                                           placeholder="${phone}" value="${phoneValue}">

                                    <!-- Password -->
                                    <input class="form-control" name="password" type="password"
                                           placeholder="${password}" value="${passwordValue}"/>

                                    <!-- Error Labels -->
                                    <label class="enter-error-label">
                                        <c:if test="${phoneError}">
                                            <fmt:message key="login.phoneError"/>
                                        </c:if>
                                    </label>
                                    <label class="enter-error-label">
                                        <c:if test="${passwordError}">
                                            <fmt:message key="login.passwordError"/>
                                        </c:if>
                                    </label>
                                    <label class="enter-error-label">
                                        <c:if test="${loginError}">
                                            <fmt:message key="login.loginError"/>
                                        </c:if>
                                    </label>

                                    <!-- Submit -->
                                    <div class="action" style="padding-bottom: 0px;">
                                        <button type="submit" class="btn btn-primary signup">
                                            ${submit}
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="already">
                            <p><fmt:message key="login.dontHaveAccount"/></p>
                            <a href="?command=registration"><fmt:message key="login.signup"/></a>
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

