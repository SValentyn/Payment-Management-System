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
    <title><fmt:message key="admin.user_accounts.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowUserAccounts.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

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

    <!-- Alert showUserAccountsError -->
    <c:if test="${response eq 'showUserAccountsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowUserAccountsError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchAccountsSuccess -->
    <c:if test="${response eq 'searchAccountsSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchAccountsSuccess"/>
                    ${numberOfAccounts}
                <fmt:message key="admin.user_accounts.accounts"/>.
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchAccountsWarning -->
    <c:if test="${response eq 'searchAccountsWarning'}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchAccountsWarning"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchAccountsError -->
    <c:if test="${response eq 'searchAccountsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertSearchAccountsError"/>
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
                <fmt:message key="admin.user_accounts.formHeader" var="formHeader"/>
                <fmt:message key="user.account.balance" var="balance"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="user.page.showInfo" var="showInfo"/>
                <fmt:message key="user.createAccount.numberNewAccount" var="numberAccount"/>
                <fmt:message key="admin.user_accounts.balanceRange" var="balanceRange"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>
                <fmt:message key="admin.attachAccount.returnToUserProfile" var="returnToUserProfile"/>
                <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                <fmt:message key="registration.tooltipOnlyDigits" var="tooltipOnlyDigits"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <div class="row justify-content-center">
                                            <div class="col-xl-12">

                                                <h4>
                                                    ${formHeader}
                                                </h4>

                                                <!-- Return to Users -->
                                                <c:if test="${response eq 'unableGetUserId'}">
                                                    <div class="message-block">
                                                        <span class="title-label forward-left-link-img">
                                                            <a href="/" class="float-left">
                                                                <img src="resources/images/return.png"
                                                                     class="icon-return" alt=""/>
                                                                    ${returnToUsers}
                                                            </a>
                                                        </span>
                                                    </div>
                                                </c:if>

                                                <!-- Return to User -->
                                                <c:if test="${ response eq 'showUserAccountsError'}">
                                                    <div class="message-block">
                                                        <span class="title-label forward-left-link-img">
                                                            <a href="?command=showUser&userId=${userId}"
                                                               class="float-left">
                                                                <img src="resources/images/return.png"
                                                                     class="icon-return" alt=""/>
                                                                    ${returnToUserProfile}
                                                            </a>
                                                        </span>
                                                    </div>
                                                </c:if>

                                                <c:if test="${response ne 'unableGetUserId' &&
                                                              response ne 'showUserAccountsError'}">
                                                    <div class="row" style="padding: 0 0 0 10px;">
                                                        <div class="col-lg-3 col-xl-3">
                                                            <div>
                                                                <form action="/" method="GET" role="form">
                                                                    <input type="hidden" name="command"
                                                                           value="showUser"/>
                                                                    <input type="hidden" name="userId"
                                                                           value="${userId}"/>
                                                                    <div class="action" style="padding: 0 0 20px 0;">
                                                                        <button id="submit" type="submit"
                                                                                class="btn btn-primary signup btn-default"
                                                                                style="width: 100%;">
                                                                                ${returnToUserProfile}
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>

                                                            <div style="height: 6px; margin-bottom: 15px; border-top: 2px solid #e9ecef;"></div>

                                                            <div class="search-block">
                                                                <label style="margin-bottom: 15px;">
                                                                        ${searchCriteria}:
                                                                </label>
                                                                <form action="/" method="POST" role="form">
                                                                    <input type="hidden" name="command"
                                                                           value="searchUserAccounts"/>

                                                                    <input type="hidden" name="userId"
                                                                           value="${userId}"/>

                                                                    <!-- Account Number -->
                                                                    <div>
                                                                        <input id="number" name="number" type="text"
                                                                               class="form-control"
                                                                               data-toggle="tooltip-left"
                                                                               data-title="${tooltipOnlyDigits}"
                                                                               maxlength="20"
                                                                               onkeypress="onlyNumbers();"
                                                                               placeholder="${numberAccount}"
                                                                               value="${numberValue}"/>
                                                                    </div>

                                                                    <!-- Min value Balance -->
                                                                    <input type="hidden" id="min-value" name="min-value"
                                                                           value="${minValue}"/>

                                                                    <!-- Max value Balance -->
                                                                    <input type="hidden" id="max-value" name="max-value"
                                                                           value="${maxValue}"/>

                                                                    <!-- Balance Range -->
                                                                    <div>
                                                                        <input id="amount" type="text"
                                                                               class="for-form-label"
                                                                               readonly="readonly"/>
                                                                        <div id="slider-range"
                                                                             data-toggle="tooltip-left"
                                                                             data-title="${balanceRange}"></div>
                                                                        <label for="slider-range"
                                                                               class="default-label">&nbsp;</label>
                                                                    </div>

                                                                    <!-- Currency -->
                                                                    <input type="hidden" id="currency" name="currency"
                                                                           value="${currencyValue}"/>

                                                                    <!-- Select Currency -->
                                                                    <div>
                                                                        <div class="bfh-selectbox bfh-currencies"
                                                                             data-currency="" data-flags="true">
                                                                        </div>
                                                                        <label class="default-label">&nbsp;</label>
                                                                    </div>

                                                                    <div class="action" style="padding: 10px 0 0 0">
                                                                        <button id="search" type="submit"
                                                                                class="btn btn-primary signup">
                                                                                ${searchButton}
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-9 col-xl-9">
                                                            <div class="col-xl-12">
                                                                <c:choose>
                                                                    <c:when test="${!accountsEmpty}">
                                                                        <div class="form-row">
                                                                            <div class="card-container"
                                                                                 style="width: 100% !important;">
                                                                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-2 row-cols-xl-2">
                                                                                    <c:forEach items="${accounts}"
                                                                                               var="account">
                                                                                        <div class="col mb-4">
                                                                                            <div class="card bg-light">
                                                                                                <div class="card-header">
                                                                                                    <c:choose>
                                                                                                        <c:when test="${account.isBlocked}">
                                                                                                            <small class="text-danger float-right">
                                                                                                                    ${statusBlocked}
                                                                                                            </small>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>
                                                                                                            <small class="text-success float-right">
                                                                                                                    ${statusActive}
                                                                                                            </small>
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>
                                                                                                </div>
                                                                                                <div class="card-body"
                                                                                                     style="padding: 0.75rem 1.25rem;">
                                                                                                    <p class="card-title text-muted">
                                                                                                            ${account.number}<br/>
                                                                                                            ${balance}: ${account.balance} ${account.currency}

                                                                                                        <!-- Show Account Info -->
                                                                                                        <a href="?command=showAccountInfo&userId=${userId}&accountId=${account.accountId}"
                                                                                                           class="float-right">
                                                                                                            <img src="resources/images/info.png"
                                                                                                                 alt="${showInfo}"/>
                                                                                                        </a>
                                                                                                    </p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:forEach>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="message-block"
                                                                             style="padding-left: 20px;">
                                                                            <span class="title-label">
                                                                                <label>
                                                                                      <fmt:message
                                                                                              key="admin.user.accountsEmpty"/>
                                                                                </label>
                                                                            </span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
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
<script src="resources/js/searcher_adminShowUserAccounts.js"></script>
</html>