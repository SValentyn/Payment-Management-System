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
    <title><fmt:message key="user.make_payment.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_userMakePayment.css">
</head>
<body>

<!-- Modal window (when sending to an account) -->
<div id="paymentConfirmationModal-AN" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.make_payment.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="user.make_payment.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="numberByAccountIdModal-AN" class="modal-fixed-label">
                        <fmt:message key="user.make_payment.modalYourNumber"/>
                    </label>
                    <input id="numberByAccountIdModal-AN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="accountNumberModal-AN" class="modal-fixed-label">
                        <fmt:message key="user.make_payment.modalRecipientAccountNumber"/>
                    </label>
                    <input id="accountNumberModal-AN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="amountModal-AN" class="modal-fixed-label">
                        <fmt:message key="user.make_payment.modalAmountFunds"/>
                    </label>
                    <input id="amountModal-AN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" data-dismiss="modal">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="makePayment"/>
                        <input type="hidden" name="caseValue" value="on"/>
                        <input type="hidden" name="accountId" id="accountIdParam-AN"/>
                        <input type="hidden" name="accountNumber" id="accountNumberParam-AN"/>
                        <input type="hidden" name="amount" id="amountParam-AN"/>
                        <input type="hidden" name="appointment" id="appointmentParam-AN"/>
                        <button type="submit" class="btn btn-primary confirmButton" onfocus="this.blur();">
                            <fmt:message key="user.page.confirmButton"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal window (when sending to a bank card) -->
