// Elements on userCreateAccount.jsp page to check
let number = document.querySelector("#number");
let repeat = document.querySelector("#repeat");
let submitBtn = document.querySelector("#submit");


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

window.addEventListener("load", function () {
    repeat.click();

    if (number.value.trim() === "") {
        notValidNumber();
    } else {
        validNumber();
    }
});

/* Checks accountNumber */
let validMsgNumber = document.querySelector("#valid-msg-accountNumber"),
    errorMsgNumber = document.querySelector("#error-msg-accountNumber");

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

    if (number.value.trim() === "") {
        notValidNumber();
    } else {
        validNumber();
    }
});

// on keyup/change -> reset
number.addEventListener('keyup', resetNumber);
number.addEventListener('change', resetNumber);


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (number.value.trim() === "" || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        return false;
    }

});