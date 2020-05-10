// Elements on userAttachCard.jsp page to check
let selectbox_account_id = $('.selectbox-account-id');
let accountId = document.querySelector("#accountId");
let cardNumber = document.querySelector("#cardNumber");
let CVV = document.querySelector("#CVV");
let selectbox_month = $('.bfh-selectbox-month');
let selectbox_year = $('.bfh-selectbox-year');
let month = document.querySelector("#month");
let year = document.querySelector("#year");
let submitBtn = document.querySelector("#submit");


/* It starts immediately after the page loads */
window.addEventListener("load", () => {
    cardNumber.value = correct_card_format(cardNumber);
    $(selectbox_account_id).val(accountId.value);
    $(selectbox_month).val(month.value);
    $(selectbox_year).val(year.value);
});


/* AccountId validation */
let validMsgAccountId = document.querySelector("#valid-msg-accountId"),
    errorMsgAccountId = document.querySelector("#error-msg-accountId");

function resetAccountId() {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("error-input");
}

function validAccountId() {
    validMsgAccountId.classList.remove("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("error-input");
}

function notValidAccountId() {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.remove("invisible");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.add("error-input");
}

selectbox_account_id.on('hide.bfhselectbox', () => validationAccountId());

function validationAccountId() {
    resetAccountId();

    accountId.value = $(selectbox_account_id).val();
    if (accountId.value.trim() === null || accountId.value.trim() === "") {
        notValidAccountId();
    } else {
        validAccountId();
    }
}


/* Card number validation */
let validMsgCardNumber = document.querySelector("#valid-msg-cardNumber"),
    errorMsgCardNumber = document.querySelector("#error-msg-cardNumber");

function resetCardNumber() {
    validMsgCardNumber.classList.add("invisible");
    errorMsgCardNumber.classList.add("invisible");
    cardNumber.classList.remove("valid-input");
    cardNumber.classList.remove("error-input");
}

function validCardNumber() {
    validMsgCardNumber.classList.remove("invisible");
    errorMsgCardNumber.classList.add("invisible");
    cardNumber.classList.add("valid-input");
    cardNumber.classList.remove("error-input");
}

function notValidCardNumber() {
    validMsgCardNumber.classList.add("invisible");
    errorMsgCardNumber.classList.remove("invisible");
    cardNumber.classList.remove("valid-input");
    cardNumber.classList.add("error-input");
}

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


/* CVV validation */
let validMsgCVV = document.querySelector("#valid-msg-cvv"),
    errorMsgCVV = document.querySelector("#error-msg-cvv");

function resetCVV() {
    validMsgCVV.classList.add("invisible");
    errorMsgCVV.classList.add("invisible");
    CVV.classList.remove("valid-input");
    CVV.classList.remove("error-input");
}

function validCVV() {
    validMsgCVV.classList.remove("invisible");
    errorMsgCVV.classList.add("invisible");
    CVV.classList.add("valid-input");
    CVV.classList.remove("error-input");
}

function notValidCVV() {
    validMsgCVV.classList.add("invisible");
    errorMsgCVV.classList.remove("invisible");
    CVV.classList.remove("valid-input");
    CVV.classList.add("error-input");
}

CVV.addEventListener('click', resetCVV);
CVV.addEventListener('blur', validationCVV);
CVV.addEventListener('keyup', validationCVV);
CVV.addEventListener('change', validationCVV);

function validationCVV() {
    resetCVV();

    if (CVV.value.trim() === "" || CVV.value.trim().length < 3) {
        notValidCVV();
    } else if (CVV.value.match(/[^0-9]/g) != null) {
        notValidCVV();
    } else {
        validCVV();
    }
}


/* Month and year validation */
let validMsgValidity = document.querySelector("#valid-msg-validity"),
    errorMsgValidity = document.querySelector("#error-msg-validity"),
    errorMsgValidityExpired = document.querySelector("#error-msg-validityExpired"),
    errorMsgValidityExpiredError = document.querySelector("#error-msg-validityExpiredError");

function resetValidity() {
    errorMsgValidityExpired.classList.add("invisible");
    errorMsgValidityExpiredError.classList.add("invisible");
    validMsgValidity.classList.add("invisible");
    errorMsgValidity.classList.add("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("error-input");
}

function validValidity() {
    validMsgValidity.classList.remove("invisible");
    errorMsgValidity.classList.add("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("error-input");
}

function notValidValidity() {
    validMsgValidity.classList.add("invisible");
    errorMsgValidity.classList.remove("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("error-input");
}

function validityExpired() {
    errorMsgValidityExpired.classList.remove("invisible");
    errorMsgValidityExpiredError.classList.add("invisible");
    validMsgValidity.classList.add("invisible");
    errorMsgValidity.classList.add("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("error-input");
}

selectbox_month.on('hide.bfhselectbox', () => validationMonth());
selectbox_year.on('hide.bfhselectbox', () => validationYear());

selectbox_month.on('show.bfhselectbox', () => resetValidity());
selectbox_year.on('show.bfhselectbox', () => resetValidity());

function validationMonth() {
    resetValidity();

    month.value = $(selectbox_month).val();
    if (month.value.trim() === null || month.value.trim() === "" ||
        year.value.trim() === null || year.value.trim() === "") {
        notValidValidity();
    } else {
        if (validationDate(year.value, month.value)) {
            validValidity();
        } else {
            validityExpired();
        }
    }
}

function validationYear() {
    resetValidity();

    year.value = $(selectbox_year).val();
    if (month.value.trim() === null || month.value.trim() === "" ||
        year.value.trim() === null || year.value.trim() === "") {
        notValidValidity();
    } else {
        if (validationDate(year.value, month.value)) {
            validValidity();
        } else {
            validityExpired();
        }
    }
}

function validationDate(year, month) {
    let date = new Date();
    let current_month = date.getMonth();
    let current_year = date.getFullYear();

    if (year > current_year) {
        return true;
    } else if (year == current_year) {
        return month - 1 > current_month;
    } else {
        return false;
    }
}


/* Checks for errors on the page */
submitBtn.addEventListener('click', (event) => {

    validationAccountId();
    if (document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        return false;
    }

    validationCardNumber();
    if (cardNumber.classList.contains("error-input")) {
        event.preventDefault();
        notValidCardNumber();
        return false;
    }

    validationCVV();
    if (CVV.classList.contains("error-input")) {
        event.preventDefault();
        notValidCVV();
        return false;
    }

    validationMonth();
    validationYear();
    if (document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.contains("error-input") ||
        document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.contains("error-input")) {
        event.preventDefault();
        return false;
    }

});