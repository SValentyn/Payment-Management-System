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
    <title><fmt:message key="admin.page.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowAccounts.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert showAccountsError and noUsersError -->
    <c:if test="${response eq 'showAccountsError' || totalUsers == null || totalUsers == 0}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertNoUsersError"/>
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
            <p><strong><fmt:message key="user.page.failed"/></strong>
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
                <fmt:message key="admin.page.allUsers" var="allUsers"/>
                <fmt:message key="admin.page.allAccounts" var="allAccounts"/>
                <fmt:message key="user.page.showInfo" var="showInfo"/>
                <fmt:message key="user.account_info.balance" var="balance"/>
                <fmt:message key="user.account_info.status.active" var="statusActive"/>
                <fmt:message key="user.account_info.status.blocked" var="statusBlocked"/>
                <fmt:message key="user.create_account.numberNewAccount" var="numberAccount"/>
                <fmt:message key="admin.user_accounts.balanceRange" var="balanceRange"/>
                <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                <fmt:message key="registration.tooltipOnlyDigits" var="tooltipOnlyDigits"/>
                <fmt:message key="admin.user_accounts.searchCriteria" var="searchCriteria"/>
                <fmt:message key="admin.user_accounts.searchButton" var="searchButton"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">

                                    <div class="card-header">
                                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center"
                                            role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link nav-link-hover" role="tab" data-toggle="tab"
                                                   aria-selected="false"
                                                   onclick="document.getElementById('form-showUsers').submit(); return false;">
                                                    <img src="resources/images/all-users.png"
                                                         class="icon-sidebar"
                                                         style="width: 21px; height: 21px; top: -1px;" alt=""/>
                                                    ${allUsers}
                                                    <span class="badge badge-pill badge-light">
                                                        ${totalUsers}
                                                    </span>
                                                </a>
                                                <form action="/" method="GET" id="form-showUsers" role="form"></form>
                                            </li>
                                            <li class="nav-item-active">
                                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="true"
                                                   onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                                    <img src="resources/images/show-accounts.png" class="icon-sidebar"
                                                         style="width: 20px; height: 20px;" alt=""/>
                                                    ${allAccounts}
                                                    <span class="badge badge-pill badge-light">
                                                        ${totalAccounts}
                                                    </span>
                                                </a>
                                                <form action="/" method="GET" role="form" id="form-showAccounts">
                                                    <input type="hidden" name="command" value="showAccounts"/>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>

                                    <c:choose>
                                        <c:when test="${totalUsers != null && totalUsers != 0}">

                                            <c:choose>
                                                <c:when test="${response ne 'showAccountsError' &&
                                                                accountsEmpty == false}">

                                                    <div class="card-body card-body-main">
                                                        <div class="row">
                                                            <div class="col-lg-3 col-xl-3">
                                                                <div class="search-block">
                                                                    <label>
                                                                            ${searchCriteria}:
                                                                    </label>
                                                                    <form action="/" method="POST" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="searchAccounts"/>

                                                                        <!-- Account Number -->
                                                                        <div>
                                                                            <input id="number" name="number" type="text"
                                                                                   class="form-control"
                                                                                   data-toggle="tooltip-left"
                                                                                   data-title="${tooltipOnlyDigits}"
                                                                                   maxlength="20"
                                                                                   onkeypress="inputOnlyNumbers();"
                                                                                   placeholder="${numberAccount}"
                                                                                   value="${numberValue}"/>
                                                                        </div>

                                                                        <!-- Min value Balance -->
                                                                        <input type="hidden" id="min-value"
                                                                               name="min-value"
                                                                               value="${minValue}"/>

                                                                        <!-- Max value Balance -->
                                                                        <input type="hidden" id="max-value"
                                                                               name="max-value"
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
                                                                        <input type="hidden" id="currency"
                                                                               name="currency"
                                                                               value="${currencyValue}"/>

                                                                        <!-- Select Currency -->
                                                                        <div>
                                                                            <div class="bfh-selectbox bfh-currencies"
                                                                                 data-flags="true" data-currency="">
                                                                            </div>
                                                                            <label class="default-label">&nbsp;</label>
                                                                        </div>

                                                                        <div class="action"
                                                                             style="padding: 15px 0 10px 0;">
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
                                                                    <div class="form-row">
                                                                        <div class="card-container"
                                                                             style="width: 100% !important;">
                                                                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-2 row-cols-xl-3">

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
                                                                                                    <a href="?command=showAccountInfo&userId=${account.userId}&accountId=${account.accountId}"
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
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="card-body" style="padding: 35px;">
                                                        <div class="message-block">
                                                            <span class="title-label">
                                                                <label>
                                                                     <fmt:message key="admin.page.accountsEmpty"/>
                                                                </label>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                        </c:when>
                                        <c:otherwise>
                                            <div class="card-body" style="min-height: 280px; padding: 35px;">
                                                <div class="message-block">
                                                    <span>
                                                        <label>
                                                             <fmt:message key="admin.users.noUsers"/>
                                                        </label>
                                                    </span>
                                                    <div class="w-100" style="height:172px;">
                                                        <img src="resources/images/error.png" alt=""
                                                             style="width: 172px; height: 172px; position: absolute; bottom: 35px; right: 55px;"/>
                                                    </div>
                                                </div>
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/searcher_adminShowAccounts.js"></script>
</html>