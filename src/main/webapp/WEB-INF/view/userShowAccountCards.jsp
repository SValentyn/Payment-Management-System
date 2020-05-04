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
    <title><fmt:message key="user.page.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style-fixed-footer.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>


    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <fmt:message key="user.page.myAccounts" var="myAccounts"/>
                <fmt:message key="user.page.myPayments" var="myPayments"/>
                <fmt:message key="user.page.settings" var="settings"/>
                <fmt:message key="admin.account_info.showAttachedCards" var="showAttachedCards"/>
                <fmt:message key="user.page.showAttachedCards" var="showAttachedCards"/>
                <fmt:message key="user.page.showPaymentArchive" var="showPaymentArchive"/>

                <fmt:message key="admin.account_info.accountBalance" var="accountBalance"/>
                <fmt:message key="admin.account_info.accountStatus" var="accountStatus"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>

                <fmt:message key="admin.account_info.accountNumber" var="accountNumber"/>

                <fmt:message key="admin.account_info.allPayments" var="allPayments"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.payment_info.remained" var="remained"/>
                <fmt:message key="admin.account_info.allAttachedCards" var="allAttachedCards"/>

                <fmt:message key="admin.account_info.validity" var="validity"/>
                <fmt:message key="admin.account_info.blockCard" var="blockCard"/>
                <fmt:message key="admin.account_info.unblockCard" var="unblockCard"/>
                <fmt:message key="admin.account_info.detachCard" var="detachCard"/>

                <div class="page-content container-fluid">
                    <div class="col-xl-12">
                        <div class="login-wrapper">
                            <div class="box">

                                <div class="card-header">
                                    <ul class="nav nav-tabs card-header-tabs justify-content-lg-center"
                                        role="tablist">
                                        <li class="nav-item-home">
                                            <a class="nav-link" role="tab" data-toggle="tab" aria-selected="false"
                                               onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                                <img src="resources/images/show-accounts.png" class="icon-sidebar"
                                                     style="width: 20px; height: 20px;" alt=""/>
                                                ${myAccounts}
                                            </a>
                                            <form action="" method="GET" id="form-showAccounts" role="form">
                                                <input type="hidden" name="command" value="showAccounts"/>
                                            </form>
                                        </li>
                                        <li class="nav-item-home">
                                            <a class="nav-link" role="tab" data-toggle="tab" aria-selected="false"
                                               onclick="document.getElementById('form-showPayments').submit(); return false;">
                                                <img src="resources/images/show-payments.png"
                                                     class="icon-sidebar" style="height: 17px" alt=""/>
                                                ${myPayments}
                                            </a>
                                            <form action="" method="GET" id="form-showPayments" role="form">
                                                <input type="hidden" name="command" value="showPayments"/>
                                            </form>
                                        </li>
                                    </ul>
                                </div>

                                <div class="card-body">

                                    <c:if test="${response ne 'unableGetUserId' &&
                                                  response ne 'unableGetAccountId' &&
                                                  response ne 'unableGetAccountByUserId' &&
                                                  response ne 'showAccountError' &&
                                                  response ne 'accountDeletedSuccess'}">

                                        <jsp:useBean id="viewableAccount" scope="request"
                                                     type="com.system.entity.Account"/>

                                        <div class="row">
                                            <div class="col-xl-12">
                                                <div class="form-row">
                                                    <div class="col-md-7 col-lg-7 col-xl-7">

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
                                                                   style="margin-top: 5px;">
                                                                    ${accountNumber}:
                                                            </label>
                                                            <input id="number" name="number"
                                                                   type="text" class="form-control"
                                                                   readonly="readonly"
                                                                   value="${viewableAccount.number}"/>
                                                            <label for="number" class="default-label"></label>
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
                                                                       class="default-label"></label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 col-lg-4 col-xl-4 offset-md-1"
                                                         style="align-self: center;">

                                                        <!-- Show Account Cards -->
                                                        <div class="col-md-4">
                                                            <span class="forward-top-link-img">
                                                                 <a href="?command=showAccountCards&accountId=${viewableAccount.accountId}"
                                                                    class="float-right">
                                                                    <img src="resources/images/credit-cards.png"
                                                                         alt=""/>
                                                                    <h5>${showAttachedCards}</h5>
                                                                 </a>
                                                            </span>
                                                        </div>

                                                        <!-- Show Account Payments -->
                                                        <div class="col-md-4">
                                                            <span class="forward-top-link-img">
                                                                <a href="?command=showAccountPayments&accountId=${viewableAccount.accountId}"
                                                                   class="float-right">
                                                                    <img src="resources/images/payments.png"
                                                                         alt=""/>
                                                                    <h5>${showPaymentArchive}</h5>
                                                                </a>
                                                            </span>
                                                        </div>

                                                        <div class="list-group" id="list-tab" role="tablist"
                                                             style="margin-top: 24px;">

                                                            <c:choose>
                                                                <c:when test="${viewableAccount.isBlocked}">
                                                                    <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                       id="list-unblockAccount-list" role="tab"
                                                                       href="?command=unblockAccount"
                                                                       onclick="document.getElementById('form-unblockAccount').submit(); return false;"
                                                                       aria-controls="unblockAccount">
                                                                            ${unblockAccount}
                                                                        <span class="forward-right-link-img">→</span>
                                                                    </a>
                                                                    <form action="/" method="POST"
                                                                          id="form-unblockAccount" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="unblockAccount"/>
                                                                        <input type="hidden" name="accountId"
                                                                               value="${viewableAccount.accountId}"/>
                                                                    </form>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                       id="list-blockAccount-list" role="tab"
                                                                       href="?command=blockAccount"
                                                                       onclick="document.getElementById('form-blockAccount').submit(); return false;"
                                                                       aria-controls="blockAccount">
                                                                            ${blockAccount}
                                                                        <span class="forward-right-link-img">→</span>
                                                                    </a>
                                                                    <form action="/" method="POST"
                                                                          id="form-blockAccount" role="form">
                                                                        <input type="hidden" name="command"
                                                                               value="blockAccount"/>
                                                                        <input type="hidden" name="accountId"
                                                                               value="${viewableAccount.accountId}"/>
                                                                    </form>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <a class="list-group-item list-group-item-action list-group-item-button-danger"
                                                               id="list-deleteAccount-list" role="tab"
                                                               href="#deleteAccountModal"
                                                               onclick="showDeleteAccountModal();"
                                                               aria-controls="deleteAccount">
                                                                    ${deleteAccount}
                                                                <span class="forward-right-link-img">→</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xl-12 tab-content" id="nav-tabContent">

                                                <!-- Show Attached Cards -->
                                                <div class="tab-pane fade show" id="list-attachedCards"
                                                     role="tabpanel" aria-labelledby="list-attachedCards-list">
                                                    <div class="col-xl-12" style="margin-top: 30px;">

                                                        <h4>
                                                                ${allAttachedCards}
                                                        </h4>

                                                        <c:choose>
                                                            <c:when test="${!cardsEmpty}">
                                                                <div class="card-container"
                                                                     style="width: 100% !important;">
                                                                    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 row-cols-lg-2 row-cols-xl-2">
                                                                        <c:forEach items="${cards}" var="card">
                                                                            <div class="col mb-4">
                                                                                <div class="card bg-light">
                                                                                    <div class="card-header">
                                                                                        <c:choose>
                                                                                            <c:when test="${card.isActive}">
                                                                                                <small class="text-success float-right">
                                                                                                        ${statusActive}
                                                                                                </small>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <small class="text-danger float-right">
                                                                                                        ${statusBlocked}
                                                                                                </small>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                    <div class="card-body"
                                                                                         style="padding: 0.75rem 1.25rem;">
                                                                                        <p class="card-title text-muted">
                                                                                                ${card.number}<br/>
                                                                                                ${validity}: ${card.validity}
                                                                                            <a href="#detachCardModal?cardId=${card.cardId}&cardNumber=${card.number}"
                                                                                               onclick="showDetachCardModal();"
                                                                                               class="float-right">
                                                                                                <img src="resources/images/detach-card-link.png"
                                                                                                     alt="${detachCard}"/>
                                                                                            </a>
                                                                                            <c:choose>
                                                                                                <c:when test="${card.isActive}">
                                                                                                    <a href="?command=blockCard&accountId=${viewableAccount.accountId}&cardId=${card.cardId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/locked-link.png"
                                                                                                             alt="${blockCard}"/>
                                                                                                    </a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <a href="?command=unblockCard&accountId=${viewableAccount.accountId}&cardId=${card.cardId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/unlocked-link.png"
                                                                                                             alt="${unblockCard}"/>
                                                                                                    </a>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </p>
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
                                                                                   key="admin.account_info.attachedCardsEmpty"/>
                                                                        </label>
                                                                    </span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>

                                                <!-- Show Payments -->
                                                <div class="tab-pane fade show" id="list-payments"
                                                     role="tabpanel" aria-labelledby="list-home-list">
                                                    <div class="col-xl-12" style="margin-top: 30px;">

                                                        <h4>
                                                                ${allPayments}
                                                        </h4>

                                                        <c:choose>
                                                            <c:when test="${!paymentsEmpty}">
                                                                <div class="card-container"
                                                                     style="width: 75% !important;">
                                                                    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-1 row-cols-xl-1">

                                                                        <c:forEach items="${payments}" var="payment">
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
                                                                                                    <span class="forward-right-link-img">→</span>
                                                                                                        ${payment.recipientNumber}
                                                                                                </p>

                                                                                                <!-- Sent Funds -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${sentFunds}: ${payment.senderAmount} ${payment.senderCurrency}
                                                                                                </p>

                                                                                                <!-- New balance -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${remained}: ${payment.newBalance} ${payment.senderCurrency}

                                                                                                    <!-- Show Payment Info -->
                                                                                                    <a href="?command=showPaymentInfo&paymentId=${payment.paymentId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/info.png"
                                                                                                             alt="${showInfo}"/>
                                                                                                    </a>

                                                                                                        <%--Repeat--%>
                                                                                                </p>
                                                                                            </c:when>
                                                                                            <c:otherwise>

                                                                                                <!-- Sender and Recipient -->
                                                                                                <p class="card-title text-muted">
                                                                                                        ${payment.recipientNumber}
                                                                                                    <span class="forward-left-link-img">←</span>
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
                                                                                                             alt=""/>
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
                                                                                     key="admin.account_info.paymentsEmpty"/>
                                                                        </label>
                                                                    </span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>