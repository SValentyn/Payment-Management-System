// Elements on userAttachCard.jsp page to check
let accountId = document.querySelector("#accountId");
let selectbox_account_id = $('.selectbox-account-id');
let number = document.querySelector("#cardNumber");
let CVV = document.querySelector("#CVV");
let month = document.querySelector("#month");
let year = document.querySelector("#year");
let selectbox_month = $('.bfh-selectbox-month');
let selectbox_year = $('.bfh-selectbox-year');
let submitBtn = document.querySelector("#submit");


/* Checks Account Id */
let validMsgAccountId = document.querySelector("#valid-msg-accountId"),
    errorMsgAccountId = document.querySelector("#error-msg-accountId");

let resetAccountId = function () {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("error-input");
};

let validAccountId = function () {
    validMsgAccountId.classList.remove("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("error-input");
    accountId.classList.add("valid-input");
    accountId.classList.remove("error-input");
};

let notValidAccountId = function () {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.remove("invisible");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.add("error-input");
};

accountId.addEventListener('click', resetAccountId);
accountId.addEventListener('blur', validationAccountId);

selectbox_account_id.on('hide.bfhselectbox', function () {
    validationAccountId();
});

function validationAccountId() {
    resetAccountId();

    accountId.value = $(selectbox_account_id).val();
    if (accountId.value.trim() === null || accountId.value.trim() === "") {
        notValidAccountId();
    } else {
        validAccountId();
    }
}


/* Checks cardNumber */
let validMsgNumber = document.querySelector("#valid-msg-cardNumber"),
    errorMsgNumber = document.querySelector("#error-msg-cardNumber");

let resetNumber = function () {
    validMsgNumber.classList.add("invisible");
    errorMsgNumber.classList.add("invisible");
    number.classList.remove("valid-input");
    number.classList.remove("error-input");
};

let validNumber = function () {
    validMsgNumber.classList.remove("invisible");
    errorMsgNumber.classList.add("invisible");
    number.classList.add("valid-input");
    number.classList.remove("error-input");
};

let notValidNumber = function () {
    validMsgNumber.classList.add("invisible");
    errorMsgNumber.classList.remove("invisible");
    number.classList.remove("valid-input");
    number.classList.add("error-input");
};

number.addEventListener('click', resetNumber);
number.addEventListener('blur', validationNumber);
number.addEventListener('keyup', validationNumber);
number.addEventListener('change', validationNumber);

function validationNumber() {
    resetNumber();

    if (number.value.trim() === "" || number.value.trim().length < 19) {
        notValidNumber();
    } else if (number.value.match(/[^0-9 ]/g) != null) {
        notValidNumber();
    } else {
        validNumber();
    }
}


/* Checks CVV */
let validMsgCVV = document.querySelector("#valid-msg-cvv"),
    errorMsgCVV = document.querySelector("#error-msg-cvv");

let resetCVV = function () {
    validMsgCVV.classList.add("invisible");
    errorMsgCVV.classList.add("invisible");
    CVV.classList.remove("valid-input");
    CVV.classList.remove("error-input");
};

let validCVV = function () {
    validMsgCVV.classList.remove("invisible");
    errorMsgCVV.classList.add("invisible");
    CVV.classList.add("valid-input");
    CVV.classList.remove("error-input");
};

let notValidCVV = function () {
    validMsgCVV.classList.add("invisible");
    errorMsgCVV.classList.remove("invisible");
    CVV.classList.remove("valid-input");
    CVV.classList.add("error-input");
};

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


/* Checks month and year */
let validMsgValidity = document.querySelector("#valid-msg-validity"),
    errorMsgValidity = document.querySelector("#error-msg-validity");

let resetValidity = function () {
    document.querySelector("#validityExpiredError").classList.add("invisible");
    validMsgValidity.classList.add("invisible");
    errorMsgValidity.classList.add("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("error-input");
};

let validValidity = function () {
    validMsgValidity.classList.remove("invisible");
    errorMsgValidity.classList.add("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidValidity = function () {
    validMsgValidity.classList.add("invisible");
    errorMsgValidity.classList.remove("invisible");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("error-input");
};

selectbox_month.on('show.bfhselectbox', function () {
    resetValidity();
});

selectbox_year.on('show.bfhselectbox', function () {
    resetValidity();
});

selectbox_month.on('hide.bfhselectbox', function () {
    validationMonth();
});

selectbox_year.on('hide.bfhselectbox', function () {
    validationYear();
});

function validationMonth() {
    resetValidity();

    month.value = $(selectbox_month).val();
    if (month.value.trim() === null || month.value.trim() === "" ||
        year.value.trim() === null || year.value.trim() === "") {
        notValidValidity();
    } else {
        validValidity();
    }
}

function validationYear() {
    resetValidity();

    year.value = $(selectbox_year).val();
    if (month.value.trim() === null || month.value.trim() === "" ||
        year.value.trim() === null || year.value.trim() === "") {
        notValidValidity();
    } else {
        validValidity();
    }
}


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (accountId.value.trim() === null || accountId.value.trim() === "" || accountId.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        return false;
    }

    if (number.value.trim() === "" || number.value.trim().length < 19 || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        return false;
    }

    if (CVV.value.trim() === "" || CVV.value.trim().length < 3 || CVV.classList.contains("error-input")) {
        event.preventDefault();
        notValidCVV();
        return false;
    }

    if (month.value.trim() === null || month.value.trim() === "" || month.classList.contains("error-input") ||
        year.value.trim() === null || year.value.trim() === "" || year.classList.contains("error-input")) {
        event.preventDefault();
        notValidValidity();
        return false;
    }

    number.value = number.value.replace(/\s+/g, "");

});