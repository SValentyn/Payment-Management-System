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
    <title><fmt:message key="admin.page.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>

<!-- Modal window (deleteAccountModal) -->
<div id="deleteAccountModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="admin.account.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="admin.account.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="accountNumberText" class="modal-label">
                        <fmt:message key="admin.account.modalAccountLabel"/>
                    </label>
                    <input id="accountNumberText" class="form-control modal-form-control"
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
                        <input type="hidden" name="command" value="deleteAccount">
                        <input type="hidden" name="accountNumber" id="accountNumber"/>

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
                <fmt:message key="admin.card.modalBody"/>
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

    <!-- Alert blockAccountError -->
    <c:if test="${blockAccountError == true}">
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
    <c:if test="${unblockAccountError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnblockAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert blockCardError -->
    <c:if test="${blockCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertBlockCard"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unblockCardError -->
    <c:if test="${unblockCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnblockCard"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert deleteAccountError -->
    <c:if test="${deleteAccountError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertDeleteAccount"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert detachCardError -->
    <c:if test="${detachCardError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertDetachCard"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-md-10" style="padding-left: 0;">
                <div class="row">
                    <div class="col-md-7">
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
                                <fmt:message key="sidebar.attachCard" var="attachCard"/>
                                <fmt:message key="admin.user.deleteAccount" var="deleteAccount"/>
                                <fmt:message key="user.card.detachCard" var="detachCard"/>

                                <div class="sidebar-large" style="padding: 20px 3px 20px 3px;">
                                    <div class="panel-heading">
                                        <div class="panel-title">
                                            ${allaccounts}
                                        </div>
                                    </div>

                                    <div class="panel-body">
                                        <table>
                                            <th>
                                                ${number}
                                            </th>
                                            <th>
                                                ${balance}<br/>
                                                <img src="resources/images/balance.png"
                                                     alt="" class="icon icon-header" style="height: 15px; width: 17px;">
                                            </th>
                                            <th>
                                                ${status}<br/>
                                                <img src="resources/images/status.png"
                                                     alt="" class="icon icon-header"
                                                     style="height: 15px; width: 15px; opacity: 0.8;">
                                            </th>
                                            <th>
                                                ${action}<br/>
                                                <img src="resources/images/locked.png"
                                                     alt="" class="icon icon-header">
                                                |
                                                <img src="resources/images/unlocked.png"
                                                     alt="" class="icon icon-header" style="margin-left: 0;">
                                            </th>
                                            <th>
                                                ${showInfo}
                                                <img src="resources/images/show-cards-payments.png"
                                                     alt="" class="icon icon-header" style="height: 16px;width: 16px;">
                                            </th>
                                            <th>
                                                ${attachCard}
                                                <img src="resources/images/attach-card.png"
                                                     alt="" class="icon icon-header" style="top: -1px;">
                                            </th>
                                            <th>
                                                ${deleteAccount}
                                                <img src="resources/images/delete.png"
                                                     alt="" class="icon icon-header"
                                                     style="height: 16px; width: 16px; border-radius: 4px;">
                                            </th>

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
                                                                        ${unblock}<br/>
                                                                    <img src="resources/images/unlocked-link.png"
                                                                         alt="" class="icon">
                                                                </a>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td>
                                                                <a href="?command=blockAccount&accountId=${account.accountId}">
                                                                        ${block}<br/>
                                                                    <img src="resources/images/locked-link.png"
                                                                         alt="" class="icon">
                                                                </a>
                                                            </td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>
                                                        <a href="?command=showAccountInfo&accountId=${account.accountId}">
                                                                ${showInfo}
                                                            <img src="resources/images/show-cards-payments-link.png"
                                                                 alt="" class="icon"
                                                                 style="height: 16px; width: 16px;">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=attachCard&accountId=${account.accountId}">
                                                                ${attachCard}
                                                            <img src="resources/images/attach-card-link.png"
                                                                 alt="" class="icon" style="top: -1px;">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="#deleteAccountModal?accountNumber=${account.number}"
                                                           onclick="showDeleteAccountModal()">
                                                                ${deleteAccount}
                                                            <img src="resources/images/delete-link.png"
                                                                 alt="" class="icon"
                                                                 style="height: 15px; width: 15px; border-radius: 4px;">
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
                    <div class="col-md-5" style="padding-left: 5px; padding-right: 20px;">
                        <div class="row">
                            <div class="col-md-12">
                                <fmt:message key="user.card.allcards" var="allcards"/>
                                <fmt:message key="user.card.number" var="cardNumber"/>
                                <fmt:message key="user.card.cvv" var="cvv"/>
                                <fmt:message key="user.card.date" var="date"/>

                                <div class="sidebar-header">
                                    <div class="panel-title">
                                        ${allcards}
                                    </div>
                                </div>

                                <div class="sidebar-large box-with-header">
                                    <table>
                                        <th>
                                            ${cardNumber}
                                        </th>
                                        <th>
                                            ${date}
                                            <img src="resources/images/expiry-date.png"
                                                 alt="" class="icon icon-header"
                                                 style="height: 20px; width: 20px; opacity: 1.0;">
                                        </th>
                                        <th>
                                            ${status}<br/>
                                            <img src="resources/images/status.png"
                                                 alt="" class="icon icon-header"
                                                 style="height: 15px; width: 15px; opacity: 0.8;">
                                        </th>
                                        <th>
                                            ${action}<br/>
                                            <img src="resources/images/locked.png"
                                                 alt="" class="icon icon-header">
                                            |
                                            <img src="resources/images/unlocked.png"
                                                 alt="" class="icon icon-header" style="margin-left: 0">
                                        </th>
                                        <th>
                                            ${detachCard}
                                            <img src="resources/images/detach-card.png"
                                                 alt="" class="icon icon-header" style="height: 15px; width: 15px;">
                                        </th>

                                        <c:forEach items="${cards}" var="card">
                                            <tr>
                                                <td>${card.number}</td>
                                                <td>${card.validity}
                                                </td>
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
                                                                    ${block}<br/>
                                                                <img src="resources/images/locked-link.png"
                                                                     alt="" class="icon">
                                                            </a>
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="?command=unblockCard&cardNumber=${card.number}">
                                                                    ${unblock}<br/>
                                                                <img src="resources/images/unlocked-link.png"
                                                                     alt="" class="icon">
                                                            </a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>
                                                    <a href="#detachCardModal?cardNumber=${card.number}"
                                                       onclick="showDetachCardModal()">
                                                            ${detachCard}
                                                        <img src="resources/images/detach-card-link.png"
                                                             alt="" class="icon" style="height: 15px; width: 15px;">
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5" style="padding-left: 5px; padding-right: 20px;">
                        <div class="row">
                            <div class="col-md-12 panel-warning">
                                <fmt:message key="user.payment.allpayments" var="allpayments"/>
                                <fmt:message key="user.payments.recipient'sAccount" var="receiverCard"/>
                                <fmt:message key="user.payments.sum" var="payment_sum"/>
                                <fmt:message key="user.payments.date" var="payment_date"/>
                                <fmt:message key="user.payments.success" var="payment_success"/>
                                <fmt:message key="user.payments.error" var="payment_error"/>

                                <div class="sidebar-header panel-heading">
                                    <div class="panel-title ">
                                        ${allpayments}
                                    </div>
                                </div>

                                <div class="sidebar-large box-with-header">
                                    <table>
                                        <th>${receiverCard}</th>
                                        <th>${payment_sum}</th>
                                        <th>${payment_date}</th>
                                        <th>${status}</th>

                                        <c:forEach items="${payments}" var="payment">
                                            <tr>
                                                <td>${payment.recipientAccountNumber}</td>
                                                <td>${payment.sum}</td>
                                                <td>${payment.date}</td>
                                                <c:choose>
                                                    <c:when test="${payment.condition}">
                                                        <td style="color: darkgreen;">
                                                                ${payment_success}
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td style="color: darkred;">
                                                                ${payment_error}
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tr>
                                        </c:forEach>
                                    </table>
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
<script src="resources/js/showingModalWindow_adminAccountsControl.js"></script>
</html>