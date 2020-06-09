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
    <title><fmt:message key="admin.attach_account.title"/></title>
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
                <fmt:message key="admin.attach_account.formHeader" var="formHeader"/>
                <fmt:message key="admin.attach_account.user_bio" var="user_rank"/>
                <fmt:message key="user.create_account.numberNewAccount" var="numberNewAccount"/>
                <fmt:message key="user.create_account.accountCurrency" var="accountCurrency"/>
                <fmt:message key="admin.attach_account.attachAccount" var="attachAccount"/>
                <fmt:message key="admin.attach_account.showAllAccounts" var="showAllAccounts"/>
                <fmt:message key="admin.attach_account.returnToUserProfile" var="returnToUserProfile"/>
                <fmt:message key="user.create_account.numberError" var="numberError"/>
                <fmt:message key="user.create_account.currencyError" var="currencyError"/>
                <fmt:message key="admin.attach_account.tooltipUserBio" var="tooltipUserBio"/>
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

                                        <c:choose>
                                            <c:when test="${response ne 'unableGetUserId' &&
                                                            response ne 'unableGetUserByUserId'}">

                                                <form action="" method="POST" role="form">
                                                    <input type="hidden" name="command" value="attachAccount"/>

                                                    <!-- User bio -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${user_rank}:
                                                        </label>
                                                        <input id="bio" name="bio"
                                                               type="text" class="form-control"
                                                               style="height: 46px; margin-top: 0;"
                                                               data-toggle="tooltip-right-hover"
                                                               data-title="${tooltipUserBio}"
                                                               readonly="readonly"
                                                               value="${bioValue}"/>
                                                        <label for="bio" class="default-label">&nbsp;</label>
                                                    </div>

                                                    <!-- Account Number -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${numberNewAccount}:
                                                        </label>
                                                        <div class="form-group"
                                                             style="display: flex; margin-bottom: 0;">
                                                            <input id="number" name="number"
                                                                   type="text" class="form-control"
                                                                   style="height: 46px; margin: 0 10px 0 0; text-align: center; font-size: 18px;"
                                                                   maxlength="20" readonly="readonly"
                                                                   value="${numberValue}"/>
                                                            <img id="repeat" src="resources/images/repeat.png"
                                                                 class="glyphicon icon-repeat" alt=""/>
                                                        </div>
                                                        <label for="number" class="default-label">
                                                            <span id="valid-msg-accountNumber"
                                                                  class="valid-msg invisible">
                                                                    ${correct}
                                                                <img src="resources/images/correct.png" alt=""/>
                                                            </span>
                                                            <span id="error-msg-accountNumber"
                                                                  class="error-msg invisible">
                                                                    ${numberError}
                                                            </span>
                                                        </label>
                                                    </div>

                                                    <!-- Currency -->
                                                    <input type="hidden" id="currency" name="currency"/>

                                                    <!-- Select Currency -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${accountCurrency}:
                                                        </label>
                                                        <div class="bfh-selectbox bfh-currencies"
                                                             data-currency="USD" data-flags="true">
                                                        </div>
                                                        <label for="currency" class="default-label">
                                                            <span id="valid-msg-currency" class="valid-msg invisible">
                                                                    ${correct}
                                                                <img src="resources/images/correct.png" alt=""/>
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
                                                                ${attachAccount}
                                                        </button>
                                                    </div>
                                                </form>

                                                <!-- Show User Accounts -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUserAccounts"/>
                                                        <input type="hidden" name="userId" value="${userId}"/>
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default">
                                                                ${showAllAccounts}
                                                        </button>
                                                    </form>
                                                </div>

                                                <!-- Return to User Profile -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUser"/>
                                                        <input type="hidden" name="userId" value="${userId}"/>
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default">
                                                                ${returnToUserProfile}
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:when>
                                            <c:otherwise>

                                                <form action="" method="POST" role="form">
                                                    <input type="hidden" name="command" value="attachAccount"/>

                                                    <!-- User bio -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${user_rank}
                                                        </label>
                                                        <input name="bio" type="text" class="form-control"
                                                               style="height: 46px; margin-top: 0;"
                                                               readonly="readonly"/>
                                                        <label for="bio" class="default-label">&nbsp;</label>
                                                    </div>

                                                    <!-- Account Number -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${numberNewAccount}
                                                        </label>
                                                        <div class="form-group"
                                                             style="display: flex; margin-bottom: 0;">
                                                            <input name="number" type="text" class="form-control"
                                                                   style="height: 46px; margin: 0 10px 0 0; text-align: center; font-size: 18px;"
                                                                   readonly="readonly"/>
                                                            <img src="resources/images/repeat.png"
                                                                 class="glyphicon icon-repeat" alt=""/>
                                                        </div>
                                                        <label for="number" class="default-label">&nbsp;</label>
                                                    </div>

                                                    <!-- Select Currency -->
                                                    <div>
                                                        <label class="for-form-label">
                                                                ${accountCurrency}
                                                        </label>
                                                        <div class="bfh-selectbox bfh-currencies"
                                                             data-currency="USD" data-flags="true" data-blank="false">
                                                        </div>
                                                        <label for="currency" class="default-label">&nbsp;</label>
                                                    </div>

                                                    <!-- Submit -->
                                                    <div class="action" style="padding: 20px 0 10px 0">
                                                        <button type="submit" class="btn btn-primary signup disabled">
                                                                ${attachAccount}
                                                        </button>
                                                    </div>
                                                </form>

                                                <!-- Show User Accounts -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUserAccounts"/>
                                                        <button type="submit"
                                                                class="btn btn-primary signup btn-default disabled">
                                                                ${showAllAccounts}
                                                        </button>
                                                    </form>
                                                </div>

                                                <!-- Return to User Profile -->
                                                <div class="action back-btn">
                                                    <form action="/" method="GET" role="form">
                                                        <input type="hidden" name="command" value="showUser"/>
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
</html>