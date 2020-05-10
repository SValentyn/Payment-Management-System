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
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
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
                                                                    <div class="action" style="text-align: unset;">
                                                                        <button id="submit" type="submit"
                                                                                class="btn btn-primary signup btn-default"
                                                                                style="width: 100%; margin-bottom: 30px;">
                                                                                ${returnToUserProfile}
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>

                                                            <div class="search-block">
                                                                <label>
                                                                        ${searchCriteria}:
                                                                </label>
                                                                <form action="/" method="GET" role="form">
                                                                    <input type="hidden" name="command"
                                                                           value="searchAccounts"/>
                                                                    <div class="action" style="text-align: unset;">
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
</html>