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
    <title><fmt:message key="user.makepayment.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert Success -->
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertPaymentCompleted"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert paymentToYourAccountError -->
    <c:if test="${paymentToYourAccountError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertPaymentToYourAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert numberNotExistError -->
    <c:if test="${numberNotExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertAccountNumberNotExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountFromBlockedError -->
    <c:if test="${accountFromBlockedError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertAccountFromBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert receiverAccountBlockedError -->
    <c:if test="${receiverAccountBlockedError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertReceiverAccountBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert insufficientFundsError -->
    <c:if test="${insufficientFundsError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertInsufficientFundsError"/>
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

            <div class="page-content container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-wrapper">
                            <div class="box">
                                <div class="content-wrap">
                                    <fmt:message key="user.makepayment.createNewPayment" var="createNewPayment"/>
                                    <fmt:message key="user.makepayment.fromAccount" var="from"/>
                                    <fmt:message key="user.makepayment.toAccount" var="toCreditCard"/>
                                    <fmt:message key="user.makepayment.number" var="number"/>
                                    <fmt:message key="user.makepayment.amount" var="amount"/>
                                    <fmt:message key="user.makepayment.appointment" var="appointment"/>
                                    <fmt:message key="user.makepayment.makePaymentButton" var="makePaymentButton"/>
                                    <fmt:message key="user.makepayment.accountIdError" var="accountIdError"/>
                                    <fmt:message key="user.makepayment.numberError" var="numberError"/>
                                    <fmt:message key="user.makepayment.amountError" var="amountError"/>
                                    <fmt:message key="user.makepayment.tooltipAccountNumber" var="tooltipCardNumber"/>
                                    <fmt:message key="user.makepayment.tooltipAmountFunds" var="tooltipAmountFunds"/>
                                    <fmt:message key="registration.correct" var="correct"/>

                                    <h4>
                                        ${createNewPayment}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="makePayment">

                                        <!-- AccountId -->
                                        <select id="accountId" name="accountId" class="form-control"
                                                style="text-align: center; height: 40px; font-size: 18px;">
                                            <c:choose>
                                                <c:when test="${accountId == null}">
                                                    <option value="${0}">
                                                            ${from}
                                                    </option>
                                                </c:when>
                                                <c:when test="${accountId == 0}">
                                                    <option value="${0}">
                                                            ${from}
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${accountId}">
                                                            ${numberByAccountIdValue}
                                                    </option>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:forEach items="${accounts}" var="account">
                                                <option value="${account.accountId}">${account.number}</option>
                                            </c:forEach>
                                        </select>
                                        <label for="accountId" class="default-label">
                                            <span id="valid-msg-accountId" class="hide">${correct} ✓</span>
                                            <span id="error-msg-accountId" class="hide">${accountIdError}</span>
                                        </label>

                                        <!-- Account Number -->
                                        <div style="width: 100%; margin-top: 10px;">
                                            <label for="number" class="for-form-label">
                                                ${toCreditCard}
                                            </label>
                                            <input id="number" name="number" class="form-control" style="margin-top: 0;"
                                                   type="text" data-toggle="tooltip" data-title="${tooltipCardNumber}"
                                                   maxlength="20" onkeypress="onlyNumbers();"
                                                   placeholder="${number}*"
                                                   value="${numberValue}"/>
                                        </div>
                                        <label for="number" class="default-label">
                                            <span id="valid-msg-accountNumber" class="hide">${correct} ✓</span>
                                            <span id="error-msg-accountNumber" class="hide">${numberError}</span>
                                        </label>

                                        <!-- Amount Funds -->
                                        <input id="amount" name="amount" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipAmountFunds}"
                                               onkeypress="onlyNumbers();"
                                               placeholder="${amount}*"
                                               value="${amountValue}"/>
                                        <label for="amount" class="default-label">
                                            <span id="valid-msg-amount" class="hide">${correct} ✓</span>
                                            <span id="error-msg-amount" class="hide">${amountError}</span>
                                        </label>

                                        <!-- Appointment -->
                                        <div style="width: 100%; height:105px; position: relative; margin-top: 10px;">
                                            <label for="appointment" class="for-form-label">
                                                ${appointment}
                                            </label>
                                            <div style="width: 100%; position: absolute; ">
                                                <textarea id="appointment" name="appointment"
                                                          class="form-control">${appointmentValue}</textarea>
                                            </div>
                                            <div class="counter">
                                                <span id="counter"></span>
                                            </div>
                                        </div>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 30px 0 5px 0">
                                            <button id="submit" type="submit" class="btn btn-primary signup"
                                                    onfocus="this.blur()">
                                                ${makePaymentButton}
                                            </button>
                                        </div>
                                    </form>
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
<script src="resources/js/validator_userMakePayment.js"></script>
</body>
</html>