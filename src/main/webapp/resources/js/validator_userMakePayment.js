// Elements on userMakePayment.jsp page to check
let bfh_selectbox = $('.bfh-selectbox');
let isRepeatCommand = document.querySelector('#isRepeatCommand');
let accountId = document.querySelector("#accountId");
let numberByAccountId = document.querySelector("#numberByAccountId");
let accountNumber = document.querySelector("#accountNumber");
let cardNumber = document.querySelector("#cardNumber");
let amount = document.querySelector("#amount");
let appointment = document.querySelector("#appointment");
let submitBtn = document.querySelector("#submit");


/* It starts immediately after the page loads */
window.addEventListener("load", function () {
    correct_card_format(cardNumber);
});


/* Checks Account Id */
let validMsgAccountId = document.querySelector("#valid-msg-accountId"),
    errorMsgAccountId = document.querySelector("#error-msg-accountId");

let resetAccountId = function () {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let validAccountId = function () {
    validMsgAccountId.classList.remove("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidAccountId = function () {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.remove("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("error-input");
};

accountId.addEventListener('change', validationAccountId);

bfh_selectbox.on('hide.bfhselectbox', function () {
    validationAccountId();
});

function validationAccountId() {
    resetAccountId();

    if (isRepeatCommand.value === "0") {
        accountId.value = $(bfh_selectbox).val();

        if (accountId.value.trim() === null || accountId.value.trim() === "") {
            notValidAccountId();
            return;
        } else {
            validAccountId();
        }
    } else {
        isRepeatCommand.value = "0";
        $(bfh_selectbox).val(accountId.value);
        validAccountId();
    }

    numberByAccountId.value = $(bfh_selectbox).find('span')[0].innerHTML;
}


/* Checks Account Number */
let validMsgAccountNumber = document.querySelector("#valid-msg-accountNumber"),
    errorMsgAccountNumber = document.querySelector("#error-msg-accountNumber");

let resetAccountNumber = function () {
    validMsgAccountNumber.classList.add("invisible");
    errorMsgAccountNumber.classList.add("invisible");
    accountNumber.classList.remove("valid-input");
    accountNumber.classList.remove("error-input");
};

let validAccountNumber = function () {
    validMsgAccountNumber.classList.remove("invisible");
    errorMsgAccountNumber.classList.add("invisible");
    accountNumber.classList.add("valid-input");
    accountNumber.classList.remove("error-input");
};

let notValidAccountNumber = function () {
    validMsgAccountNumber.classList.add("invisible");
    errorMsgAccountNumber.classList.remove("invisible");
    accountNumber.classList.remove("valid-input");
    accountNumber.classList.add("error-input");
};

accountNumber.addEventListener('click', resetAccountNumber);
accountNumber.addEventListener('blur', validationAccountNumber);
accountNumber.addEventListener('keyup', validationAccountNumber);
accountNumber.addEventListener('change', validationAccountNumber);

function validationAccountNumber() {
    resetAccountNumber();

    if (accountNumber.value.trim() === "" || accountNumber.value.trim().length < 20) {
        notValidAccountNumber();
    } else if (accountNumber.value.match(/[^0-9]/g) != null) {
        notValidAccountNumber();
    } else {
        validAccountNumber();
    }
}


/* Checks Card Number */
let validMsgCardNumber = document.querySelector("#valid-msg-cardNumber"),
    errorMsgCardNumber = document.querySelector("#error-msg-cardNumber");

let resetCardNumber = function () {
    validMsgCardNumber.classList.add("invisible");
    errorMsgCardNumber.classList.add("invisible");
    cardNumber.classList.remove("valid-input");
    cardNumber.classList.remove("error-input");
};

let validCardNumber = function () {
    validMsgCardNumber.classList.remove("invisible");
    errorMsgCardNumber.classList.add("invisible");
    cardNumber.classList.add("valid-input");
    cardNumber.classList.remove("error-input");
};

let notValidCardNumber = function () {
    validMsgCardNumber.classList.add("invisible");
    errorMsgCardNumber.classList.remove("invisible");
    cardNumber.classList.remove("valid-input");
    cardNumber.classList.add("error-input");
};

cardNumber.addEventListener('click', resetCardNumber);
cardNumber.addEventListener('blur', validationCardNumber);
cardNumber.addEventListener('keyup', validationCardNumber);
cardNumber.addEventListener('change', validationCardNumber);

function validationCardNumber() {
    resetCardNumber();

    if (cardNumber.value.trim() === "" || cardNumber.value.trim().length < 19) {
        notValidCardNumber();
    } else if (cardNumber.value.match(/[^0-9 ]/g) != null) {
        notValidCardNumber();
    } else {
        validCardNumber();
    }
}


/* Checks Amount */
let validMsgAmount = document.querySelector("#valid-msg-amount"),
    errorMsgAmount = document.querySelector("#error-msg-amount");

let resetAmount = function () {
    validMsgAmount.classList.add("invisible");
    errorMsgAmount.classList.add("invisible");
    document.querySelector(".ui-spinner").classList.remove("valid-input");
    document.querySelector(".ui-spinner").classList.remove("error-input");
};

let validAmount = function () {
    validMsgAmount.classList.remove("invisible");
    errorMsgAmount.classList.add("invisible");
    document.querySelector(".ui-spinner").classList.add("valid-input");
    document.querySelector(".ui-spinner").classList.remove("error-input");
};

let notValidAmount = function () {
    validMsgAmount.classList.add("invisible");
    errorMsgAmount.classList.remove("invisible");
    document.querySelector(".ui-spinner").classList.remove("valid-input");
    document.querySelector(".ui-spinner").classList.add("error-input");
};

amount.addEventListener('click', resetAmount);
amount.addEventListener('blur', validationAmount);
amount.addEventListener('keyup', validationAmount);
amount.addEventListener('change', validationAmount);

function validationAmount() {
    resetAmount();

    if (amount.value.trim() === null || amount.value.trim() === "" || amount.value.trim() === "0" ||
        amount.value.trim() === "0.0" || amount.value.trim() === "0." || amount.value.trim() === "0.00") {
        notValidAmount();
    } else {
        validAmount();
        if (amount.value.match(/[.,]/g) != null) {
            if (amount.value.match(/[.,]/g).length > 1) {
                notValidAmount();
            }
        }
    }
}


/* Checks errors on the page and displays a modal window, if everything is in order */
submitBtn.addEventListener('click', function (event) {

    if (accountId.value.trim() === null || accountId.value.trim() === "" || accountId.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        return false;
    }

    if (on_off === 'off') {
        if (cardNumber.value.trim() === "" || cardNumber.value.trim().length < 19 || cardNumber.classList.contains("error-input")) {
            event.preventDefault();
            notValidCardNumber();
            return false;
        }
    } else if (on_off === 'on') {
        if (accountNumber.value.trim() === "" || accountNumber.value.trim().length < 20 || accountNumber.classList.contains("error-input")) {
            event.preventDefault();
            notValidAccountNumber();
            return false;
        }
    } else {
        event.preventDefault();
        notValidAccountNumber();
        notValidCardNumber();
        return false;
    }

    if (amount.value.trim() === "" || document.querySelector(".ui-spinner").classList.contains("error-input") ||
        amount.value.trim() === "0" || amount.value.trim() === "0.0" || amount.value.trim() === "0." || amount.value.trim() === "0.00") {
        event.preventDefault();
        notValidAmount();
        return false;
    }

    /*
        CN - card number
        AN - account number
    */
    if (on_off === 'off') {
        document.querySelector("#numberByAccountIdModal-CN").value = numberByAccountId.value;
        document.querySelector("#cardNumberModal-CN").value = cardNumber.value;
        document.querySelector("#amountModal-CN").value = amount.value;

        document.querySelector("#accountIdParam-CN").value = accountId.value;
        document.querySelector("#cardNumberParam-CN").value = cardNumber.value;
        document.querySelector("#amountParam-CN").value = amount.value;
        document.querySelector("#appointmentParam-CN").value = appointment.value;

        showModal_CN();
    } else if (on_off === 'on') {
        document.querySelector("#numberByAccountIdModal-AN").value = numberByAccountId.value;
        document.querySelector("#accountNumberModal-AN").value = accountNumber.value;
        document.querySelector("#amountModal-AN").value = amount.value;

        document.querySelector("#accountIdParam-AN").value = accountId.value;
        document.querySelector("#accountNumberParam-AN").value = accountNumber.value;
        document.querySelector("#amountParam-AN").value = amount.value;
        document.querySelector("#appointmentParam-AN").value = appointment.value;

        showModal_AN();
    }
});
