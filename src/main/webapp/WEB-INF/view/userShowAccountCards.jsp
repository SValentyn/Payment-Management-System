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
    <title><fmt:message key="user.attached_cards.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_userShowAccountCards.css">
</head>
<body>

<!-- Modal window (detachCardModal) -->
<div id="detachCardModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.card.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="user.card.modalBody"/>
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
                            data-dismiss="modal" onfocus="this.blur();">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="detachCard"/>
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

    <!-- Alerts unableGetData and showAccountError and unableGetCards -->
    <c:if test="${response eq 'unableGetData' || response eq 'showAccountError' || response eq 'unableGetCards'}">
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

    <!-- Alert unableGetCardId -->
    <c:if test="${response eq 'unableGetCardId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertUnableGetCardIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardBlockedSuccess -->
    <c:if test="${response eq 'cardBlockedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertCardBlockedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardBlockedError -->
    <c:if test="${response eq 'cardBlockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertCardBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardUnblockedSuccess -->
    <c:if test="${response eq 'cardUnblockedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertCardUnblockedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardUnblockedError -->
    <c:if test="${response eq 'cardUnblockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertCardUnblockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardDetachedSuccess -->
    <c:if test="${response eq 'cardDetachedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertCardDetachedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardDetachedError -->
    <c:if test="${response eq 'cardDetachedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertCardDetachedError"/>
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
                <fmt:message key="user.page.showPaymentArchive" var="showPaymentArchive"/>
                <fmt:message key="admin.account_info.accountStatus" var="accountStatus"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="admin.account_info.accountNumber" var="accountNumber"/>
                <fmt:message key="admin.account_info.accountBalance" var="accountBalance"/>
                <fmt:message key="admin.account_info.allAttachedCards" var="allAttachedCards"/>
                <fmt:message key="admin.account_info.validity" var="validity"/>
                <fmt:message key="admin.account_info.blockCard" var="blockCard"/>
                <fmt:message key="admin.account_info.unblockCard" var="unblockCard"/>
                <fmt:message key="admin.account_info.detachCard" var="detachCard"/>
                <fmt:message key="user.account.returnToAllAccounts" var="returnToAllAccounts"/>

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
                                                          response eq 'unableGetCards'}">
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

                                            <c:if test="${response ne 'unableGetData' &&
                                                          response ne 'unableGetAccountId' &&
                                                          response ne 'showAccountError' &&
                                                          response ne 'unableGetCards'}">

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
                                                                           style="margin-top: 8px;">
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
                                                                        <label for="balance" class="default-label">
                                                                        </label>
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

                                                                        <!-- Show Account Payments -->
                                                                        <div class="col-md-6">
                                                                            <span class="forward-top-link-img">
                                                                                <a href="?command=showAccountPayments&accountId=${viewableAccount.accountId}"
                                                                                   class="float-right">
                                                                                    <img src="resources/images/payments.png"
                                                                                         alt=""/>
                                                                                    <h5>${showPaymentArchive}</h5>
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
                                                            <c:when test="${cardsEmpty == false}">

                                                                <h4 style="margin-top: 10px;">
                                                                        ${allAttachedCards}
                                                                </h4>

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
                                                                                                     alt="${detachCard}"/>
                                                                                            </a>
                                                                                            <c:choose>
                                                                                                <c:when test="${card.isActive}">
                                                                                                    <a href="?command=blockCard&accountId=${viewableAccount.accountId}&cardId=${card.cardId}"
                                                                                                       class="float-right">
                                                                                                        <img src="resources/images/block.png"
                                                                                                             alt="${blockCard}"/>
                                                                                                    </a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <a href="?command=unblockCard&accountId=${viewableAccount.accountId}&cardId=${card.cardId}"
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
<script src="resources/js/modalWindow_userShowAccountCards.js"></script>
</html>