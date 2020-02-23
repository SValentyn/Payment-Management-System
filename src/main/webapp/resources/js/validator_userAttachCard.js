// Elements on userAttachCard.jsp page to check
let accountId = document.querySelector("#accountId");
let selectbox_account_id = $('.selectbox-account-id');
let number = document.querySelector("#number");
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
    validMsgAccountId.classList.add("hide");
    errorMsgAccountId.classList.add("hide");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("error-input");
};

let validAccountId = function () {
    validMsgAccountId.classList.remove("hide");
    errorMsgAccountId.classList.add("hide");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("error-input");
    accountId.classList.add("valid-input");
    accountId.classList.remove("error-input");
};

let notValidAccountId = function () {
    validMsgAccountId.classList.add("hide");
    errorMsgAccountId.classList.remove("hide");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".selectbox-account-id .bfh-selectbox-toggle").classList.add("error-input");
};

// on hide
selectbox_account_id.on('hide.bfhselectbox', function () {
    accountId.value = $(selectbox_account_id).val();

    resetAccountId();

    if (accountId.value.trim() === null || accountId.value.trim() === "") {
        notValidAccountId();
    } else {
        validAccountId();
    }
});

// on keyup/change -> reset
accountId.addEventListener('keyup', resetAccountId);
accountId.addEventListener('change', resetAccountId);


/* Checks cardNumber */
let validMsgNumber = document.querySelector("#valid-msg-cardNumber"),
    errorMsgNumber = document.querySelector("#error-msg-cardNumber");

let resetNumber = function () {
    validMsgNumber.classList.add("hide");
    errorMsgNumber.classList.add("hide");
    number.classList.remove("valid-input");
    number.classList.remove("error-input");
};

let validNumber = function () {
    validMsgNumber.classList.remove("hide");
    errorMsgNumber.classList.add("hide");
    number.classList.add("valid-input");
    number.classList.remove("error-input");
};

let notValidNumber = function () {
    validMsgNumber.classList.add("hide");
    errorMsgNumber.classList.remove("hide");
    number.classList.remove("valid-input");
    number.classList.add("error-input");
};

// on blur
number.addEventListener('blur', function () {
    resetNumber();

    if (number.value.trim() === "" || number.value.trim().length < 16) {
        notValidNumber();
    } else {
        validNumber();
    }
});

// on keyup/change -> reset
number.addEventListener('keyup', resetNumber);
number.addEventListener('change', resetNumber);


/* Checks CVV */
let validMsgCVV = document.querySelector("#valid-msg-cvv"),
    errorMsgCVV = document.querySelector("#error-msg-cvv");

let resetCVV = function () {
    validMsgCVV.classList.add("hide");
    errorMsgCVV.classList.add("hide");
    CVV.classList.remove("valid-input");
    CVV.classList.remove("error-input");
};

let validCVV = function () {
    validMsgCVV.classList.remove("hide");
    errorMsgCVV.classList.add("hide");
    CVV.classList.add("valid-input");
    CVV.classList.remove("error-input");
};

let notValidCVV = function () {
    validMsgCVV.classList.add("hide");
    errorMsgCVV.classList.remove("hide");
    CVV.classList.remove("valid-input");
    CVV.classList.add("error-input");
};

// on blur
CVV.addEventListener('blur', function () {
    resetCVV();

    if (CVV.value.trim() === "" || CVV.value.trim().length < 3) {
        notValidCVV();
    } else {
        validCVV();
    }
});

// on keyup/change -> reset
CVV.addEventListener('keyup', resetCVV);
CVV.addEventListener('change', resetCVV);


/* Checks month and year */
let validMsgValidity = document.querySelector("#valid-msg-validity"),
    errorMsgValidity = document.querySelector("#error-msg-validity");

let resetValidity = function () {
    document.querySelector("#validityExpiredError").classList.add("hide");
    validMsgValidity.classList.add("hide");
    errorMsgValidity.classList.add("hide");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("error-input");
};

let validValidity = function () {
    validMsgValidity.classList.remove("hide");
    errorMsgValidity.classList.add("hide");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidValidity = function () {
    validMsgValidity.classList.add("hide");
    errorMsgValidity.classList.remove("hide");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-month .bfh-selectbox-toggle").classList.add("error-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox-year .bfh-selectbox-toggle").classList.add("error-input");
};

// on hide
selectbox_month.on('hide.bfhselectbox', function () {
    month.value = $(selectbox_month).val();

    resetValidity();

    if (month.value.trim() === null || month.value.trim() === "" ||
        year.value.trim() === null || year.value.trim() === "") {
        notValidValidity();
    } else {
        validValidity();
    }
});

// on hide
selectbox_year.on('hide.bfhselectbox', function () {
    year.value = $(selectbox_year).val();

    resetValidity();

    if (month.value.trim() === null || month.value.trim() === "" ||
        year.value.trim() === null || year.value.trim() === "") {
        notValidValidity();
    } else {
        validValidity();
    }
});

// on keyup/change -> reset
month.addEventListener('keyup', resetValidity);
month.addEventListener('change', resetValidity);
year.addEventListener('keyup', resetValidity);
year.addEventListener('change', resetValidity);


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (accountId.value.trim() === null || accountId.value.trim() === ""  || accountId.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        return false;
    }

    if (number.value.trim() === "" || number.value.trim().length < 16 || number.classList.contains("error-input")) {
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

});