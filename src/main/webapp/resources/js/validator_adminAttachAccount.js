// Elements on adminAttachAccount.jsp page to check
let number = document.querySelector("#number");
let repeat = document.querySelector("#repeat");
let bfh_selectbox_class = $('.bfh-selectbox');
let currency = document.querySelector("#currency");
let submitBtn = document.querySelector("#submit");


/* It starts immediately after the page loads */
window.addEventListener("load", () => {
    repeat.click();
    currency.value = $(bfh_selectbox_class).val();
    validationAccountNumber();
    validationCurrency();
});


repeat.addEventListener('click', () => number.value = randomAccountNumber());

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


/* Account number validation */
let validMsgNumber = document.querySelector("#valid-msg-accountNumber"),
    errorMsgNumber = document.querySelector("#error-msg-accountNumber");

function resetAccountNumber() {
    validMsgNumber.classList.add("invisible");
    errorMsgNumber.classList.add("invisible");
    number.classList.remove("valid-input");
    number.classList.remove("error-input");
}

function validAccountNumber() {
    validMsgNumber.classList.remove("invisible");
    errorMsgNumber.classList.add("invisible");
    number.classList.add("valid-input");
    number.classList.remove("error-input");
}

function notValidAccountNumber() {
    validMsgNumber.classList.add("invisible");
    errorMsgNumber.classList.remove("invisible");
    number.classList.remove("valid-input");
    number.classList.add("error-input");
}

number.addEventListener('click', resetAccountNumber);
number.addEventListener('blur', validationAccountNumber);
number.addEventListener('keyup', validationAccountNumber);
number.addEventListener('change', validationAccountNumber);

function validationAccountNumber() {
    resetAccountNumber();

    if (number.value.trim() === null || number.value.trim() === "" || number.value.trim().length < 20) {
        notValidAccountNumber();
    } else if (number.value.match(/[^0-9]/g) != null) {
        notValidAccountNumber();
    } else {
        validAccountNumber();
    }
}


/* Currency validation */
let validMsgCurrency = document.querySelector("#valid-msg-currency"),
    errorMsgCurrency = document.querySelector("#error-msg-currency");

function resetCurrency() {
    validMsgCurrency.classList.add("invisible");
    errorMsgCurrency.classList.add("invisible");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("error-input");
}

function validCurrency() {
    validMsgCurrency.classList.remove("invisible");
    errorMsgCurrency.classList.add("invisible");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("error-input");
}

function notValidCurrency() {
    validMsgCurrency.classList.add("invisible");
    errorMsgCurrency.classList.remove("invisible");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.add("error-input");
}

bfh_selectbox_class.on('hide.bfhselectbox', () => validationCurrency());

function validationCurrency() {
    resetCurrency();

    currency.value = $(bfh_selectbox_class).val();
    if (currency.value.trim() === null || currency.value.trim() === "" || currency.value.trim().length < 3) {
        notValidCurrency();
    } else {
        validCurrency();
    }
}


/* Checks for errors on the page */
submitBtn.addEventListener('click', (event) => {

    validationAccountNumber();
    if (number.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountNumber();
        return false;
    }

    validationCurrency();
    if (document.querySelector(".bfh-currencies .bfh-selectbox-toggle").classList.contains("error-input")) {
        event.preventDefault();
        notValidCurrency();
        return false;
    }

});