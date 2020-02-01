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
    <title><fmt:message key="admin.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert blockAccountError -->
    <c:if test="${blockAccountError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 303px;">
            <p><strong>Failed!</strong> Failed to block account.</p>
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

            <div class="col-md-10">
                <div class="row">
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-md-12">
                                <fmt:message key="home.account.allaccounts" var="allaccounts"/>
                                <fmt:message key="home.account.number" var="number"/>
                                <fmt:message key="home.account.balance" var="balance"/>
                                <fmt:message key="home.account.status" var="status"/>
                                <fmt:message key="home.account.action" var="action"/>
                                <fmt:message key="home.account.status.active" var="statusActive"/>
                                <fmt:message key="home.account.status.blocked" var="statusBlocked"/>
                                <fmt:message key="home.account.button.block" var="block"/>
                                <fmt:message key="admin.account.unblock" var="unblock"/>
                                <fmt:message key="home.account.button.showInfo" var="showInfo"/>
                                <fmt:message key="admin.card.addCard" var="addCard"/>
                                <fmt:message key="admin.account.delete" var="delete"/>

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
                                            <th></th>
                                            <th></th>
                                            <th></th>

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
                                                                </a>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td>
                                                                <a href="?command=blockAccount&accountId=${account.accountId}">
                                                                        ${block}
                                                                </a>
                                                            </td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>
                                                        <a href="?command=showCardsAndPayments&accountId=${account.accountId}">
                                                                ${showInfo}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=addCard&accountId=${account.accountId}">
                                                                ${addCard}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="?command=deleteAccount&accountId=${account.accountId}">
                                                                ${delete}
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
                    <div class="col-md-5" style="padding-left: 5px;padding-right: 20px;">
                        <div class="row">
                            <div class="col-md-12">
                                <fmt:message key="home.card.allcards" var="allcards"/>
                                <fmt:message key="home.card.number" var="cardNumber"/>
                                <fmt:message key="home.card.cvv" var="cvv"/>
                                <fmt:message key="home.card.date" var="date"/>

                                <div class="content-box-header">
                                    <div class="panel-title">
                                        ${allcards}
                                    </div>
                                </div>

                                <div class="content-box-large box-with-header" style="padding-left: 12px;padding-right: 12px;">
                                    <table>
                                        <th>${cardNumber}</th>
                                        <th>${cvv}</th>
                                        <th>${date}</th>
                                        <th>${status}</th>
                                        <th>${action}</th>
                                        <th></th>

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
                                                            <a href="?command=blockCard&cardNumber=${card.number}">
                                                                    ${block}
                                                            </a>
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="?command=unblockCard&cardNumber=${card.number}">
                                                                    ${unblock}
                                                            </a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td>
                                                    <a href="?command=deleteCard&cardId=${card.cardId}">
                                                            ${delete}
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5" style="padding-left: 5px;padding-right: 20px;">
                        <div class="row">
                            <div class="col-md-12 panel-warning">
                                <fmt:message key="home.payment.allpayments" var="allpayments"/>
                                <fmt:message key="home.payments.receiverCard" var="receiverCard"/>
                                <fmt:message key="home.payments.sum" var="payment_sum"/>
                                <fmt:message key="home.payments.date" var="payment_date"/>
                                <fmt:message key="home.payments.success" var="payment_success"/>
                                <fmt:message key="home.payments.error" var="payment_error"/>

                                <div class="content-box-header panel-heading">
                                    <div class="panel-title ">
                                        ${allpayments}
                                    </div>
                                </div>

                                <div class="content-box-large box-with-header" style="padding-left: 12px;padding-right: 12px;">
                                    <table>
                                        <th>${receiverCard}</th>
                                        <th>${payment_sum}</th>
                                        <th>${payment_date}</th>
                                        <th>${status}</th>

                                        <c:forEach items="${payments}" var="payment">
                                            <tr>
                                                <td>${payment.cardNumber}</td>
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
</html>