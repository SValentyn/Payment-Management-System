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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert noAccounts -->
    <c:if test="${noAccounts == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
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
        <div id="alert" class="alert alert-danger fade in" role="alert">
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
        <div id="alert" class="alert alert-danger fade in" role="alert">
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
        <div id="alert" class="alert alert-danger fade in" role="alert">
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
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><fmt:message key="user.page.alertUnblockCardError"/>
                <a href="?command=support" class="alert-link"><fmt:message key="user.page.technicalSupport"/></a>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert deleteCardError -->
    <c:if test="${deleteCardError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertDeleteCardError"/>
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
                <c:choose>
                    <c:when test="${showAccounts && !showAccountInfo}">
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

                                    <div class="content-box-large">
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
                                                                    <a href="?command=unblockAccount&accountId=${account.accountId}">${unblock}</a>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td>
                                                                    <a href="?command=blockAccount&accountId=${account.accountId}">${block}</a>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td>
                                                            <a href="?command=showAccountInfo&accountId=${account.accountId}">${showInfo}</a>
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
                    <c:when test="${showAccounts && showAccountInfo}">
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

                                    <div class="content-box-large">
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
                                                                    <a href="?command=unblockAccount&accountId=${account.accountId}">${unblock}</a>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td>
                                                                    <a href="?command=blockAccount&accountId=${account.accountId}">${block}</a>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td>
                                                            <a href="?command=showAccountInfo&accountId=${account.accountId}">${showInfo}</a>
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
                                    <fmt:message key="user.card.delete" var="delete"/>

                                    <div class="content-box-header">
                                        <div class="panel-title">
                                                ${allcards}
                                        </div>
                                    </div>

                                    <div class="content-box-large box-with-header">
                                        <table>
                                            <th>${cardNumber}</th>
                                            <th>${cvv}</th>
                                            <th>${date}</th>
                                            <th>${status}</th>
                                            <th>${action}</th>
                                            <th>${delete}</th>

                                            <c:forEach items="${cards}" var="card">
                                                <tr>
                                                    <td>${card.number}</td>
                                                    <td>${card.CVV}</td>
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
                                                                <a href="?command=blockCard&cardNumber=${card.number}">${block}</a>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td>
                                                                <a href="?command=unblockCard&cardNumber=${card.number}">${unblock}</a>
                                                            </td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>
                                                        <a href="?command=deleteCard&cardNumber=${card.number}">${delete}</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-12 panel-warning">
                                    <fmt:message key="user.payment.allpayments" var="allpayments"/>
                                    <fmt:message key="user.payments.recipient'sAccount" var="receiverCard"/>
                                    <fmt:message key="user.payments.sum" var="payment_sum"/>
                                    <fmt:message key="user.payments.date" var="payment_date"/>
                                    <fmt:message key="user.payments.appointment" var="payment_appointment"/>
                                    <fmt:message key="user.payments.success" var="payment_success"/>
                                    <fmt:message key="user.payments.error" var="payment_error"/>
                                    <fmt:message key="user.payments.repeat" var="repeat"/>
                                    <fmt:message key="user.payments.repeatPayment" var="payment_repeat"/>

                                    <div class="content-box-header panel-heading">
                                        <div class="panel-title ">
                                                ${allpayments}
                                        </div>
                                    </div>

                                    <div class="content-box-large box-with-header">
                                        <table>
                                            <th>${receiverCard}</th>
                                            <th>${payment_sum}</th>
                                            <th>${payment_date}</th>
                                            <th>${payment_appointment}</th>
                                            <th>${status}</th>
                                            <th>${payment_repeat}</th>

                                            <c:forEach items="${payments}" var="payment">
                                                <tr>
                                                    <td>${payment.recipientAccountNumber}</td>
                                                    <td>${payment.sum}</td>
                                                    <td>${payment.date}</td>
                                                    <td>${payment.appointment}</td>
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
                                                    <td>
                                                        <a href="?command=repeatPayment&paymentId=${payment.paymentId}">${repeat}</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise/>
                </c:choose>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>