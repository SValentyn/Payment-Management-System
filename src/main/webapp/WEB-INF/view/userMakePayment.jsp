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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
        .ui-spinner {
            width: 100%;
            height: 40px;
            padding: 6px 12px;
            font-size: 15px;
            color: #555;
            border-radius: 4px !important;
            background-color: #fff;
        }

        .ui-spinner-input {
            width: 100%;
            padding: 4px 0 6px 0;
            margin: 0;
            line-height: normal;
        }

        .ui-spinner-input:focus {
            outline: none;
        }
    </style>
</head>
<body>

<!-- Modal window -->
<div id="smallModal" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    <fmt:message key="user.makepayment.modalHeader"/>
                </h4>
            </div>
            <div class="modal-body">
                <fmt:message key="user.makepayment.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="numberByAccountIdModalText" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalYourNumber"/>
                    </label>
                    <input id="numberByAccountIdModalText" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="numberModalText" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalRecipientNumber"/>
                    </label>
                    <input id="numberModalText" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="amountModalText" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalAmountFunds"/>
                    </label>
                    <input id="amountModalText" class="form-control modal-form-control"
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
                        <input type="hidden" name="command" value="makePayment">
                        <input type="hidden" name="accountId" id="accountIdModal"/>
                        <input type="hidden" name="number" id="numberModal"/>
                        <input type="hidden" name="amount" id="amountModal"/>
                        <input type="hidden" name="appointment" id="appointmentModal"/>

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

                                    <form action="/" role="form" method="POST">
                                        <input type="hidden" name="command" value="makePayment">

                                        <!-- AccountId -->
                                        <input id="accountId" name="accountId" type="hidden" value="${accountIdValue}"/>

                                        <!-- Number by AccountId -->
                                        <input id="numberByAccountId" name="numberByAccountId" type="hidden"
                                               value="${numberByAccountIdValue}"/>

                                        <!-- Select AccountId -->
                                        <div>
                                            <label for="number" class="for-form-label">
                                                ${from}
                                            </label>
                                            <div>
                                                <div class="bfh-selectbox">
                                                    <c:choose>
                                                        <c:when test="${accountIdValue == null}">
                                                            <div data-value=""></div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div data-value="${accountIdValue}">${numberByAccountIdValue}</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:forEach items="${accounts}" var="account">
                                                        <div data-value="${account.accountId}">${account.number}</div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <label for="accountId" class="default-label">
                                                <span id="valid-msg-accountId" class="hide">${correct} ✓</span>
                                                <span id="error-msg-accountId" class="hide">${accountIdError}</span>
                                            </label>
                                        </div>

                                        <!-- Account Number -->
                                        <div style="width: 100%; margin-top: 6px;">
                                            <div>
                                                <label for="number" class="for-form-label">
                                                    ${toCreditCard}
                                                </label>
                                                <input id="number" name="number" class="form-control"
                                                       style="margin-top: 0;"
                                                       type="text" data-toggle="tooltip"
                                                       data-title="${tooltipCardNumber}"
                                                       maxlength="20" onkeypress="onlyNumbers();"
                                                       placeholder="${number}*"
                                                       value="${numberValue}"/>
                                            </div>
                                            <label for="number" class="default-label">
                                                <span id="valid-msg-accountNumber" class="hide">${correct} ✓</span>
                                                <span id="error-msg-accountNumber" class="hide">${numberError}</span>
                                            </label>
                                        </div>

                                        <!-- Amount Funds -->
                                        <div style="margin-top: 4px;">
                                            <div>
                                                <label for="amount" class="for-form-label">
                                                    ${amount}
                                                </label>
                                                <input id="amount" name="amount" placeholder="0.00"
                                                       oninput="this.value=inputAmount(this.value)"
                                                       value="${amountValue}"/>
                                            </div>
                                            <label for="amount" class="default-label">
                                                <span id="valid-msg-amount" class="hide">${correct} ✓</span>
                                                <span id="error-msg-amount" class="hide">${amountError}</span>
                                            </label>
                                        </div>

                                        <!-- Appointment -->
                                        <div style="width: 100%; height:105px; position: relative; margin-top: 10px;">
                                            <label for="appointment" class="for-form-label">
                                                ${appointment}
                                            </label>
                                            <div style="width: 100%; position: absolute; display: flex;">
                                                <textarea id="appointment" name="appointment"
                                                          class="form-control"
                                                >${appointmentValue}</textarea>
                                                <div class="counter">
                                                    <span id="counter"></span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Required for the script to work correctly -->
                                        <input id="isRepeatCommand" name="isRepeatCommand" type="hidden"
                                               value="${isRepeatCommandValue}"/>

                                        <!-- Submit -->
                                        <div class="action" style="padding: 30px 0 5px 0">
                                            <button id="submit" type="button" class="btn btn-primary signup">
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
</body>
<script src="resources/js/validator_userMakePayment.js"></script>
<script>
    $(function () {
        $('#amount').spinner({
            culture: "en-US",
            start: 0.00,
            min: 0.00,
            step: 1.00,
            numberFormat: "n"
        });
    });
</script>
</html>