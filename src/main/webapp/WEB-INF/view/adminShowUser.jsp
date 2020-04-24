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
    <c:choose>
        <c:when test="${userIsAdmin}">
            <title><fmt:message key="admin.user.titleIfAdmin"/></title>
        </c:when>
        <c:otherwise>
            <title><fmt:message key="admin.user.titleIfUser"/></title>
        </c:otherwise>
    </c:choose>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowUser.css">
</head>
<body>

<!-- Modal window (Delete User) -->
<div id="smallModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="admin.user.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="admin.user.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="user_bio" class="modal-label">
                        <fmt:message key="admin.users.user"/>:
                    </label>
                    <input id="user_bio" class="form-control modal-form-control"
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
                        <input type="hidden" name="command" value="deleteUser">
                        <input type="hidden" name="userId" value="${userId}">
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

    <!-- Alert showUserError -->
    <c:if test="${response eq 'showUserError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowUserError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert userHasFundsError -->
    <c:if test="${response eq 'userHasFundsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertUserHasFundsError"/>
                <a href="?command=showUserAccounts&userId=${userId}" class="alert-link">
                    <fmt:message key="user.page.viewAccounts"/>
                </a>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert userDeletedError -->
    <c:if test="${response eq 'userDeletedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/>!</strong>
                <fmt:message key="admin.page.alertUserDeletedError"/>
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
                <fmt:message key="admin.user.adminProfile" var="adminProfile"/>
                <fmt:message key="admin.user.userProfile" var="userProfile"/>
                <fmt:message key="admin.users.admin" var="admin_rank"/>
                <fmt:message key="admin.users.user" var="user_rank"/>
                <fmt:message key="admin.user.email" var="email"/>
                <fmt:message key="admin.user.phone" var="phone"/>
                <fmt:message key="admin.user.showPayments" var="showPayments"/>
                <fmt:message key="admin.user.showAccounts" var="showAccounts"/>
                <fmt:message key="admin.user.attachAccount" var="attachAccount"/>
                <fmt:message key="admin.user.updateData" var="updateData"/>
                <fmt:message key="admin.user.deleteUser" var="deleteUser"/>
                <fmt:message key="admin.user.lastPayments" var="lastPayments"/>
                <fmt:message key="admin.user.morePayments" var="morePayments"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.payment_info.remained" var="remained"/>
                <fmt:message key="user.account.allAccounts" var="allAccounts"/>
                <fmt:message key="admin.account_info.balance" var="balance"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="admin.user.userAccounts" var="userAccounts"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <!-- Perhaps there was an error or the viewableUser was deleted from the system -->
                                        <c:choose>
                                            <c:when test="${response ne 'unableGetUserId' &&
                                                            response ne 'showUserError' &&
                                                            response ne 'userDeletedError'}">
                                                <jsp:useBean id="viewableUser" scope="request"
                                                             type="com.system.entity.User"/>

                                                <c:choose>
                                                    <c:when test="${!userIsAdmin}">

                                                        <div class="row">
                                                            <div class="col-xl-12">

                                                                <h4>
                                                                        ${userProfile}
                                                                </h4>

                                                                <div class="form-row">
                                                                    <div class="col-md-7 col-lg-7 col-xl-7">

                                                                        <!-- User bio -->
                                                                        <div>
                                                                            <label class="for-form-label">
                                                                                    ${user_rank}:
                                                                            </label>
                                                                            <input id="bio" name="bio" type="text"
                                                                                   class="form-control"
                                                                                   readonly="readonly"
                                                                                   value="${viewableUser.name} ${viewableUser.surname}"/>
                                                                            <label for="bio"
                                                                                   class="default-label"></label>
                                                                        </div>

                                                                        <!-- User Phone -->
                                                                        <div>
                                                                            <label class="for-form-label">
                                                                                    ${phone}:
                                                                            </label>
                                                                            <input id="phone" name="phone" type="tel"
                                                                                   class="form-control"
                                                                                   readonly="readonly"
                                                                                   value="${viewableUser.phone}"/>
                                                                            <label for="phone"
                                                                                   class="default-label"></label>
                                                                        </div>

                                                                        <!-- User Email -->
                                                                        <div>
                                                                            <label class="for-form-label">
                                                                                    ${email}:
                                                                            </label>
                                                                            <input id="email" name="email" type="email"
                                                                                   class="form-control"
                                                                                   readonly="readonly"
                                                                                   value="${viewableUser.email}"/>
                                                                            <label for="email"
                                                                                   class="default-label"></label>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-4 col-lg-4 col-xl-4 offset-md-1"
                                                                         style="align-self: center;">
                                                                        <div class="list-group" id="list-tab"
                                                                             role="tablist">
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                               id="list-payments-list" role="tab"
                                                                               data-toggle="list" href="#list-payments"
                                                                               aria-controls="payments">
                                                                                    ${showPayments} <span
                                                                                    class="forward-right-link-img">→</span>
                                                                            </a>
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                               id="list-accounts-list" role="tab"
                                                                               data-toggle="list" href="#list-accounts"
                                                                               aria-controls="accounts">
                                                                                    ${showAccounts} <span
                                                                                    class="forward-right-link-img">→</span>
                                                                            </a>
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                               id="list-attachAccount-list"
                                                                               href="?command=attachAccount&userId=${viewableUser.userId}"
                                                                               role="tab" aria-controls="attachAccount">
                                                                                    ${attachAccount} <span
                                                                                    class="forward-right-link-img">→</span>
                                                                            </a>
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-primary"
                                                                               id="list-updateData-list"
                                                                               href="?command=updateUserData&userId=${viewableUser.userId}"
                                                                               role="tab" aria-controls="updateData">
                                                                                    ${updateData} <span
                                                                                    class="forward-right-link-img">→</span>
                                                                            </a>
                                                                            <a class="list-group-item list-group-item-action list-group-item-button-danger"
                                                                               style="margin-top: 1px;"
                                                                               id="list-deleteUser-list"
                                                                               onclick="showModal()"
                                                                               href="#smallModal?name=${viewableUser.name}&surname=${viewableUser.surname}"
                                                                               role="tab" aria-controls="deleteUser">
                                                                                    ${deleteUser} <span
                                                                                    class="forward-right-link-img">→</span>
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
                                                                                ${lastPayments}
                                                                        </h4>

                                                                        <c:choose>
                                                                            <c:when test="${!paymentsEmpty}">
                                                                                <div class="card-container"
                                                                                     style="width: 75%;">
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
                                                                                                                    <a href="?command=showPaymentInfo&userId=${viewableUser.userId}&paymentId=${payment.paymentId}"
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
                                                                                                                    <a href="?command=showPaymentInfo&userId=${viewableUser.userId}&paymentId=${payment.paymentId}"
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
                                                                                    <a href="?command=showUserPayments&userId=${viewableUser.userId}"
                                                                                       class="float-right">
                                                                                            ${morePayments}
                                                                                    </a>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="title-label">
                                                                                    <label>
                                                                                        <fmt:message
                                                                                                key="admin.user.paymentsEmpty"/>
                                                                                    </label>
                                                                                </span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>

                                                                <!-- Show Accounts -->
                                                                <div class="tab-pane fade show" id="list-accounts"
                                                                     role="tabpanel"
                                                                     aria-labelledby="list-accounts-list">
                                                                    <div class="col-xl-12" style="margin-top: 30px;">

                                                                        <h4>
                                                                                ${allAccounts}
                                                                        </h4>

                                                                        <c:choose>
                                                                            <c:when test="${!accountsEmpty}">
                                                                                <div class="card-container"
                                                                                     style="width: 100% !important;">
                                                                                    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-3">
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
                                                                                                            <a href="?command=showAccountInfo&userId=${viewableUser.userId}&accountId=${account.accountId}"
                                                                                                               class="float-right">
                                                                                                                <img src="resources/images/info.png"
                                                                                                                     alt="">
                                                                                                            </a>
                                                                                                        </p>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                    <a href="?command=showUserAccounts&userId=${viewableUser.userId}"
                                                                                       class="float-right">
                                                                                            ${userAccounts}
                                                                                    </a>
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="title-label">
                                                                                    <label>
                                                                                        <fmt:message
                                                                                                key="admin.user.accountsEmpty"/>
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
                                                        <div class="row justify-content-center">
                                                            <div class="col-xl-9">

                                                                <h4>
                                                                        ${adminProfile}
                                                                </h4>

                                                                <div class="form-row justify-content-center">
                                                                    <div class="col-12">

                                                                        <!-- Admin bio -->
                                                                        <div>
                                                                            <label class="for-form-label">
                                                                                    ${admin_rank}:
                                                                            </label>
                                                                            <input id="bio_admin" name="bio"
                                                                                   type="text" class="form-control"
                                                                                   readonly="readonly"
                                                                                   value="${viewableUser.name} ${viewableUser.surname}"/>
                                                                            <label for="bio_admin"
                                                                                   class="default-label"></label>
                                                                        </div>

                                                                        <!-- Admin Phone -->
                                                                        <div>
                                                                            <label class="for-form-label">
                                                                                    ${phone}:
                                                                            </label>
                                                                            <input id="phone_admin" name="phone"
                                                                                   type="tel" class="form-control"
                                                                                   readonly="readonly"
                                                                                   value="${viewableUser.phone}"/>
                                                                            <label for="phone_admin"
                                                                                   class="default-label"></label>
                                                                        </div>

                                                                        <!-- Admin Email -->
                                                                        <div>
                                                                            <label class="for-form-label">
                                                                                    ${email}:
                                                                            </label>
                                                                            <input id="email_admin" name="email"
                                                                                   type="email" class="form-control"
                                                                                   readonly="readonly"
                                                                                   value="${viewableUser.email}"/>
                                                                            <label for="email_admin"
                                                                                   class="default-label"></label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>

                                            </c:when>
                                            <c:otherwise>
                                                <h4>
                                                        ${userProfile}
                                                </h4>

                                                <!-- Return to Users -->
                                                <div class="message-block">
                                                    <label class="title-label">
                                                        <a href="/" class="float-left">
                                                            <span class="forward-left-link-img">←</span>
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
<script src="resources/js/validator_adminShowUser.js"></script>
<script src="resources/js/modalWindow_adminShowUser.js"></script>
</html>