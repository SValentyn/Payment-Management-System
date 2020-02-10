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

    <!-- Alert receiverAccountOrCardBlockedError -->
    <c:if test="${receiverAccountOrCardBlockedError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertReceiverAccountOrCardBlockedError"/>
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
                                    <fmt:message key="user.makepayment.toCreditCard" var="toCreditCard"/>
                                    <fmt:message key="user.makepayment.number" var="number"/>
                                    <fmt:message key="user.makepayment.amount" var="amount"/>
                                    <fmt:message key="user.makepayment.appointment" var="appointment"/>
                                    <fmt:message key="user.makepayment.tooltipCardNumber" var="tooltipCardNumber"/>
                                    <fmt:message key="user.makepayment.tooltipAmountFunds" var="tooltipAmountFunds"/>

                                    <h4>
                                        ${createNewPayment}
                                    </h4>

                                    <form action="" role="form" method="POST">
                                        <input type="hidden" name="command" value="makePayment">

                                        <!-- AccountId -->
                                        <select name="accountId" class="form-control"
                                                style="text-align: center; height: 42px; margin-bottom: 2px; font-size: 18px;">
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
                                        <label class="create-error-label">
                                            <c:if test="${accountIdError}">
                                                <fmt:message key="user.makepayment.accountIdError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Number Card -->
                                        <div style="width: 100%;">
                                            <label for="number" class="label-for-form">
                                                ${toCreditCard}
                                            </label>
                                            <input id="number" name="number" class="form-control"
                                                   type="text" data-toggle="tooltip" data-title="${tooltipCardNumber}"
                                                   maxlength="16" onkeypress="onlyNumbers();"
                                                   placeholder="${number}*"
                                                   value="${numberValue}"
                                            />
                                        </div>
                                        <label for="number" class="create-error-label">
                                            <c:if test="${numberError}">
                                                <fmt:message key="user.makepayment.numberError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Amount Funds -->
                                        <input id="amount" name="amount" class="form-control"
                                               type="text" data-toggle="tooltip" data-title="${tooltipAmountFunds}"
                                               onkeypress="onlyNumbers();"
                                               placeholder="${amount}*"
                                               value="${amountValue}"
                                        />
                                        <label for="amount" class="create-error-label">
                                            <c:if test="${amountError}">
                                                <fmt:message key="user.makepayment.amountError"/>
                                            </c:if>
                                        </label>&nbsp;

                                        <!-- Appointment -->
                                        <div style="width: 100%; height:105px; position: relative;">
                                            <label for="appointment" class="label-for-form">
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
                                            <button type="submit" class="btn btn-primary signup" onfocus="this.blur()">
                                                <fmt:message key="user.makepayment.makePayment"/>
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
</body>
</html>