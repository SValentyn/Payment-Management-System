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

<!-- Modal window -->
<div id="smallModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    <fmt:message key="user.card.modalHeader"/>
                </h4>
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

    <!-- Alert noAccounts -->
    <c:if test="${noAccounts == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.youNotHaveAccount"/>
                <a href="?command=createAccount" class="alert-link"><fmt:message key="user.page.create"/></a>
                <fmt:message key="user.page.itNow"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert blockAccountError -->
    <c:if test="${blockAccountError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertBlockAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unblockAccountAlert -->
    <c:if test="${unblockAccountAlert == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><fmt:message key="user.page.alertUnblockAccountError"/>
                <a href="?command=support" class="alert-link"><fmt:message key="user.page.technicalSupport"/></a>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert blockCardError -->
    <c:if test="${blockCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertBlockCardError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unblockCardAlert -->
    <c:if test="${unblockCardAlert == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><fmt:message key="user.page.alertUnblockCardError"/>
                <a href="?command=support" class="alert-link"><fmt:message key="user.page.technicalSupport"/></a>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert detachCardError -->
    <c:if test="${detachCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertDetachCardError"/>
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

                <div class="card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center" role="tablist">
                            <li class="nav-item-active">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="true"
                                   onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                    <img src="resources/images/show-accounts.png"
                                         alt="" class="sidebar-icon">
                                    ${myAccounts}
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-hover" role="tab" data-toggle="tab" aria-selected="false"
                                   onclick="document.getElementById('form-showPayments').submit(); return false;">
                                    <img src="resources/images/balance.png"
                                         alt="" class="sidebar-icon">
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
                            <c:when test="${showAccounts && !showCards}">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <fmt:message key="user.account.allaccounts" var="allaccounts"/>
                                            <fmt:message key="user.account.number" var="number"/>
                                            <fmt:message key="user.account.balance" var="balance"/>
                                            <fmt:message key="user.account.status" var="status"/>
                                            <fmt:message key="user.account.action" var="action"/>
                                            <fmt:message key="user.account.status.active" var="statusActive"/>
                                            <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                                            <fmt:message key="user.account.button.block" var="block"/>
                                            <fmt:message key="user.account.button.unblock" var="unblock"/>
                                            <fmt:message key="user.account.button.showInfo" var="showInfo"/>

                                            <div class="sidebar-large">
                                                <div class="panel-heading">
                                                    <div class="panel-title">
                                                            ${allaccounts}
                                                    </div>
                                                </div>

                                                <div class="panel-body">
                                                    <table>
                                                        <th>${number}</th>
                                                        <th>${balance}</th>
                                                        <th>${status}</th>
                                                        <th>${action}</th>
                                                        <th>${showInfo}</th>

                                                        <c:forEach items="${accounts}" var="account">
                                                            <tr>
                                                                <td>${account.number}</td>
                                                                <td>${account.balance}</td>
                                                                <c:choose>
                                                                    <c:when test="${account.isBlocked}">
                                                                        <td style="color: darkred;">
                                                                                ${statusBlocked}
                                                                        </td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td style="color: darkgreen;">
                                                                                ${statusActive}
                                                                        </td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <c:choose>
                                                                    <c:when test="${account.isBlocked}">
                                                                        <td>
                                                                            <a href="?command=unblockAccount&accountId=${account.accountId}">
                                                                                    ${unblock}
                                                                                <img src="resources/images/unlocked-link.png"
                                                                                     alt="" class="icon">
                                                                            </a>
                                                                        </td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td>
                                                                            <a href="?command=blockAccount&accountId=${account.accountId}">
                                                                                    ${block}
                                                                                <img src="resources/images/locked-link.png"
                                                                                     alt="" class="icon">
                                                                            </a>
                                                                        </td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <td>
                                                                    <a href="?command=showAccountInfo&accountId=${account.accountId}">
                                                                            ${showInfo}
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${showAccounts && showCards}">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <fmt:message key="user.account.allaccounts" var="allaccounts"/>
                                            <fmt:message key="user.account.number" var="number"/>
                                            <fmt:message key="user.account.balance" var="balance"/>
                                            <fmt:message key="user.account.status" var="status"/>
                                            <fmt:message key="user.account.action" var="action"/>
                                            <fmt:message key="user.account.status.active" var="statusActive"/>
                                            <fmt:message key="user.account.status.blocked" var="statusBlocked"/>
                                            <fmt:message key="user.account.button.block" var="block"/>
                                            <fmt:message key="user.account.button.unblock" var="unblock"/>
                                            <fmt:message key="user.account.button.showInfo" var="showInfo"/>

                                            <div class="sidebar-large">
                                                <div class="panel-heading">
                                                    <div class="panel-title">
                                                            ${allaccounts}
                                                    </div>
                                                </div>

                                                <div class="panel-body">
                                                    <table>
                                                        <th>${number}</th>
                                                        <th>${balance}</th>
                                                        <th>${status}</th>
                                                        <th>${action}</th>
                                                        <th>${showInfo}</th>

                                                        <c:forEach items="${accounts}" var="account">
                                                            <tr>
                                                                <td>${account.number}</td>
                                                                <td>${account.balance}</td>
                                                                <c:choose>
                                                                    <c:when test="${account.isBlocked}">
                                                                        <td style="color: darkred;">
                                                                                ${statusBlocked}
                                                                        </td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td style="color: darkgreen;">
                                                                                ${statusActive}
                                                                        </td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <c:choose>
                                                                    <c:when test="${account.isBlocked}">
                                                                        <td>
                                                                            <a href="?command=unblockAccount&accountId=${account.accountId}">
                                                                                    ${unblock}
                                                                                <img src="resources/images/unlocked-link.png"
                                                                                     alt="" class="icon">
                                                                            </a>
                                                                        </td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td>
                                                                            <a href="?command=blockAccount&accountId=${account.accountId}">
                                                                                    ${block}
                                                                                <img src="resources/images/locked-link.png"
                                                                                     alt="" class="icon">
                                                                            </a>
                                                                        </td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <td>
                                                                    <a href="?command=showAccountInfo&accountId=${account.accountId}">
                                                                            ${showInfo}
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <fmt:message key="user.card.allcards" var="allcards"/>
                                            <fmt:message key="user.card.number" var="cardNumber"/>
                                            <fmt:message key="user.card.cvv" var="cvv"/>
                                            <fmt:message key="user.card.date" var="date"/>
                                            <fmt:message key="user.card.detachCard" var="detachCard"/>
                                            <fmt:message key="user.card.detach" var="detach"/>

                                            <div class="sidebar-header">
                                                <div class="panel-title">
                                                        ${allcards}
                                                </div>
                                            </div>

                                            <div class="sidebar-large box-with-header">
                                                <table>
                                                    <th>${cardNumber}</th>
                                                    <th>${date}</th>
                                                    <th>${status}</th>
                                                    <th>${action}</th>
                                                    <th>${detachCard}</th>

                                                    <c:forEach items="${cards}" var="card">
                                                        <tr>
                                                            <td>${card.number}</td>
                                                            <td>${card.validity}</td>
                                                            <c:choose>
                                                                <c:when test="${card.isActive}">
                                                                    <td style="color: darkgreen;">
                                                                            ${statusActive}
                                                                    </td>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <td style="color: darkred;">
                                                                            ${statusBlocked}
                                                                    </td>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:choose>
                                                                <c:when test="${card.isActive}">
                                                                    <td>
                                                                        <a href="?command=blockCard&cardNumber=${card.number}">
                                                                                ${block}
                                                                            <img src="resources/images/locked-link.png"
                                                                                 alt="" class="icon">
                                                                        </a>
                                                                    </td>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <td>
                                                                        <a href="?command=unblockCard&cardNumber=${card.number}">
                                                                                ${unblock}
                                                                            <img src="resources/images/unlocked-link.png"
                                                                                 alt="" class="icon">
                                                                        </a>
                                                                    </td>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <td>
                                                                <a href="#smallModal?cardNumber=${card.number}"
                                                                   onclick="showModal()">
                                                                        ${detach}
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/showingModalWindow_user.js"></script>
</html>