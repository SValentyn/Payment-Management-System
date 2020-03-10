// Elements on userCreateAccount.jsp page to check
let number = document.querySelector("#number");
let repeat = document.querySelector("#repeat");
let currency = document.querySelector("#currency");
let bfh_selectbox_class = $('.bfh-selectbox');
let submitBtn = document.querySelector("#submit");


/* It starts immediately after the page loads */
window.addEventListener("load", function () {
    document.querySelector("#numberExistError").classList.add("invisible");
    repeat.click();
    validationNumber();
    validationCurrency();
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
    document.querySelector("#numberExistError").classList.add("invisible");
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

    if (number.value.trim() === null || number.value.trim() === "") {
        notValidNumber();
    } else {
        validNumber();
    }
}


/* Checks Currency */
let validMsgCurrency = document.querySelector("#valid-msg-currency"),
    errorMsgCurrency = document.querySelector("#error-msg-currency");

let resetCurrency = function () {
    validMsgCurrency.classList.add("invisible");
    errorMsgCurrency.classList.add("invisible");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("error-input");
};

let validCurrency = function () {
    validMsgCurrency.classList.remove("invisible");
    errorMsgCurrency.classList.add("invisible");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidCurrency = function () {
    validMsgCurrency.classList.add("invisible");
    errorMsgCurrency.classList.remove("invisible");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.add("error-input");
};

currency.addEventListener('click', resetCurrency);
currency.addEventListener('change', validationCurrency);

// on hide
bfh_selectbox_class.on('hide.bfhselectbox', function () {
    validationCurrency();
});

function validationCurrency() {
    resetCurrency();

    currency.value = $(bfh_selectbox_class).val();
    if (currency.value.trim() === null || currency.value.trim() === "") {
        notValidCurrency();
    } else {
        validCurrency();
    }
}


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (number.value.trim() === null || number.value.trim() === "" || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        return false;
    }

    if (currency.value.trim() === null || currency.value.trim() === "" || currency.classList.contains("error-input")) {
        event.preventDefault();
        notValidCurrency();
        return false;
    }

});