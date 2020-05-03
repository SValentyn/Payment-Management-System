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

    <!-- Alert noPayments -->
    <c:if test="${noPayments == true}">
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

    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <fmt:message key="user.page.myAccounts" var="myAccounts"/>
                <fmt:message key="user.page.myPayments" var="myPayments"/>
                <fmt:message key="user.payment.allpayments" var="allpayments"/>
                <fmt:message key="user.payments.recipient'sAccount" var="receiverCard"/>
                <fmt:message key="user.payments.sum" var="payment_sum"/>
                <fmt:message key="user.payments.date" var="payment_date"/>
                <fmt:message key="user.payments.appointment" var="payment_appointment"/>
                <fmt:message key="user.payments.success" var="payment_success"/>
                <fmt:message key="user.payments.error" var="payment_error"/>
                <fmt:message key="user.payments.repeat" var="repeat"/>
                <fmt:message key="user.payments.repeatPayment" var="payment_repeat"/>

                <div class="card shadow-none">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs justify-content-lg-center" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link nav-link-hover" role="tab" data-toggle="tab" aria-selected="false"
                                   onclick="document.getElementById('form-showAccounts').submit(); return false;">
                                    <img src="resources/images/show-accounts.png"
                                         class="icon-sidebar" alt=""/>
                                    ${myAccounts}
                                </a>
                            </li>
                            <li class="nav-item-active">
                                <a class="nav-link" role="tab" data-toggle="tab" aria-selected="true"
                                   onclick="document.getElementById('form-showPayments').submit(); return false;">
                                    <img src="resources/images/balance.png"
                                         class="icon-sidebar" alt=""/>
                                    ${myPayments}
                                </a>
                            </li>
                        </ul>
                    </div>

                    <form action="" method="GET" role="form" id="form-showAccounts">
                        <input type="hidden" name="command" value="showAccounts"/>
                    </form>
                    <form action="" method="GET" role="form" id="form-showPayments">
                        <input type="hidden" name="command" value="showPayments"/>
                    </form>

                    <div class="card-body">
                        <div class="col-md-12 panel-warning">
                            <div class="sidebar-header panel-heading">
                                <div class="panel-title ">
                                    ${allpayments}
                                </div>
                            </div>

                            <div class="sidebar-large box-with-header">
                                ${receiverCard}
                                ${payment_sum}
                                ${payment_date}
                                ${payment_appointment}
                                ${payment_repeat}

                                <c:forEach items="${payments}" var="payment">
                                    ${payment.recipientNumber}
                                    ${payment.sum}
                                    ${payment.date}
                                    ${payment.appointment}
                                    <c:choose>
                                        <c:when test="${payment.condition}">
                                            ${payment_success}
                                        </c:when>
                                        <c:otherwise>
                                            ${payment_error}
                                        </c:otherwise>
                                    </c:choose>

                                    <a href="?command=repeatPayment&paymentId=${payment.paymentId}">
                                            ${repeat}
                                    </a>
                                </c:forEach>
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