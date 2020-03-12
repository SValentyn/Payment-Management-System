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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
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

<!-- Modal window (when sending to an account) -->
<div id="smallModal-AN" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.makepayment.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="user.makepayment.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="numberByAccountIdModal-AN" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalYourNumber"/>
                    </label>
                    <input id="numberByAccountIdModal-AN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="accountNumberModal-AN" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalRecipientAccountNumber"/>
                    </label>
                    <input id="accountNumberModal-AN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="amountModal-AN" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalAmountFunds"/>
                    </label>
                    <input id="amountModal-AN" class="form-control modal-form-control"
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
                        <input type="hidden" name="accountId" id="accountIdParam-AN"/>
                        <input type="hidden" name="accountNumber" id="accountNumberParam-AN"/>
                        <input type="hidden" name="amount" id="amountParam-AN"/>
                        <input type="hidden" name="appointment" id="appointmentParam-AN"/>

                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur()">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal window (when sending to a bank card) -->
<div id="smallModal-CN" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur()">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.makepayment.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="user.makepayment.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="numberByAccountIdModal-CN" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalYourNumber"/>
                    </label>
                    <input id="numberByAccountIdModal-CN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="cardNumberModal-CN" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalRecipientCardNumber"/>
                    </label>
                    <input id="cardNumberModal-CN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="amountModal-CN" class="modal-fixed-label">
                        <fmt:message key="user.makepayment.modalAmountFunds"/>
                    </label>
                    <input id="amountModal-CN" class="form-control modal-form-control"
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
                        <input type="hidden" name="accountId" id="accountIdParam-CN"/>
                        <input type="hidden" name="cardNumber" id="cardNumberParam-CN"/>
                        <input type="hidden" name="amount" id="amountParam-CN"/>
                        <input type="hidden" name="appointment" id="appointmentParam-CN"/>

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
        <div id="alert" class="alert alert-success fade show" role="alert">
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
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertPaymentToYourAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert accountNumberNotExistError -->
    <c:if test="${accountNumberNotExistError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
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
        <div id="alert" class="alert alert-danger fade show" role="alert">
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
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertReceiverAccountBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert cardNotExistOrBlockedError -->
    <c:if test="${cardNotExistOrBlockedError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertCardNotExistOrBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert insufficientFundsError -->
    <c:if test="${insufficientFundsError == true}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
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
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <div class="page-content container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-xl-6 offset-xl-2 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">
                                        <fmt:message key="user.makepayment.createNewPayment" var="createNewPayment"/>
                                        <fmt:message key="user.makepayment.fromAccount" var="from"/>
                                        <fmt:message key="user.makepayment.recipientsAccount" var="recipientsAccount"/>
                                        <fmt:message key="user.makepayment.recipientsCard" var="recipientsCard"/>
                                        <fmt:message key="user.makepayment.numberAccount" var="numberAccount"/>
                                        <fmt:message key="user.makepayment.numberCard" var="numberCard"/>
                                        <fmt:message key="user.makepayment.amount" var="amount"/>
                                        <fmt:message key="user.makepayment.appointment" var="appointment"/>
                                        <fmt:message key="user.makepayment.makePaymentButton" var="makePaymentButton"/>
                                        <fmt:message key="user.makepayment.accountIdError" var="accountIdError"/>
                                        <fmt:message key="user.makepayment.numberAccountError"
                                                     var="numberAccountError"/>
                                        <fmt:message key="user.makepayment.numberCardError" var="numberCardError"/>
                                        <fmt:message key="user.makepayment.amountError" var="amountError"/>
                                        <fmt:message key="user.makepayment.tooltipAccountNumber"
                                                     var="tooltipAccountNumber"/>
                                        <fmt:message key="user.makepayment.tooltipCardNumber" var="tooltipCardNumber"/>
                                        <fmt:message key="user.makepayment.tooltipAmountFunds"
                                                     var="tooltipAmountFunds"/>
                                        <fmt:message key="registration.correct" var="correct"/>

                                        <h4>
                                            ${createNewPayment}
                                        </h4>

                                        <form action="/" role="form" method="POST">
                                            <input type="hidden" name="command" value="makePayment">

                                            <!-- AccountId -->
                                            <input id="accountId" name="accountId" type="hidden"
                                                   value="${accountIdValue}"/>

                                            <!-- Number by AccountId -->
                                            <input id="numberByAccountId" name="numberByAccountId" type="hidden"
                                                   value="${numberByAccountIdValue}"/>

                                            <!-- Select AccountId -->
                                            <div>
                                                <label class="for-form-label">
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
                                                    <span id="valid-msg-accountId" class="valid-msg invisible">
                                                            ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-accountId" class="error-msg invisible">
                                                        ${accountIdError}
                                                    </span>
                                                </label>
                                            </div>

                                            <input id="switcher" class="toggle-btn" type="checkbox"/>
                                            <label for="switcher" class="toggle-btn-label"></label>
                                            <div class="form-row">
                                                <div class="col-md-6" style="margin-top: 10px;">
                                                    <span class="switcher-case-1">${recipientsAccount}</span>
                                                </div>
                                                <div class="col-md-6" style="margin-top: 10px;">
                                                    <span class="switcher-case-2">${recipientsCard}</span>
                                                </div>
                                            </div>

                                            <!-- Switch position -->
                                            <input id="case" name="case" type="hidden" value="${caseValue}"/>

                                            <div class="form-row">

                                                <!-- Account Number -->
                                                <div class="col-md-6" style="margin-top: 4px;">
                                                    <div>
                                                        <input id="accountNumber" name="accountNumber"
                                                               class="form-control" style="margin-top: 0;" type="text"
                                                               data-toggle="tooltip-left"
                                                               data-title="${tooltipAccountNumber}"
                                                               maxlength="20" onkeypress="onlyNumbers();"
                                                               placeholder="${numberAccount}*"
                                                               value="${accountNumberValue}"/>
                                                    </div>
                                                    <label for="accountNumber" class="default-label">
                                                        <span id="valid-msg-accountNumber" class="valid-msg invisible">
                                                            ${correct}<img src="resources/images/correct.png" alt="">
                                                        </span>
                                                        <span id="error-msg-accountNumber" class="error-msg invisible">
                                                            ${numberAccountError}
                                                        </span>
                                                    </label>
                                                </div>

                                                <!-- Card Number -->
                                                <div class="col-md-6" style="margin-top: 4px;">
                                                    <div>
                                                        <input id="cardNumber" name="cardNumber"
                                                               class="form-control" style="margin-top: 0;" type="text"
                                                               data-toggle="tooltip"
                                                               data-title="${tooltipCardNumber}"
                                                               maxlength="16" onkeypress="onlyNumbers();"
                                                               placeholder="${numberCard}*"
                                                               value="${cardNumberValue}"/>
                                                    </div>
                                                    <label for="cardNumber" class="default-label">
                                                        <span id="valid-msg-cardNumber" class="valid-msg invisible">
                                                            ${correct}<img src="resources/images/correct.png" alt="">
                                                        </span>
                                                        <span id="error-msg-cardNumber" class="error-msg invisible">
                                                            ${numberCardError}
                                                        </span>
                                                    </label>
                                                </div>
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
                                                    <span id="valid-msg-amount" class="valid-msg invisible">
                                                            ${correct}<img src="resources/images/correct.png" alt="">
                                                    </span>
                                                    <span id="error-msg-amount" class="error-msg invisible">
                                                        ${amountError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Appointment -->
                                            <div class="textarea-parent">
                                                <label for="appointment" class="for-form-label">
                                                    ${appointment}
                                                </label>
                                                <div>
                                                    <textarea id="appointment" name="appointment" class="form-control"
                                                    >${appointmentValue}</textarea>
                                                    <div class="counter">
                                                        <span id="counter"></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- A variable that allows you to determine which command was invoked -->
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
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
<script src="resources/js/validator_userMakePayment.js"></script>
<script>
    let on_off = 'off';
    let switcher_case_1 = document.querySelector(".switcher-case-1");
    let switcher_case_2 = document.querySelector(".switcher-case-2");
    let accountNumberInput = document.querySelector("#accountNumber");
    let cardNumberInput = document.querySelector("#cardNumber");

    window.onload = function () {
        on_off = document.querySelector("#case").value;
        console.log(on_off);

        if (on_off === 'off') {
            off();
            resetAccountNumber();
        } else if (on_off === 'on') {
            on();
            resetCardNumber();
        }
    };

    document.querySelector(".toggle-btn-label").addEventListener('click', function () {
        clear();

        if (on_off === 'off') {
            off();
        } else if (on_off === 'on') {
            on();
        }
    });

    function clear() {
        switcher_case_1.classList.remove("on");
        switcher_case_1.classList.remove("off");
        switcher_case_2.classList.remove("on");
        switcher_case_2.classList.remove("off");
        accountNumberInput.disabled = false;
        cardNumberInput.disabled = false;
    }

    function off() {
        switcher_case_1.classList.add("on");
        switcher_case_2.classList.add("off");
        cardNumberInput.disabled = true;
        resetCardNumber();
        validationAccountNumber();
        on_off = 'on';
    }

    function on() {
        switcher_case_1.classList.add("off");
        switcher_case_2.classList.add("on");
        accountNumberInput.disabled = true;
        resetAccountNumber();
        validationCardNumber();
        on_off = 'off';
    }
</script>
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

    document.addEventListener('keyup', function (e) {
        if (e.keyCode === 27) {
            $('#smallModal-AN').modal('hide');
            $('#smallModal-CN').modal('hide');
        }
    });
</script>
</html>