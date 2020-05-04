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
    <link rel="stylesheet" href="resources/css/style_user.css">
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
                <fmt:message key="user.account.balance" var="balance"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="user.page.settings" var="settings"/>
                <fmt:message key="user.page.attachedCards" var="attachedCards"/>
                <fmt:message key="user.page.paymentArchive" var="paymentArchive"/>

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

                                <c:choose>
                                    <c:when test="${accountsEmpty == false}">
                                        <jsp:useBean id="accounts" scope="request" type="java.util.List"/>

                                        <div class="card-body card-container">
                                            <div id="carouselAccounts" class="carousel slide" data-ride="carousel">

                                                <ol class="carousel-indicators">
                                                    <c:forEach items="${accounts}" varStatus="loop">
                                                        <c:choose>
                                                            <c:when test="${loop.first == true}">
                                                                <li data-target="#carouselAccounts"
                                                                    data-slide-to="${loop.index}"
                                                                    class="active"></li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li data-target="#carouselAccounts"
                                                                    data-slide-to="${loop.index}"></li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </ol>

                                                <div class="col-md-12 h-100">
                                                    <div class="carousel-inner h-100">
                                                        <c:forEach items="${accounts}" var="account"
                                                                   varStatus="loop">

                                                            <c:choose>
                                                                <c:when test="${loop.first == true}">
                                                                    <div class="carousel-item active h-100">
                                                                        <svg class="d-block w-100 h-100"
                                                                             focusable="false">
                                                                            <rect width="100%" height="100%"></rect>
                                                                        </svg>
                                                                        <div class="carousel-caption bg-white text-dark h-100">
                                                                            <div class="row w-100 h-100"
                                                                                 style="margin: 0 0 0 -5px;">
                                                                                <div class="col-md-6 h-100 account">
                                                                                    <div class="card bg-light h-100">
                                                                                        <div class="card-header">
                                                                                            <c:choose>
                                                                                                <c:when test="${account.isBlocked}">
                                                                                                    <p class="text-danger float-left">
                                                                                                            ${statusBlocked}
                                                                                                    </p>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <p class="text-success float-left">
                                                                                                            ${statusActive}
                                                                                                    </p>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </div>
                                                                                        <div class="card-body"
                                                                                             style="padding: 30px 0;">
                                                                                            <p class="card-title">
                                                                                                    ${account.number}<br/>
                                                                                                    ${balance}: ${account.balance} ${account.currency}
                                                                                            </p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="col-md-6 h-100">
                                                                                    <div class="row w-100 h-100 options">

                                                                                        <!-- Show Account Info -->
                                                                                        <div class="col-md-4">
                                                                                            <span class="forward-top-link-img">
                                                                                                 <a href="?command=showAccountSettings&accountId=${account.accountId}"
                                                                                                    class="float-right">
                                                                                                    <img src="resources/images/settings.png"
                                                                                                         alt=""/>
                                                                                                    <h5>${settings}</h5>
                                                                                                 </a>
                                                                                            </span>
                                                                                        </div>

                                                                                        <!-- Show Account Cards -->
                                                                                        <div class="col-md-4">
                                                                                            <span class="forward-top-link-img">
                                                                                                 <a href="?command=showAccountCards&accountId=${account.accountId}"
                                                                                                    class="float-right">
                                                                                                    <img src="resources/images/credit-cards.png"
                                                                                                         alt=""/>
                                                                                                    <h5>${attachedCards}</h5>
                                                                                                 </a>
                                                                                            </span>
                                                                                        </div>

                                                                                        <!-- Show Account Payments -->
                                                                                        <div class="col-md-4">
                                                                                            <span class="forward-top-link-img">
                                                                                                <a href="?command=showAccountPayments&accountId=${account.accountId}"
                                                                                                   class="float-right">
                                                                                                    <img src="resources/images/payments.png"
                                                                                                         alt=""/>
                                                                                                    <h5>${paymentArchive}</h5>
                                                                                                </a>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="carousel-item h-100">
                                                                        <svg class="d-block w-100 h-100"
                                                                             focusable="false">
                                                                            <rect width="100%" height="100%"></rect>
                                                                        </svg>
                                                                        <div class="carousel-caption bg-white text-dark h-100">
                                                                            <div class="row h-100"
                                                                                 style="margin: 0 0 0 -5px;">
                                                                                <div class="col-md-6 h-100 account">
                                                                                    <div class="card bg-light h-100">
                                                                                        <div class="card-header">
                                                                                            <c:choose>
                                                                                                <c:when test="${account.isBlocked}">
                                                                                                    <p class="text-danger float-left">
                                                                                                            ${statusBlocked}
                                                                                                    </p>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <p class="text-success float-left">
                                                                                                            ${statusActive}
                                                                                                    </p>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </div>
                                                                                        <div class="card-body"
                                                                                             style="padding: 30px 0;">
                                                                                            <p class="card-title">
                                                                                                    ${account.number}<br/>
                                                                                                    ${balance}: ${account.balance} ${account.currency}
                                                                                            </p>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="col-md-6 h-100">
                                                                                    <div class="row w-100 h-100 options">

                                                                                        <!-- Show Account Info -->
                                                                                        <div class="col-md-4">
                                                                                            <span class="forward-top-link-img">
                                                                                                 <a href="?command=showAccountSettings&accountId=${account.accountId}"
                                                                                                    class="float-right">
                                                                                                    <img src="resources/images/settings.png"
                                                                                                         alt=""/>
                                                                                                    <h5>${settings}</h5>
                                                                                                 </a>
                                                                                            </span>
                                                                                        </div>

                                                                                        <!-- Show Account Cards -->
                                                                                        <div class="col-md-4">
                                                                                            <span class="forward-top-link-img">
                                                                                                 <a href="?command=showAccountCards&accountId=${account.accountId}"
                                                                                                    class="float-right">
                                                                                                    <img src="resources/images/credit-cards.png"
                                                                                                         alt=""/>
                                                                                                    <h5>${attachedCards}</h5>
                                                                                                 </a>
                                                                                            </span>
                                                                                        </div>

                                                                                        <!-- Show Account Payments -->
                                                                                        <div class="col-md-4">
                                                                                            <span class="forward-top-link-img">
                                                                                                <a href="?command=showAccountPayments&accountId=${account.accountId}"
                                                                                                   class="float-right">
                                                                                                    <img src="resources/images/payments.png"
                                                                                                         alt=""/>
                                                                                                    <h5>${paymentArchive}</h5>
                                                                                                </a>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                </div>

                                                <a class="carousel-control-prev" href="#carouselAccounts"
                                                   role="button" data-slide="prev">
                                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                                <a class="carousel-control-next" href="#carouselAccounts"
                                                   role="button" data-slide="next">
                                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card-body" style="min-height: 325px; padding: 35px;">
                                            <div class="message-block">
                                                <span>
                                                    <label>
                                                        <fmt:message key="user.page.accountsEmpty"/>
                                                        <a href="?command=createAccount" class="alert-link">
                                                            <fmt:message key="user.page.create"/>
                                                        </a>
                                                        <fmt:message key="user.page.acceptPaymentsFromAllOverTheWorld"/>
                                                    </label>
                                                </span>
                                                <div class="w-100" style="height:172px;">
                                                    <img src="resources/images/profit_1.png" alt=""
                                                         style="width: 172px; height: 172px; position: absolute; bottom: 35px; right: 25px;"/>
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
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script>
    $('.carousel').carousel({
        interval: 7000,
        keyboard: false,
        wrap: true,
        touch: true
    })
</script>
</html>
