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
    <title><fmt:message key="admin.user_payments.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css"/>
    <script type="text/javascript" src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js"></script>
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowUserPayments.css">
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

    <!-- Alert showUserPaymentsError -->
    <c:if test="${response eq 'showUserPaymentsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowUserPaymentsError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchPaymentsSuccess -->
    <c:if test="${response eq 'searchPaymentsSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchPaymentsSuccess"/>
                    ${numberOfPayments}
                <fmt:message key="admin.user_payments.payments"/>.
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchPaymentsWarning -->
    <c:if test="${response eq 'searchPaymentsWarning'}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p>
                <fmt:message key="admin.page.alertSearchPaymentsWarning"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert searchPaymentsError -->
    <c:if test="${response eq 'searchPaymentsError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertSearchPaymentsError"/>
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
                <fmt:message key="admin.user_payments.formHeader" var="formHeader"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.payment_info.remained" var="remained"/>
                <fmt:message key="user.page.showInfo" var="showInfo"/>
                <fmt:message key="admin.user_payments.incomingPayments" var="incomingPayments"/>
                <fmt:message key="admin.user_payments.outgoingPayments" var="outgoingPayments"/>
                <fmt:message key="admin.support.startDate" var="startDate"/>
                <fmt:message key="admin.support.finalDate" var="finalDate"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>
                <fmt:message key="admin.attachAccount.returnToUserProfile" var="returnToUserProfile"/>
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
                                                <c:if test="${ response eq 'showUserPaymentsError'}">
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
                                                              response ne 'showUserPaymentsError'}">
                                                    <div class="row">
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
                                                                <label>
                                                                        ${searchCriteria}:
                                                                </label>
                                                                <form action="/" method="POST" role="form">
                                                                    <input type="hidden" name="command"
                                                                           value="searchUserPayments"/>

                                                                    <input type="hidden" name="userId"
                                                                           value="${userId}"/>

                                                                    <input type="hidden" id="isIncoming"
                                                                           name="isIncoming"
                                                                           value="${isIncomingValue}"/>

                                                                    <input type="hidden" id="isOutgoing"
                                                                           name="isOutgoing"
                                                                           value="${isOutgoingValue}"/>

                                                                    <!-- Choice of payment type -->
                                                                    <div class="group-btn">
                                                                        <label for="checkbox-isIncoming">
                                                                                ${incomingPayments}
                                                                            <input id="checkbox-isIncoming"
                                                                                   type="checkbox"/>
                                                                        </label>
                                                                        <label for="checkbox-isOutgoing">
                                                                                ${outgoingPayments}
                                                                            <input id="checkbox-isOutgoing"
                                                                                   type="checkbox"/>
                                                                        </label>
                                                                    </div>

                                                                    <!-- Min value Date -->
                                                                    <input id="datepicker-start-date"
                                                                           name="start-date"
                                                                           data-toggle="tooltip-left"
                                                                           data-title="${startDate}"
                                                                           readonly="readonly"
                                                                           value="${startDateValue}"/>
                                                                    <label for="datepicker-start-date"
                                                                           class="default-label">&nbsp;</label>

                                                                    <!-- Max value Date -->
                                                                    <input id="datepicker-final-date"
                                                                           name="final-date"
                                                                           data-toggle="tooltip-left"
                                                                           data-title="${finalDate}"
                                                                           readonly="readonly"
                                                                           value="${finalDateValue}"/>
                                                                    <label for="datepicker-final-date"
                                                                           class="default-label">&nbsp;</label>

                                                                    <script>
                                                                        let today = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
                                                                        $('#datepicker-start-date').datepicker({
                                                                            format: 'dd/mm/yyyy',
                                                                            minDate: '01/01/2020',
                                                                            maxDate: today,
                                                                            showRightIcon: true,
                                                                            uiLibrary: 'bootstrap4'
                                                                        });

                                                                        $('#datepicker-final-date').datepicker({
                                                                            format: 'dd/mm/yyyy',
                                                                            minDate: '01/01/2020',
                                                                            maxDate: today,
                                                                            showRightIcon: true,
                                                                            uiLibrary: 'bootstrap4'
                                                                        });
                                                                    </script>

                                                                    <div class="action" style="padding: 10px 0 0 0;">
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
                                                                    <c:when test="${!paymentsEmpty}">
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
                                                                                                        <p class="card-title text-muted">
                                                                                                                ${remained}: ${payment.newBalance} ${payment.senderCurrency}

                                                                                                            <!-- Show Payment Info -->
                                                                                                            <a href="?command=showPaymentInfo&userId=${userId}&paymentId=${payment.paymentId}"
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
                                                                                                            <a href="?command=showPaymentInfo&userId=${userId}&paymentId=${payment.paymentId}"
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
                                                                        <div class="message-block"
                                                                             style="padding-left: 20px;">
                                                                            <span class="title-label">
                                                                                <label>
                                                                                      <fmt:message
                                                                                              key="admin.user.paymentsEmpty"/>
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
<script src="resources/js/searcher_adminShowUserPayments.js"></script>
</html>