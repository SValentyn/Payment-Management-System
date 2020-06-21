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
    <title><fmt:message key="user.account_payments.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_userShowAccountPayments.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alerts unableGetData and showAccountError and unableGetPayments -->
    <c:if test="${response eq 'unableGetData' || response eq 'showAccountError' || response eq 'unableGetPayments'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertUnableGetData"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetAccountId -->
    <c:if test="${response eq 'unableGetAccountId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertUnableGetAccountIdError"/>
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
                <fmt:message key="user.page.myAccounts" var="myAccounts"/>
                <fmt:message key="user.page.myPayments" var="myPayments"/>
                <fmt:message key="user.page.settings" var="settings"/>
                <fmt:message key="user.page.showAttachedCards" var="showAttachedCards"/>
                <fmt:message key="admin.account_info.accountStatus" var="accountStatus"/>
                <fmt:message key="user.account_info.status.active" var="statusActive"/>
                <fmt:message key="user.account_info.status.blocked" var="statusBlocked"/>
                <fmt:message key="admin.account_info.accountNumber" var="accountNumber"/>
                <fmt:message key="admin.account_info.accountBalance" var="accountBalance"/>
                <fmt:message key="user.account_payments.allPaymentsMade" var="allPaymentsMade"/>
                <fmt:message key="user.page.success" var="success"/>
                <fmt:message key="user.page.failed" var="failed"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.payment_info.remained" var="remained"/>
                <fmt:message key="user.page.showInfo" var="showInfo"/>
                <fmt:message key="user.payments.repeat" var="repeat"/>
                <fmt:message key="user.account_info.returnToAllAccounts" var="returnToAllAccounts"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <div class="card-header">
                                            <ul class="nav nav-tabs card-header-tabs justify-content-lg-center"
                                                role="tablist">
                                                <li class="nav-item-home">
                                                    <a class="nav-link" role="tab" data-toggle="tab"
                                                       aria-selected="false"
                                                       onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                                        <img src="resources/images/show-accounts.png"
                                                             class="icon-sidebar" style="width: 20px; height: 20px;"
                                                             alt=""/>
                                                        ${myAccounts}
                                                    </a>
                                                    <form action="" method="GET" id="form-showAccounts" role="form">
                                                        <input type="hidden" name="command" value="showAccounts"/>
                                                    </form>
                                                </li>
                                                <li class="nav-item-home">
                                                    <a class="nav-link" role="tab" data-toggle="tab"
                                                       aria-selected="false"
                                                       onclick="document.getElementById('form-showPayments').submit(); return false;">
                                                        <img src="resources/images/show-payments.png"
                                                             class="icon-sidebar" style="height: 17px"
                                                             alt=""/>
                                                        ${myPayments}
                                                    </a>
                                                    <form action="" method="GET" id="form-showPayments" role="form">
                                                        <input type="hidden" name="command" value="showPayments"/>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>

                                        <div class="card-body card-body-main">

                                            <!-- Return to Accounts -->
                                            <c:if test="${response eq 'unableGetData' ||
                                                          response eq 'unableGetAccountId' ||
                                                          response eq 'showAccountError' ||
                                                          response eq 'unableGetPayments'}">
                                                <div class="message-block">
                                                    <span class="title-label forward-left-link-img">
                                                        <a href="?command=showAccounts" class="float-left">
                                                            <img src="resources/images/return.png"
                                                                 class="icon-return" alt=""/>
                                                                ${returnToAllAccounts}
                                                        </a>
                                                    </span>
                                                </div>
                                            </c:if>

                                            <c:if test="${response ne 'unableGetUserId' &&
                                                          response ne 'unableGetAccountId' &&
                                                          response ne 'showAccountError' &&
                                                          response ne 'unableGetPayments'}">

                                                <jsp:useBean id="viewableAccount" scope="request"
                                                             type="com.system.entity.Account"/>

                                                <div class="row">
                                                    <div class="col-xl-12">
                                                        <div class="form-row">
                                                            <div class="col-md-8 col-lg-8 col-xl-8">

                                                                <!-- Account Status -->
                                                                <c:choose>
                                                                    <c:when test="${viewableAccount.isBlocked}">
                                                                        <label class="for-form-label text-center"
                                                                               style="font-size: 18px;">
                                                                                ${accountStatus}:
                                                                            <span class="text-danger">
                                                                                    ${statusBlocked}
                                                                            </span>
                                                                        </label>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <label class="for-form-label text-center"
                                                                               style="font-size: 18px;">
                                                                                ${accountStatus}:
                                                                            <span class="text-success">
                                                                                    ${statusActive}
                                                                            </span>
                                                                        </label>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <!-- Account Number -->
                                                                <div>
                                                                    <label class="for-form-label"
                                                                           style="margin-top: 12px;">
                                                                            ${accountNumber}:
                                                                    </label>
                                                                    <input id="number" name="number"
                                                                           type="text" class="form-control"
                                                                           readonly="readonly"
                                                                           value="${viewableAccount.number}"/>
                                                                    <label for="number"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <!-- Account Balance and Currency -->
                                                                <div>
                                                                    <label class="for-form-label">
                                                                            ${accountBalance}:
                                                                    </label>
                                                                    <div style="display: flex; margin-bottom: 25px;">
                                                                        <input id="balance" name="balance"
                                                                               type="text" class="form-control"
                                                                               style="min-width: 49%; margin-right: 1%;"
                                                                               readonly="readonly"
                                                                               value="${viewableAccount.balance}"/>
                                                                        <div id="currency"
                                                                             class="bfh-selectbox bfh-currencies"
                                                                             style="min-width: 49%; margin-left: 1%; pointer-events: none;"
                                                                             data-currency="${viewableAccount.currency}"
                                                                             data-flags="true">
                                                                        </div>
                                                                        <label for="balance"
                                                                               class="default-label">&nbsp;</label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4 col-lg-4 col-xl-4"
                                                                 style="align-self: center;">

                                                                <div class="list-group">
                                                                    <div class="options">

                                                                        <!-- Show Account Info -->
                                                                        <div class="col-md-6">
                                                                            <span class="forward-top-link-img">
                                                                                <a href="?command=showAccountSettings&accountId=${viewableAccount.accountId}"
                                                                                   class="float-right">
                                                                                    <img src="resources/images/settings.png"
                                                                                         alt=""/>
                                                                                    <h5>${settings}</h5>
                                                                                </a>
                                                                            </span>
                                                                        </div>

                                                                        <!-- Show Account Cards -->
                                                                        <div class="col-md-6">
                                                                            <span class="forward-top-link-img">
                                                                                <a href="?command=showAccountCards&accountId=${viewableAccount.accountId}"
                                                                                   class="float-right">
                                                                                    <img src="resources/images/credit-cards.png"
                                                                                         alt=""/>
                                                                                    <h5>${showAttachedCards}</h5>
                                                                                </a>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-xl-12">

                                                        <c:choose>
                                                            <c:when test="${paymentsEmpty == false}">

                                                                <h4 style="margin-top: 10px;">
                                                                        ${allPaymentsMade}
                                                                </h4>

                                                                <div class="card-container">
                                                                    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1 row-cols-xl-1">

                                                                        <c:forEach items="${payments}"
                                                                                   var="payment">
                                                                            <div class="col mb-4">
                                                                                <div class="card bg-light">
                                                                                    <div class="card-header">
                                                                                        <small class="text-muted float-left">
                                                                                                ${payment.date}
                                                                                        </small>
                                                                                        <c:choose>
                                                                                            <c:when test="${payment.condition}">
                                                                                                <small class="text-success float-right">
                                                                                                        ${success}
                                                                                                </small>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <small class="text-danger float-right">
                                                                                                        ${failed}
                                                                                                </small>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                    <div class="card-body"
                                                                                         style="padding: 0.75rem 1.25rem;">

                                                                                        <!-- Outgoing and Incoming Payments -->
                                                                                        <c:choose>
                                                                                            <c:when test="${payment.isOutgoing}">

                                                                                                <!-- Sender and Recipient -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${payment.senderNumber}
                                                                                                    <span class="forward-right-link-img">&Longrightarrow;</span>
                                                                                                        ${payment.recipientNumber}
                                                                                                </p>

                                                                                                <!-- Sent Funds -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${sentFunds}: ${payment.senderAmount} ${payment.senderCurrency}
                                                                                                </p>

                                                                                                <!-- New balance -->
                                                                                                <p class="card-title text-muted new-balance">
                                                                                                    <span>
                                                                                                        ${remained}: ${payment.newBalance} ${payment.senderCurrency}
                                                                                                    </span>

                                                                                                    <!-- Show Payment Info -->
                                                                                                    <a href="?command=showPaymentInfo&paymentId=${payment.paymentId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/info.png"
                                                                                                             style="margin-left: 7px;"
                                                                                                             alt="${showInfo}"/>
                                                                                                    </a>

                                                                                                    <!-- Repeat Payment -->
                                                                                                    <a href="?command=repeatPayment&paymentId=${payment.paymentId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/repeat-payment.png"
                                                                                                             alt="${repeat}"/>
                                                                                                    </a>
                                                                                                </p>
                                                                                            </c:when>
                                                                                            <c:otherwise>

                                                                                                <!-- Sender and Recipient -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${payment.recipientNumber}
                                                                                                    <span class="forward-left-link-img">&Longleftarrow;</span>
                                                                                                        ${payment.senderNumber}
                                                                                                </p>

                                                                                                <!-- Received Funds -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${receivedFunds}: ${payment.recipientAmount} ${payment.recipientCurrency}
                                                                                                </p>

                                                                                                <!-- New balance -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${remained}: ${payment.newBalance} ${payment.recipientCurrency}

                                                                                                    <!-- Show Payment Info -->
                                                                                                    <a href="?command=showPaymentInfo&paymentId=${payment.paymentId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/info.png"
                                                                                                             alt="${showInfo}"/>
                                                                                                    </a>
                                                                                                </p>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="message-block">
                                                                    <span class="title-label">
                                                                        <label>
                                                                           <fmt:message
                                                                                   key="user.account_payments.paymentsEmpty"/>
                                                                        </label>
                                                                    </span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>