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
    <div class="row">
        <div class="col-md-2">
            <jsp:include page="template/sidebar.jsp"/>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-6">
                    <a href="?command=showAccounts"><fmt:message key="home.showAccounts"/></a>
                    <c:if test="${showAccouts}">
                        <div class="content-box-large">
                            <div class="panel-heading">
                                <div class="panel-title">
                                    <fmt:message key="home.allaccounts"/>
                                </div>
                            </div>
                            <fmt:message key="home.account.number" var="number"/>
                            <fmt:message key="home.account.status" var="status"/>
                            <fmt:message key="home.account.status.active" var="statusActive"/>
                            <fmt:message key="home.account.status.blocked" var="statusBlocked"/>
                            <fmt:message key="home.account.button.block" var="block"/>
                            <fmt:message key="home.account.button.showInfo" var="showInfo"/>

                            <div class="panel-body">
                                <table border="1" width="100%" cellpadding="4" cellpacing="3">
                                    <th>${number}</th>
                                    <th><fmt:message key="home.account.balance"/></th>
                                    <th>${status}</th>
                                    <th><fmt:message key="userCards.action"/></th>
                                    <th></th>

                                    <c:forEach items="${accounts}" var="account">
                                        <tr align="center">
                                            <td>${account.number}</td>
                                            <td>${account.balance}</td>
                                            <td><c:if test="${!account.isBlocked}">${statusActive}</c:if>
                                                <c:if test="${account.isBlocked}">${statusBlocked}</c:if></td>
                                            <td>
                                                <c:if test="${!account.isBlocked}">
                                                    <a href="?command=blockaccount&accountId=${account.accountId}">${block}</a>
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="?command=showinfo&accountId=${account.accountId}">${showInfo}</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>

                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12">
                            <c:if test="${showAccouts}">

                                <div class="content-box-header">
                                    <div class="panel-title">
                                        <fmt:message key="home.cards"/>
                                    </div>
                                </div>

                                <div class="content-box-large box-with-header">
                                    <table border="1" width="100%" cellpadding="4" cellpacing="3">
                                        <th>${number}</th>
                                        <th><fmt:message key="home.card.cvv"/></th>
                                        <th><fmt:message key="home.card.date"/></th>
                                        <th>${status}</th>
                                        <th><fmt:message key="userCards.action"/></th>

                                        <c:forEach items="${cards}" var="card">
                                            <tr align="center">
                                                <td>${card.number}</td>
                                                <td>${card.CVV}</td>
                                                <td>${card.validity}</td>
                                                <td>
                                                    <c:if test="${card.isActive}">${statusActive}</c:if>
                                                    <c:if test="${!card.isActive}">${statusBlocked}</c:if>
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
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 panel-warning">
                    <c:if test="${showAccouts}">

                        <div class="content-box-header panel-heading">
                            <div class="panel-title ">
                                <fmt:message key="home.payments"/>
                            </div>
                        </div>

                        <div class="content-box-large box-with-header">
                            <table border="1" width="100%" cellpadding="4" cellpacing="3">
                                <th><fmt:message key="home.payments.receiverCard"/></th>
                                <th><fmt:message key="home.payments.appointment"/></th>
                                <th><fmt:message key="home.payments.date"/></th>
                                <th><fmt:message key="home.payments.sum"/></th>
                                <th>${status}</th>
                                <th></th>

                                <c:forEach items="${payments}" var="payment">
                                    <tr align="center">
                                        <td>${payment.cardNumber}</td>
                                        <td>${payment.appointment}</td>
                                        <td>${payment.date}</td>
                                        <td>${payment.sum }</td>
                                        <td>
                                            <c:if test="${payment.condition}">
                                                <fmt:message key="home.payments.success"/>
                                            </c:if>
                                            <c:if test="${!payment.condition}">
                                                <fmt:message key="home.payments.error"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="?command=repeatPayment&paymentId=${payment.paymentId}">
                                                <fmt:message key="home.payments.repeat"/>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"/>
</body>
</html>