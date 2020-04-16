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
    <title><fmt:message key="admin.account_info.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowAccountInfo.css">
</head>
<body>

<!-- Modal window (deleteAccountModal) -->
<div id="deleteAccountModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="admin.account_info.account.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="admin.account_info.account.modalBody"/><br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="accountNumberText" class="modal-label">
                        <fmt:message key="admin.account_info.account.modalAccountLabel"/>
                    </label>
                    <input id="accountNumberText" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" data-dismiss="modal">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" role="form" method="POST">
                        <input type="hidden" name="command" value="deleteAccount">
                        <input type="hidden" name="accountId" value="${viewableAccount.accountId}">
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur()">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal window (detachCardModal) -->
<div id="detachCardModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.card.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="admin.account_info.card.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="cardNumberText" class="modal-label">
                        <fmt:message key="user.card.modalCardLabel"/>
                    </label>
                    <input id="cardNumberText" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" style="border-radius: 5px;"
                            data-dismiss="modal" onfocus="this.blur()">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" role="form" method="POST">
                        <input type="hidden" name="command" value="detachCard">
                        <input type="hidden" name="cardNumber" id="cardNumber"/>
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur()">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert unableGetAccountId -->
    <c:if test="${response eq 'unableGetAccountId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetAccountIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert showAccountError -->
    <c:if test="${response eq 'showAccountError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountDeleted -->
    <c:if test="${response eq 'accountDeleted'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertAccountDeleted"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountHasFundsError -->
    <c:if test="${response eq 'accountHasFundsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertAccountHasFundsError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert deleteAccountError -->
    <c:if test="${response eq 'deleteAccountError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertDeleteAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert blockAccountError -->
    <c:if test="${response eq 'blockAccountError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertBlockAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unblockAccountError -->
    <c:if test="${response eq 'unblockAccountError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnblockAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardDetached -->
    <c:if test="${response eq 'cardDetached'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertCardDetached"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert detachCardError -->
    <c:if test="${response eq 'detachCardError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertDetachCardError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardBlocked -->
    <c:if test="${response eq 'cardBlocked'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertCardBlocked"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert blockCardError -->
    <c:if test="${response eq 'blockCardError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertBlockCardError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardUnblocked -->
    <c:if test="${response eq 'cardUnblocked'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertCardUnblocked"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unblockCardError -->
    <c:if test="${response eq 'unblockCardError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnblockCardError"/>
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
                <fmt:message key="admin.account_info.formHeader" var="formHeader"/>
                <fmt:message key="admin.user.showPayments" var="showPayments"/>
                <fmt:message key="admin.account_info.showAttachedCards" var="showAttachedCards"/>
                <fmt:message key="admin.account_info.blockAccount" var="blockAccount"/>
                <fmt:message key="admin.account_info.unblockAccount" var="unblockAccount"/>
                <fmt:message key="admin.account_info.deleteAccount" var="deleteAccount"/>
                <fmt:message key="admin.account_info.accountNumber" var="accountNumber"/>
                <fmt:message key="admin.payment_info.accountOwner" var="accountOwner"/>
                <fmt:message key="admin.account_info.accountBalance" var="accountBalance"/>
                <fmt:message key="admin.account_info.accountStatus" var="accountStatus"/>
                <fmt:message key="admin.account_info.allPayments" var="allPayments"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.payment_info.remained" var="remained"/>
                <fmt:message key="admin.account_info.allAttachedCards" var="allAttachedCards"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="admin.account_info.validity" var="validity"/>
                <fmt:message key="admin.account_info.blockCard" var="blockCard"/>
                <fmt:message key="admin.account_info.unblockCard" var="unblockCard"/>
                <fmt:message key="admin.account_info.detachCard" var="detachCard"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4 style="margin-bottom: 20px;">
                                            ${formHeader}
                                        </h4>

                                        <c:choose>
                                            <c:when test="${response ne 'unableGetAccountId' && response ne 'showAccountError'}">
                                                <jsp:useBean id="viewableAccount" scope="request"
                                                             type="com.system.entity.Account"/>
                                                <jsp:useBean id="viewableUser" scope="request"
                                                             type="com.system.entity.User"/>

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
                                                                <label class="for-form-label" style="margin-top: 5px;">
                                                                        ${accountNumber}:
                                                                </label>
                                                                <div>
                                                                    <input id="number" name="number" type="text"
                                                                           class="form-control" readonly="readonly"
                                                                           value="${viewableAccount.number}"/>
                                                                    <label for="number" class="default-label"></label>
                                                                </div>

                                                                <!-- Account Owner -->
                                                                <label class="for-form-label">
                                                                        ${accountOwner}:
                                                                </label>
                                                                <div>
                                                                    <input id="owner" name="owner" type="text"
                                                                           class="form-control" readonly="readonly"
                                                                           value="${viewableUser.name} ${viewableUser.surname}"/>
                                                                    <label for="owner" class="default-label"></label>
                                                                </div>

                                                                <!-- Account Balance and Currency -->
                                                                <label class="for-form-label">
                                                                        ${accountBalance}:
                                                                </label>
                                                                <div style="display: flex; margin-bottom: 25px;">
                                                                    <input id="balance" name="balance" type="text"
                                                                           class="form-control" readonly="readonly"
                                                                           style="min-width: 49%; margin-right: 1%;"
                                                                           value="${viewableAccount.balance}"/>
                                                                    <div id="currency"
                                                                         class="bfh-selectbox bfh-currencies"
                                                                         style="min-width: 49%; margin-left: 1%; pointer-events: none;"
                                                                         data-currency="${viewableAccount.currency}"
                                                                         data-flags="true">
                                                                    </div>
                                                                    <label for="balance" class="default-label"></label>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4 col-lg-4 col-xl-4 offset-md-1"
                                                                 style="align-self: center;">
                                                                <div class="list-group" id="list-tab" role="tablist"
                                                                     style="margin-top: 24px;">
                                                                    <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                       id="list-unblockAccount-list" role="tab"
                                                                       href="?command=showUser&userId=${viewableUser.userId}"
                                                                       aria-controls="unblockAccount">
                                                                            ${accountOwner} <span
                                                                            class="arrow-link-symbol-right">→</span>
                                                                    </a>
                                                                    <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                       id="list-payments-list" data-toggle="list"
                                                                       href="#list-payments" role="tab"
                                                                       aria-controls="showPayments">
                                                                            ${showPayments} <span
                                                                            class="arrow-link-symbol-right">→</span>
                                                                    </a>
                                                                    <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                       id="list-attachedCards-list" data-toggle="list"
                                                                       href="#list-attachedCards" role="tab"
                                                                       aria-controls="showAttachedCards">
                                                                            ${showAttachedCards} <span
                                                                            class="arrow-link-symbol-right">→</span>
                                                                    </a>
                                                                    <c:choose>
                                                                        <c:when test="${viewableAccount.isBlocked}">
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                               id="list-unblockAccount-list" role="tab"
                                                                               href="?command=unblockAccount&accountId=${viewableAccount.accountId}"
                                                                               aria-controls="unblockAccount">
                                                                                    ${unblockAccount} <span
                                                                                    class="arrow-link-symbol-right">→</span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                               id="list-blockAccount-list" role="tab"
                                                                               href="?command=blockAccount&accountId=${viewableAccount.accountId}"
                                                                               aria-controls="blockAccount">
                                                                                    ${blockAccount} <span
                                                                                    class="arrow-link-symbol-right">→</span>
                                                                            </a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <a class="list-group-item list-group-item-action list-group-item-button-danger"
                                                                       id="list-deleteAccount-list" role="tab"
                                                                       href="#deleteAccountModal?accountNumber=${viewableAccount.number}"
                                                                       onclick="showDeleteAccountModal()"
                                                                       aria-controls="deleteAccount">
                                                                            ${deleteAccount} <span
                                                                            class="arrow-link-symbol-right">→</span>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-xl-12 tab-content" id="nav-tabContent">

                                                        <!-- Show Payments -->
                                                        <div class="tab-pane fade show" id="list-payments"
                                                             role="tabpanel" aria-labelledby="list-home-list">
                                                            <div class="col-xl-12" style="margin-top: 30px;">

                                                                <h4>
                                                                        ${allPayments}
                                                                </h4>

                                                                <c:choose>
                                                                    <c:when test="${!paymentsEmpty}">
                                                                        <div class="card-container" style="width: 75%;">
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
                                                                                                            <span class="arrow-link-symbol-right">→</span>
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
                                                                                                               style="float: right">
                                                                                                                <img src="resources/images/info.png"
                                                                                                                     alt="">
                                                                                                            </a>
                                                                                                        </p>
                                                                                                    </c:when>
                                                                                                    <c:otherwise>

                                                                                                        <!-- Sender and Recipient -->
                                                                                                        <p class="card-title text-muted">
                                                                                                                ${payment.recipientNumber}
                                                                                                            <span class="arrow-link-symbol-left">←</span>
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
                                                                                                               style="float: right">
                                                                                                                <img src="resources/images/info.png"
                                                                                                                     alt="">
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
                                                                        <span class="title-label">
                                                                            <label>
                                                                                <fmt:message
                                                                                        key="admin.account_info.paymentsEmpty"/>
                                                                            </label>
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>

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
                                                                                                    <a href="#detachCardModal?cardNumber=${card.number}"
                                                                                                       onclick="showDetachCardModal()"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/detach-card-link.png"
                                                                                                             alt="${detachCard}">
                                                                                                    </a>
                                                                                                    <c:choose>
                                                                                                        <c:when test="${card.isActive}">
                                                                                                            <a href="?command=blockCard&cardNumber=${card.number}"
                                                                                                               class="float-right">
                                                                                                                <img src="resources/images/locked-link.png"
                                                                                                                     alt="${blockCard}">
                                                                                                            </a>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>
                                                                                                            <a href="?command=unblockCard&cardNumber=${card.number}"
                                                                                                               class="float-right">
                                                                                                                <img src="resources/images/unlocked-link.png"
                                                                                                                     alt="${unblockCard}">
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
                                                                        <span class="title-label">
                                                                            <label>
                                                                                <fmt:message
                                                                                        key="admin.account_info.attachedCardsEmpty"/>
                                                                            </label>
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>

                                                <!-- Return to Users -->
                                                <div class="message-block">
                                                    <label class="title-label">
                                                        <a href="/" class="float-left">
                                                            <span class="arrow-link-symbol-left">←</span>
                                                                ${returnToUsers}
                                                        </a>
                                                    </label>
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
<script src="resources/js/modalWindow_adminShowAccountInfo.js"></script>
</html>