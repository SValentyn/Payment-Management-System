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
    <title><fmt:message key="user.createAccount.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
    <link rel="stylesheet" href="resources/css/style_userCreateAccount.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert unableGetUser -->
    <c:if test="${response eq 'unableGetUser'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertUnableGetUser"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert Success -->
    <c:if test="${response eq 'accountCreatedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertAccountCreatedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert manyAccountWithThisCurrencyError -->
    <c:if test="${response eq 'manyAccountWithThisCurrencyError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.manyAccountWithThisCurrencyError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountCreatedError -->
    <c:if test="${response eq 'accountCreatedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertAccountCreatedError"/>
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
                <fmt:message key="user.createAccount.createNewAccount" var="formHeader"/>
                <fmt:message key="user.createAccount.numberNewAccount" var="numberNewAccount"/>
                <fmt:message key="user.createAccount.accountCurrency" var="accountCurrency"/>
                <fmt:message key="user.createAccount.createAccount" var="createAccount"/>
                <fmt:message key="user.createAccount.numberError" var="numberError"/>
                <fmt:message key="user.createAccount.currencyError" var="currencyError"/>
                <fmt:message key="registration.correct" var="correct"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-6 offset-xl-2 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4>
                                            ${formHeader}
                                        </h4>

                                        <form action="" method="POST" role="form">
                                            <input type="hidden" name="command" value="createAccount"/>

                                            <!-- Account Number -->
                                            <div>
                                                <label class="for-form-label">
                                                    ${numberNewAccount}
                                                </label>
                                                <div class="form-group">
                                                    <input id="number" name="number" type="text" class="form-control"
                                                           style="height: 46px; margin: 0 10px 0 0; text-align: center; font-size: 18px;"
                                                           readonly="readonly" maxlength="20"
                                                           value="${numberValue}"/>
                                                    <img id="repeat" src="resources/images/repeat.png"
                                                         alt="" class="glyphicon icon-repeat"/>
                                                </div>
                                                <label for="number" class="default-label">
                                                    <span id="valid-msg-accountNumber" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt=""/>
                                                    </span>
                                                    <span id="error-msg-accountNumber" class="error-msg invisible">
                                                        ${numberError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Currency -->
                                            <input type="hidden" id="currency" name="currency"/>

                                            <!-- Select Currency -->
                                            <div style="margin-top: 16px;">
                                                <label class="for-form-label">
                                                    ${accountCurrency}
                                                </label>
                                                <div class="bfh-selectbox bfh-currencies"
                                                     data-currency="USD" data-flags="true">
                                                </div>
                                                <label for="currency" class="default-label">
                                                    <span id="valid-msg-currency" class="valid-msg invisible">
                                                        ${correct}<img src="resources/images/correct.png" alt=""/>
                                                    </span>
                                                    <span id="error-msg-currency" class="error-msg invisible">
                                                        ${currencyError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Submit -->
                                            <div class="action" style="padding: 40px 0 10px 0">
                                                <button id="submit" type="submit" class="btn btn-primary signup">
                                                    ${createAccount}
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
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/validator_userCreateAccount.js"></script>
</html>