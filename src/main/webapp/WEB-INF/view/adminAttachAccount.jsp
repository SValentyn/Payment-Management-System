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
    <title><fmt:message key="admin.attachAccount.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminAttachAccount.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${response eq 'accountAttachedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertAccountAttachedSuccess"/>
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

    <!-- Alert unableGetUserByUserId -->
    <c:if test="${response eq 'unableGetUserByUserId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetUserByUserIdError"/>
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
                <fmt:message key="admin.page.alertManyAccountWithThisCurrencyError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountAttachError -->
    <c:if test="${response eq 'accountAttachError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertAccountAttachError"/>
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
                    <div class="row">
                        <div class="col-xl-6 offset-xl-2 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <fmt:message key="admin.attachAccount.formHeader" var="formHeader"/>
                                        <fmt:message key="admin.attachAccount.user_bio" var="user_rank"/>
                                        <fmt:message key="user.createAccount.numberNewAccount" var="numberNewAccount"/>
                                        <fmt:message key="user.createAccount.accountCurrency" var="accountCurrency"/>
                                        <fmt:message key="admin.attachAccount.attachAccountButton"
                                                     var="attachAccountButton"/>
                                        <fmt:message key="admin.attachAccount.showAllAccountsButton"
                                                     var="showAllAccountsButton"/>
                                        <fmt:message key="admin.attachAccount.returnToUserProfile"
                                                     var="returnToUserProfile"/>
                                        <fmt:message key="user.createAccount.numberError" var="numberError"/>
                                        <fmt:message key="user.createAccount.currencyError" var="currencyError"/>
                                        <fmt:message key="admin.attachAccount.tooltipUserBio" var="tooltipUserBio"/>
                                        <fmt:message key="registration.correct" var="correct"/>

                                        <h4 style="margin-bottom: 15px;">
                                            ${formHeader}
                                        </h4>

                                        <c:choose>
                                            <c:when test="${response ne 'unableGetUserId' &&
                                                            response ne 'unableGetUserByUserId'}">

                                                <form action="" role="form" method="POST">
                                                    <input type="hidden" name="command" value="attachAccount"/>

                                                    <!-- User bio -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${user_rank}
                                                        </label>
                                                        <input id="bio" name="bio" class="form-control"
                                                               type="text" readonly="readonly"
                                                               style="height: 46px; margin-top: 0;"
                                                               data-toggle="tooltip-right-hover"
                                                               title="${tooltipUserBio}"
                                                               value="${bioValue}"/>
                                                        <label for="bio" class="default-label"></label>
                                                    </div>

                                                    <!-- Account Number -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${numberNewAccount}
                                                        </label>
                                                        <div class="form-group"
                                                             style="display: flex; margin-bottom: 0;">
                                                            <input id="number" name="number" class="form-control"
                                                                   type="text" readonly="readonly" maxlength="20"
                                                                   style="height: 46px; margin: 0 10px 0 0; text-align: center; font-size: 18px;"
                                                                   value="${numberValue}"/>
                                                            <img id="repeat" src="resources/images/repeat.png"
                                                                 alt="" class="glyphicon icon-repeat">
                                                        </div>
                                                        <label for="number" class="default-label">
                                                            <span id="valid-msg-accountNumber"
                                                                  class="valid-msg invisible">
                                                                    ${correct}<img src="resources/images/correct.png"
                                                                                   alt="">
                                                            </span>
                                                            <span id="error-msg-accountNumber"
                                                                  class="error-msg invisible">
                                                                    ${numberError}
                                                            </span>
                                                        </label>
                                                    </div>

                                                    <!-- Currency -->
                                                    <input id="currency" name="currency" type="hidden"/>

                                                    <!-- Select Currency -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${accountCurrency}
                                                        </label>
                                                        <div class="bfh-selectbox bfh-currencies"
                                                             data-currency="USD" data-flags="true">
                                                        </div>
                                                        <label for="currency" class="default-label">
                                                            <span id="valid-msg-currency" class="valid-msg invisible">
                                                                ${correct}<img src="resources/images/correct.png"
                                                                               alt="">
                                                            </span>
                                                            <span id="error-msg-currency" class="error-msg invisible">
                                                                    ${currencyError}
                                                            </span>
                                                        </label>
                                                    </div>

                                                    <!-- Submit -->
                                                    <div class="action" style="padding: 20px 0 10px 0">
                                                        <button id="submit" type="submit"
                                                                class="btn btn-primary signup">
                                                                ${attachAccountButton}
                                                        </button>
                                                    </div>
                                                </form>

                                                <!-- Show all Accounts -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUserAccounts">
                                                        <input type="hidden" name="userId" value="${userId}">
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default">
                                                                ${showAllAccountsButton}
                                                        </button>
                                                    </form>
                                                </div>

                                                <!-- Return to User Profile -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUser">
                                                        <input type="hidden" name="userId" value="${userId}">
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default">
                                                                ${returnToUserProfile}
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:when>
                                            <c:otherwise>

                                                <form action="/" role="form" method="POST">
                                                    <input type="hidden" name="command" value="attachAccount"/>

                                                    <!-- User bio -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${user_rank}
                                                        </label>
                                                        <input name="bio" class="form-control"
                                                               type="text" readonly="readonly"
                                                               style="height: 46px; margin-top: 0;"/>
                                                        <label for="bio" class="default-label"></label>
                                                    </div>

                                                    <!-- Account Number -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${numberNewAccount}
                                                        </label>
                                                        <div class="form-group"
                                                             style="display: flex; margin-bottom: 0;">
                                                            <input name="number" class="form-control"
                                                                   type="text" readonly="readonly"
                                                                   style="height: 46px; margin: 0 10px 0 0; text-align: center; font-size: 18px;"/>
                                                            <img src="resources/images/repeat.png" alt=""
                                                                 class="glyphicon icon-repeat">
                                                        </div>
                                                        <label for="number" class="default-label"></label>
                                                    </div>

                                                    <!-- Select Currency -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${accountCurrency}
                                                        </label>
                                                        <div class="bfh-selectbox bfh-currencies"
                                                             data-currency="USD" data-flags="true">
                                                        </div>
                                                        <label for="currency" class="default-label"></label>
                                                    </div>

                                                    <!-- Submit -->
                                                    <div class="action" style="padding: 20px 0 10px 0">
                                                        <button type="submit" class="btn btn-primary signup disabled">
                                                                ${attachAccountButton}
                                                        </button>
                                                    </div>
                                                </form>

                                                <!-- Show all Accounts -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUserAccounts">
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default disabled">
                                                                ${showAllAccountsButton}
                                                        </button>
                                                    </form>
                                                </div>

                                                <!-- Return to User Profile -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUser">
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default disabled">
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
<script src="resources/js/validator_adminAttachAccount.js"></script>
<script>
    $(document).ready(function () {
        $('#currency').val($('.bfh-selectbox').val());
    });
</script>
</html>