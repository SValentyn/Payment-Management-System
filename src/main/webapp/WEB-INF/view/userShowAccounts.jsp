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
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert accountsEmpty -->
    <c:if test="${accountsEmpty == true}">
        <div id="alert" class="alert alert-warning fade show" role="alert">
            <p>
                <fmt:message key="user.page.youNotHaveAccount"/>
                <a href="?command=createAccount" class="alert-link"><fmt:message key="user.page.create"/></a>
                <fmt:message key="user.page.itNow"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetUser -->
    <c:if test="${response eq 'unableGetUser'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertUnableGetUser"/>
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
                <fmt:message key="user.account.allAccounts" var="allAccounts"/>
                <fmt:message key="user.account.number" var="number"/>
                <fmt:message key="user.account.balance" var="balance"/>
                <fmt:message key="user.account.status" var="status"/>
                <fmt:message key="user.account.action" var="action"/>
                <fmt:message key="user.account.status.active" var="statusActive"/>
                <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                <fmt:message key="user.account.button.block" var="block"/>
                <fmt:message key="user.account.button.unblock" var="unblock"/>
                <fmt:message key="user.account.button.showInfo" var="showInfo"/>

                <div class="card shadow-none">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center" role="tablist">
                            <li class="nav-item-active">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="true"
                                   onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                    <img src="resources/images/show-accounts.png"
                                         alt="" class="icon-sidebar">
                                    ${myAccounts}
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-hover" role="tab" data-toggle="tab" aria-selected="false"
                                   onclick="document.getElementById('form-showPayments').submit(); return false;">
                                    <img src="resources/images/balance.png"
                                         alt="" class="icon-sidebar">
                                    ${myPayments}
                                </a>
                            </li>
                        </ul>
                    </div>

                    <form action="/" role="form" method="GET" id="form-showAccounts">
                        <input type="hidden" name="command" value="showAccounts">
                    </form>
                    <form action="/" role="form" method="GET" id="form-showPayments">
                        <input type="hidden" name="command" value="showPayments">
                    </form>

                    <div class="card-body">
                        <c:choose>
                            <c:when test="${accountsEmpty == false}">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-12">

                                                ${allAccounts}

                                                ${number}
                                                ${balance}
                                                ${status}
                                                ${action}
                                                ${showInfo}

                                            <c:forEach items="${accounts}" var="account">
                                                ${account.number}
                                                ${account.balance}
                                                <c:choose>
                                                    <c:when test="${account.isBlocked}">
                                                        ${statusBlocked}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${statusActive}
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${account.isBlocked}">
                                                        <a href="?command=unblockAccount&accountId=${account.accountId}">
                                                                ${unblock}
                                                            <img src="resources/images/unlocked-link.png"
                                                                 alt="" class="icon">
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="?command=blockAccount&accountId=${account.accountId}">
                                                                ${block}
                                                            <img src="resources/images/locked-link.png"
                                                                 alt="" class="icon">
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="?command=showAccountInfo&accountId=${account.accountId}">
                                                        ${showInfo}
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>




                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/modalWindow_userShowAccounts.js"></script>
</html>