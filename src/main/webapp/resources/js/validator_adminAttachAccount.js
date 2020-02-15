// Elements on adminAttachAccount.jsp page to check
let number = document.querySelector("#number");
let repeat = document.querySelector("#repeat");
let currency = document.querySelector("#currency");
let bfh_selectbox_class = $('.bfh-selectbox');
let submitBtn = document.querySelector("#submit");


/* It starts immediately after the page loads */
window.addEventListener("load", function () {
    document.querySelector("#numberExistError").classList.add("hide");
    repeat.click();

    if (number.value.trim() === "" || number.value.trim() === null) {
        notValidNumber();
    } else {
        validNumber();
    }

    if (currency.value.trim() === "" || currency.value.trim() === null) {
        notValidCurrency();
    } else {
        validCurrency();
    }
});


/* Generate random numeric string */
function randomAccountNumber() {
    let array = '0123456789';
    let length = 20;
    let result = '';

    for (let i = length; i > 0; i--) {
        result += array[Math.floor(Math.random() * array.length)];
    }

    return result;
}

repeat.addEventListener('click', function (event) {
    number.value = randomAccountNumber();
});


/* Checks Account Number */
let validMsgNumber = document.querySelector("#valid-msg-accountNumber"),
    errorMsgNumber = document.querySelector("#error-msg-accountNumber");

let resetNumber = function () {
    document.querySelector("#numberExistError").classList.add("hide");
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

    if (number.value.trim() === null || number.value.trim() === "" || number.value.trim() < 20) {
        notValidNumber();
    } else {
        validNumber();
    }
});

// on keyup/change -> reset
number.addEventListener('keyup', resetNumber);
number.addEventListener('change', resetNumber);


/* Checks Currency */
let validMsgCurrency = document.querySelector("#valid-msg-currency"),
    errorMsgCurrency = document.querySelector("#error-msg-currency");

let resetCurrency = function () {
    validMsgCurrency.classList.add("hide");
    errorMsgCurrency.classList.add("hide");
    currency.classList.remove("valid-input");
    currency.classList.remove("error-input");
};

let validCurrency = function () {
    validMsgCurrency.classList.remove("hide");
    errorMsgCurrency.classList.add("hide");
    currency.classList.add("valid-input");
    currency.classList.remove("error-input");
};

let notValidCurrency = function () {
    validMsgCurrency.classList.add("hide");
    errorMsgCurrency.classList.remove("hide");
    currency.classList.remove("valid-input");
    currency.classList.add("error-input");
};

bfh_selectbox_class.on('change.bfhselectbox', function () {
    let selected_currency = $(bfh_selectbox_class).val();
    $('#currency').val(selected_currency);

    resetCurrency();

    if (currency.value.trim() === "" || currency.value.trim() === null) {
        notValidCurrency();
    } else {
        validCurrency();
    }
});


// on keyup/change -> reset
currency.addEventListener('keyup', resetCurrency);
currency.addEventListener('change', resetCurrency);


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (number.value.trim() === "" || number.value.trim() === null || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        return false;
    }

    if (currency.value.trim() === "" || currency.value.trim() === null || currency.classList.contains("error-input")) {
        event.preventDefault();
        notValidCurrency();
        return false;
    }

});