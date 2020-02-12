// Elements on adminAttachCard.jsp page to check
let number = document.querySelector("#number");
let CVV = document.querySelector("#CVV");
let month = document.querySelector("#month");
let year = document.querySelector("#year");
let submitBtn = document.querySelector("#submit");


/* Checks Card Number */
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
    validMsgValidity.classList.add("hide");
    errorMsgValidity.classList.add("hide");
    month.classList.remove("valid-input");
    month.classList.remove("error-input");
    year.classList.remove("valid-input");
    year.classList.remove("error-input");
};

let validValidity = function () {
    validMsgValidity.classList.remove("hide");
    errorMsgValidity.classList.add("hide");
    month.classList.add("valid-input");
    month.classList.remove("error-input");
    year.classList.add("valid-input");
    year.classList.remove("error-input");
};

let notValidValidity = function () {
    validMsgValidity.classList.add("hide");
    errorMsgValidity.classList.remove("hide");
    month.classList.remove("valid-input");
    month.classList.add("error-input");
    year.classList.remove("valid-input");
    year.classList.add("error-input");
};

// on blur
month.addEventListener('blur', function () {
    resetValidity();

    if (month.value.trim() === null || month.value.trim() === "0" ||
        year.value.trim() === null || year.value.trim() === "0") {
        notValidValidity();
    } else {
        validValidity();
    }
});

// on blur
year.addEventListener('blur', function () {
    resetValidity();

    if (month.value.trim() === null || month.value.trim() === "0" ||
        year.value.trim() === null || year.value.trim() === "0") {
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

    if (month.value.trim() === null || month.value.trim() === "0" || month.classList.contains("error-input") ||
        year.value.trim() === null || year.value.trim() === "0" || year.classList.contains("error-input")) {
        event.preventDefault();
        notValidValidity();
        return false;
    }

});