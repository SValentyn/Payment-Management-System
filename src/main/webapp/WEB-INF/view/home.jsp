<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<html>
<head>
    <title><fmt:message key="home.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/styles.css" rel="stylesheet">
</head>
<body>
<jsp:include page="template/header.jsp"/>

<div class="page-content">
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-2">
            <jsp:include page="template/sidebar.jsp"/>
        </div>
        <div class="col-md-10" style="padding-left: 30px;">
            <c:choose>
                <c:when test="${showAccounts}">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12">
                                <fmt:message key="home.allaccounts" var="allaccounts"/>
                                <fmt:message key="home.account.number" var="number"/>
                                <fmt:message key="home.account.balance" var="balance"/>
                                <fmt:message key="home.account.status" var="status"/>
                                <fmt:message key="home.account.action" var="action"/>
                                <fmt:message key="home.account.status.active" var="statusActive"/>
                                <fmt:message key="home.account.status.blocked" var="statusBlocked"/>
                                <fmt:message key="home.account.button.block" var="block"/>
                                <fmt:message key="home.account.button.showInfo" var="showInfo"/>

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

                                            <c:forEach items="${accounts}" var="account">
                                                <tr>
                                                    <td>${account.number}</td>
                                                    <td>${account.balance}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${account.isBlocked}">
                                                                ${statusBlocked}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${statusActive}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:if test="${!account.isBlocked}">
                                                            <a href="?command=blockAccount&accountId=${account.accountId}">${block}</a>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a href="?command=showInfo&accountId=${account.accountId}">${showInfo}</a>
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
                                <fmt:message key="home.allcards" var="allcards"/>
                                <fmt:message key="home.card.cvv" var="cvv"/>
                                <fmt:message key="home.card.date" var="date"/>

                                <div class="content-box-header">
                                    <div class="panel-title">
                                            ${allcards}
                                    </div>
                                </div>

                                <div class="content-box-large box-with-header">
                                    <table>
                                        <th>${number}</th>
                                        <th>${cvv}</th>
                                        <th>${date}</th>
                                        <th>${status}</th>
                                        <th>${action}</th>

                                        <c:forEach items="${cards}" var="card">
                                            <tr>
                                                <td>${card.number}</td>
                                                <td>${card.CVV}</td>
                                                <td>${card.validity}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${card.isActive}">
                                                            ${statusActive}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${statusBlocked}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${card.isActive}">
                                                        <a href="?command=blockCard&cardNumber=${card.number}">${block}</a>
                                                    </c:if>
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
                                <fmt:message key="home.allpayments" var="allpayments"/>
                                <fmt:message key="home.payments.receiverCard" var="receiverCard"/>
                                <fmt:message key="home.payments.sum" var="payment_sum"/>
                                <fmt:message key="home.payments.date" var="payment_date"/>
                                <fmt:message key="home.payments.appointment" var="payment_appointment"/>
                                <fmt:message key="home.payments.success" var="payment_success"/>
                                <fmt:message key="home.payments.error" var="payment_error"/>
                                <fmt:message key="home.payments.repeat" var="payment_repeat"/>

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
                                        <th></th>

                                        <c:forEach items="${payments}" var="payment">
                                            <tr>
                                                <td>${payment.cardNumber}</td>
                                                <td>${payment.sum}</td>
                                                <td>${payment.date}</td>
                                                <td>${payment.appointment}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${payment.condition}">
                                                            ${payment_success}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${payment_error}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="?command=repeatPayment&paymentId=${payment.paymentId}">${payment_repeat}</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <span class="showOrCreate-label">
                        <label>
                            <b>
                                <a id="linkOnShowAccounts" href="?command=showAccounts">
                                    <fmt:message key="sidebar.showAccounts"/></a>
                                OR
                                <a href="?command=createAccount">
                                    <fmt:message key="sidebar.createAccount"/></a>
                            </b>
                        </label>
                    </span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>
</body>
</html>