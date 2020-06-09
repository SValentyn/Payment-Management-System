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

<!-- Modal window -->
<div id="deleteAccountModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
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
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="deleteAccount"/>
                        <input type="hidden" name="userId" value="${viewableUser.userId}"/>
                        <input type="hidden" name="accountId" value="${viewableAccount.accountId}"/>
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur();">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal window -->
<div id="detachCardModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.account_cards.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="admin.account_info.card.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="cardNumberText" class="modal-label">
                        <fmt:message key="user.account_cards.modalCardLabel"/>
                    </label>
                    <input id="cardNumberText" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" style="border-radius: 5px;"
                            data-dismiss="modal" onfocus="this.blur();">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="detachCard"/>
                        <input type="hidden" name="userId" value="${viewableUser.userId}"/>
                        <input type="hidden" name="accountId" value="${viewableAccount.accountId}"/>
                        <input type="hidden" name="cardId" id="cardId"/>
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur();">
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

    <!-- Alert unableGetAccountByUserId -->
    <c:if test="${response eq 'unableGetAccountByUserId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetAccountByUserIdError"/>
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

    <!-- Alert accountBlockedSuccess -->
    <c:if test="${response eq 'accountBlockedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertAccountBlockedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountBlockedError -->
    <c:if test="${response eq 'accountBlockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertAccountBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountUnblockedSuccess -->
    <c:if test="${response eq 'accountUnblockedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertAccountUnblockedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountUnblockedError -->
    <c:if test="${response eq 'accountUnblockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertAccountUnblockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountDeletedSuccess -->
    <c:if test="${response eq 'accountDeletedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertAccountDeletedSuccess"/>
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

    <!-- Alert accountDeletedError -->
    <c:if test="${response eq 'accountDeletedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertAccountDeletedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetCardId -->
    <c:if test="${response eq 'unableGetCardId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetCardIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetCard -->
    <c:if test="${response eq 'unableGetCard'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetCardError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardBlockedSuccess -->
    <c:if test="${response eq 'cardBlockedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertCardBlockedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardBlockedError -->
    <c:if test="${response eq 'cardBlockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertCardBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardUnblockedSuccess -->
    <c:if test="${response eq 'cardUnblockedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertCardUnblockedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardUnblockedError -->
    <c:if test="${response eq 'cardUnblockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertCardUnblockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardDetachedSuccess -->
    <c:if test="${response eq 'cardDetachedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="admin.page.success"/>!</strong>
                <fmt:message key="admin.page.alertCardDetachedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardDetachedError -->
    <c:if test="${response eq 'cardDetachedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertCardDetachedError"/>
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
                <fmt:message key="user.account_info.status.active" var="statusActive"/>
                <fmt:message key="user.account_info.status.blocked" var="statusBlocked"/>
                <fmt:message key="user.page.showInfo" var="showInfo"/>
                <fmt:message key="admin.account_info.validity" var="validity"/>
                <fmt:message key="admin.account_info.blockCard" var="blockCard"/>
                <fmt:message key="admin.account_info.unblockCard" var="unblockCard"/>
                <fmt:message key="admin.account_info.detachCard" var="detachCard"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>
                <fmt:message key="admin.attach_account.returnToUserProfile" var="returnToUserProfile"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4 style="margin-bottom: 15px;">
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
                                        <c:if test="${response eq 'unableGetAccountId' ||
                                                      response eq 'unableGetAccountByUserId' ||
                                                      response eq 'showAccountError' ||
                                                      response eq 'accountDeletedSuccess'}">
                                            <div class="message-block">
                                                <span class="title-label forward-left-link-img">
                                                    <a href="?command=showUser&userId=${userId}" class="float-left">
                                                        <img src="resources/images/return.png"
                                                             class="icon-return" alt=""/>
                                                            ${returnToUserProfile}
                                                    </a>
                                                </span>
                                            </div>
                                        </c:if>

                                        <c:if test="${response ne 'unableGetUserId' &&
                                                      response ne 'unableGetAccountId' &&
                                                      response ne 'unableGetAccountByUserId' &&
                                                      response ne 'showAccountError' &&
                                                      response ne 'accountDeletedSuccess'}">

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
                                                                           style="margin-top:10px; font-size: 18px;">
                                                                            ${accountStatus}:
                                                                        <span class="text-danger">
                                                                                ${statusBlocked}
                                                                        </span>
                                                                    </label>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <label class="for-form-label text-center"
                                                                           style="margin-top:10px; font-size: 18px;">
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
                                                                       style="margin-top: 8px;">
                                                                        ${accountNumber}:
                                                                </label>
                                                                <input id="number" name="number"
                                                                       type="text" class="form-control"
                                                                       readonly="readonly"
                                                                       value="${viewableAccount.number}"/>
                                                                <label for="number" class="default-label">&nbsp;</label>
                                                            </div>

                                                            <!-- Account Owner -->
                                                            <div>
                                                                <label class="for-form-label">
                                                                        ${accountOwner}:
                                                                </label>
                                                                <input id="owner" name="owner" type="text"
                                                                       class="form-control" readonly="readonly"
                                                                       value="${viewableUser.name} ${viewableUser.surname}"/>
                                                                <label for="owner" class="default-label">&nbsp;</label>
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

                                                        <div class="col-md-4 col-lg-4 col-xl-4 offset-md-1"
                                                             style="align-self: center;">
                                                            <div class="list-group" id="list-tab" role="tablist"
                                                                 style="margin-top: 24px;">
                                                                <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                   id="list-unblockAccount-list" role="tab"
                                                                   href="?command=showUser&userId=${viewableUser.userId}"
                                                                   aria-controls="unblockAccount">
                                                                    <span class="forward-right-link-img">
                                                                         ${accountOwner}
                                                                        <img src="resources/images/forward-white.png"
                                                                             alt=""/>
                                                                    </span>
                                                                </a>
                                                                <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                   id="list-payments-list" data-toggle="list"
                                                                   href="#list-payments" role="tab"
                                                                   aria-controls="showPayments">
                                                                    <span class="forward-right-link-img">
                                                                         ${showPayments}
                                                                        <img src="resources/images/forward-white.png"
                                                                             alt=""/>
                                                                    </span>
                                                                </a>
                                                                <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                   id="list-attachedCards-list" data-toggle="list"
                                                                   href="#list-attachedCards" role="tab"
                                                                   aria-controls="showAttachedCards">
                                                                    <span class="forward-right-link-img">
                                                                         ${showAttachedCards}
                                                                        <img src="resources/images/forward-white.png"
                                                                             alt=""/>
                                                                    </span>
                                                                </a>
                                                                <c:choose>
                                                                    <c:when test="${viewableAccount.isBlocked}">
                                                                        <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                           id="list-unblockAccount-list" role="tab"
                                                                           href="?command=unblockAccount"
                                                                           onclick="document.getElementById('form-unblockAccount').submit(); return false;"
                                                                           aria-controls="unblockAccount">
                                                                            <span class="forward-right-link-img">
                                                                                 ${unblockAccount}
                                                                                <img src="resources/images/forward-white.png"
                                                                                     alt=""/>
                                                                            </span>
                                                                        </a>
                                                                        <form action="/" method="POST"
                                                                              id="form-unblockAccount" role="form">
                                                                            <input type="hidden" name="command"
                                                                                   value="unblockAccount"/>
                                                                            <input type="hidden" name="userId"
                                                                                   value="${viewableUser.userId}"/>
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
                                                                            <span class="forward-right-link-img">
                                                                                 ${blockAccount}
                                                                                <img src="resources/images/forward-white.png"
                                                                                     alt=""/>
                                                                            </span>
                                                                        </a>
                                                                        <form action="/" method="POST"
                                                                              id="form-blockAccount" role="form">
                                                                            <input type="hidden" name="command"
                                                                                   value="blockAccount"/>
                                                                            <input type="hidden" name="userId"
                                                                                   value="${viewableUser.userId}"/>
                                                                            <input type="hidden" name="accountId"
                                                                                   value="${viewableAccount.accountId}"/>
                                                                        </form>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <a class="list-group-item list-group-item-action list-group-item-button-danger"
                                                                   id="list-deleteAccount-list" role="tab"
                                                                   href="#deleteAccountModal?accountNumber=${viewableAccount.number}"
                                                                   onclick="showDeleteAccountModal();"
                                                                   aria-controls="deleteAccount">
                                                                    <span class="forward-right-link-img">
                                                                         ${deleteAccount}
                                                                        <img src="resources/images/forward-white.png"
                                                                             alt=""/>
                                                                    </span>
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
                                                                    <div class="card-container"
                                                                         style="width: 75% !important;">
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
                                                                                                    <p class="card-title text-muted">
                                                                                                            ${remained}: ${payment.newBalance} ${payment.senderCurrency}

                                                                                                        <!-- Show Payment Info -->
                                                                                                        <a href="?command=showPaymentInfo&userId=${viewableUser.userId}&paymentId=${payment.paymentId}"
                                                                                                           class="float-right">
                                                                                                            <img src="resources/images/info.png"
                                                                                                                 alt="${showInfo}"/>
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
                                                                                                        <a href="?command=showPaymentInfo&userId=${viewableUser.userId}&paymentId=${payment.paymentId}"
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
                                                                                                    <img src="resources/images/detach-card.png"
                                                                                                         style="margin-left: 7px;"
                                                                                                         alt="${detach}"/>
                                                                                                </a>
                                                                                                <c:choose>
                                                                                                    <c:when test="${card.isActive}">
                                                                                                        <a href="?command=blockCard&userId=${viewableUser.userId}&accountId=${viewableAccount.accountId}&cardId=${card.cardId}"
                                                                                                           class="float-right">
                                                                                                            <img src="resources/images/block.png"
                                                                                                                 alt="${blockCard}"/>
                                                                                                        </a>
                                                                                                    </c:when>
                                                                                                    <c:otherwise>
                                                                                                        <a href="?command=unblockCard&userId=${viewableUser.userId}&accountId=${viewableAccount.accountId}&cardId=${card.cardId}"
                                                                                                           class="float-right">
                                                                                                            <img src="resources/images/unblock.png"
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/modalWindow_adminShowAccountInfo.js"></script>
</html>