<div id="paymentConfirmationModal-CN" class="modal fade" tabindex="-1" role="dialog" onfocus="this.blur();">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <fmt:message key="user.make_payment.modalHeader"/>
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <fmt:message key="user.make_payment.modalBody"/>
                <br>
                <div style="display: flex; margin-top: 20px;">
                    <label for="numberByAccountIdModal-CN" class="modal-fixed-label">
                        <fmt:message key="user.make_payment.modalYourNumber"/>
                    </label>
                    <input id="numberByAccountIdModal-CN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="cardNumberModal-CN" class="modal-fixed-label">
                        <fmt:message key="user.make_payment.modalRecipientCardNumber"/>
                    </label>
                    <input id="cardNumberModal-CN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
                <div style="display: flex; margin-top: 10px;">
                    <label for="amountModal-CN" class="modal-fixed-label">
                        <fmt:message key="user.make_payment.modalAmountFunds"/>
                    </label>
                    <input id="amountModal-CN" class="form-control modal-form-control"
                           type="text" readonly="readonly"/>
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-default closeButton" data-dismiss="modal">
                        <fmt:message key="user.page.closeButton"/>
                    </button>
                    <div style="margin-left: 10px; border-left: 1px solid #e5e5e5;"></div>
                    <form action="/" method="POST" role="form">
                        <input type="hidden" name="command" value="makePayment">
                        <input type="hidden" name="caseValue" value="off"/>
                        <input type="hidden" name="accountId" id="accountIdParam-CN"/>
                        <input type="hidden" name="cardNumber" id="cardNumberParam-CN"/>
                        <input type="hidden" name="amount" id="amountParam-CN"/>
                        <input type="hidden" name="appointment" id="appointmentParam-CN"/>
                        <button type="submit" id="submitBtn-CN" class="btn btn-primary confirmButton"
                                onfocus="this.blur();">
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

    <!-- Alert unableGetData -->
    <c:if test="${response eq 'unableGetData'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertUnableGetData"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetPaymentId -->
    <c:if test="${response eq 'unableGetPaymentId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertUnableGetPaymentIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetPayment -->
    <c:if test="${response eq 'unableGetPayment'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/></strong>
                <fmt:message key="user.page.alertUnableGetPaymentError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert invalidData -->
    <c:if test="${response eq 'invalidData'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertInvalidDataError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert Success -->
    <c:if test="${response eq 'paymentCompletedSuccess'}">
        <div id="alert" class="alert alert-success fade show" role="alert">
            <p><strong><fmt:message key="user.page.success"/>!</strong>
                <fmt:message key="user.page.alertPaymentCompletedSuccess"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert recipientAccountNotExistError -->
    <c:if test="${response eq 'recipientAccountNotExistError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertRecipientAccountNotExistError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert paymentToYourAccountError -->
    <c:if test="${response eq 'paymentToYourAccountError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertPaymentToYourAccountError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert senderAccountBlockedError -->
    <c:if test="${response eq 'senderAccountBlockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertSenderAccountBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert recipientAccountBlockedError -->
    <c:if test="${response eq 'recipientAccountBlockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertRecipientAccountBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert recipientCardNotExistOrBlockedError -->
    <c:if test="${response eq 'recipientCardNotExistOrBlockedError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="user.page.failed"/>!</strong>
                <fmt:message key="user.page.alertRecipientCardNotExistOrBlockedError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert insufficientFundsError -->
    <c:if test="${response eq 'insufficientFundsError'}">
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
                <fmt:message key="user.make_payment.createNewPayment" var="formHeader"/>
                <fmt:message key="user.make_payment.fromAccount" var="fromAccount"/>
                <fmt:message key="user.make_payment.recipientsAccount" var="recipientsAccount"/>
                <fmt:message key="user.make_payment.recipientsCard" var="recipientsCard"/>
                <fmt:message key="user.make_payment.numberAccount" var="numberAccount"/>
                <fmt:message key="user.make_payment.numberCard" var="numberCard"/>
                <fmt:message key="user.make_payment.amountFunds" var="amountFunds"/>
                <fmt:message key="user.make_payment.appointment" var="appointment"/>
                <fmt:message key="user.make_payment.makePaymentButton" var="makePaymentButton"/>
                <fmt:message key="user.make_payment.accountIdError" var="accountIdError"/>
                <fmt:message key="user.make_payment.numberAccountError" var="numberAccountError"/>
                <fmt:message key="user.make_payment.numberCardError" var="numberCardError"/>
                <fmt:message key="user.make_payment.amountError" var="amountError"/>
                <fmt:message key="user.make_payment.tooltipAccountNumber" var="tooltipAccountNumber"/>
                <fmt:message key="user.make_payment.tooltipCardNumber" var="tooltipCardNumber"/>
                <fmt:message key="user.make_payment.tooltipAmountFunds" var="tooltipAmountFunds"/>
                <fmt:message key="registration.correct" var="correct"/>

                <div class="page-content container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 offset-xl-1 mr-auto">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4>
                                            ${formHeader}
                                        </h4>

                                        <form action="/" method="POST" role="form">
                                            <input type="hidden" name="command" value="makePayment"/>

                                            <!-- A variable that allows you to determine which command was invoked -->
                                            <input type="hidden" id="isRepeatCommand" name="isRepeatCommand"
                                                   value="${isRepeatCommandValue}"/>

                                            <!-- AccountId -->
                                            <input type="hidden" id="accountId" name="accountId"
                                                   value="${accountIdValue}"/>

                                            <!-- Number by AccountId -->
                                            <input type="hidden" id="numberByAccountId" name="numberByAccountId"
                                                   value="${numberByAccountIdValue}"/>

                                            <!-- Select AccountId -->
                                            <div>
                                                <label class="for-form-label">
                                                    ${fromAccount}:
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
                                                        ${correct}<img src="resources/images/correct.png" alt=""/>
                                                    </span>
                                                    <span id="error-msg-accountId" class="error-msg invisible">
                                                        ${accountIdError}
                                                    </span>
                                                </label>
                                            </div>

                                            <!-- Switch position -->
                                            <input type="hidden" id="case" name="case" value="${caseValue}"/>

                                            <!-- Switch -->
                                            <input id="switcher" class="toggle-btn" type="checkbox"/>
                                            <label for="switcher" class="toggle-btn-label"></label>

                                            <div class="form-row">

                                                <!-- Account Number -->
                                                <div class="col-md-6" style="margin-top: 10px;">
                                                    <span class="switcher-case-1">${recipientsAccount}</span>

                                                    <div style="margin-top: 4px;">
                                                        <input id="accountNumber" name="accountNumber" type="text"
                                                               class="form-control" style="margin-top: 0;"
                                                               data-toggle="tooltip-left"
                                                               data-title="${tooltipAccountNumber}"
                                                               maxlength="20" onkeypress="inputOnlyNumbers();"
                                                               placeholder="${numberAccount}*"
                                                               value="${accountNumberValue}"/>
                                                        <label for="accountNumber" class="default-label">
                                                            <span id="valid-msg-accountNumber"
                                                                  class="valid-msg invisible">
                                                                ${correct}
                                                                <img src="resources/images/correct.png" alt="">
                                                            </span>
                                                            <span id="error-msg-accountNumber"
                                                                  class="error-msg invisible">
                                                                ${numberAccountError}
                                                            </span>
                                                        </label>
                                                    </div>
                                                </div>

                                                <!-- Card Number -->
                                                <div class="col-md-6" style="margin-top: 10px;">
                                                    <span class="switcher-case-2">${recipientsCard}</span>

                                                    <div style="margin-top: 4px;">
                                                        <input id="cardNumber" name="cardNumber" type="text"
                                                               class="form-control" style="margin-top: 0;"
                                                               data-toggle="tooltip"
                                                               data-title="${tooltipCardNumber}"
                                                               maxlength="19"
                                                               oninput="this.value=inputCardNumber(this.value)"
                                                               placeholder="${numberCard}*"
                                                               value="${cardNumberValue}"/>
                                                        <label for="cardNumber" class="default-label">
                                                            <span id="valid-msg-cardNumber" class="valid-msg invisible">
                                                                ${correct}
                                                                <img src="resources/images/correct.png" alt="">
                                                            </span>
                                                            <span id="error-msg-cardNumber" class="error-msg invisible">
                                                                ${numberCardError}
                                                            </span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Amount Funds -->
                                            <div style="margin-top: 4px;">
                                                <label for="amount" class="for-form-label">
                                                    ${amountFunds}:
                                                </label>
                                                <input id="amount" name="amount" placeholder="0.00"
                                                       oninput="this.value=inputAmount(this.value);"
                                                       value="${amountValue}"/>
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
                                                    ${appointment}:
                                                </label>
                                                <div>
                                                    <textarea id="appointment" name="appointment" class="form-control"
                                                    >${appointmentValue}</textarea>
                                                    <div class="counter">
                                                        <span id="counter"></span>
                                                    </div>
                                                </div>
                                            </div>

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
<script src="resources/js/modalWindow_userMakePayment.js"></script>
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

    let on_off = 'off';
    let switcher_case_1 = document.querySelector(".switcher-case-1");
    let switcher_case_2 = document.querySelector(".switcher-case-2");
    let accountNumberInput = document.querySelector("#accountNumber");
    let cardNumberInput = document.querySelector("#cardNumber");

    /* It starts immediately after the page loads */
    window.addEventListener("load", function () {
        on_off = document.querySelector("#case").value;
        console.log("load: " + on_off);

        if (on_off === 'off') {
            off();
            resetAccountNumber();
        } else if (on_off === 'on') {
            on();
            resetCardNumber();
        }

        if (isRepeatCommand.value === "1") {
            validationAccountId();
            validationAmount();

            if (on_off === 'off') {
                validationCardNumber();
                $('.toggle-btn-label').css('transform', 'rotate(180deg)');
            } else if (on_off === 'on') {
                validationAccountNumber();
            }
        }
    });

    document.querySelector(".toggle-btn-label").addEventListener('click', function () {
        clear();

        if (on_off === 'off') {
            off();
        } else if (on_off === 'on') {
            on();
        }

        console.log(on_off);
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
</html>