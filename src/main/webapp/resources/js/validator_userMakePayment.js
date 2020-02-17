// Elements on userMakePayment.jsp page to check
let accountId = document.querySelector("#accountId");
let bfh_selectbox = $('.bfh-selectbox');
let number = document.querySelector("#number");
let amount = document.querySelector("#amount");
let submitBtn = document.querySelector("#submit");


/* Checks Account Id */
let validMsgAccountId = document.querySelector("#valid-msg-accountId"),
    errorMsgAccountId = document.querySelector("#error-msg-accountId");

let resetAccountId = function () {
    validMsgAccountId.classList.add("hide");
    errorMsgAccountId.classList.add("hide");
    accountId.classList.remove("valid-input");
    accountId.classList.remove("error-input");
};

let validAccountId = function () {
    validMsgAccountId.classList.remove("hide");
    errorMsgAccountId.classList.add("hide");
    accountId.classList.add("valid-input");
    accountId.classList.remove("error-input");
};

let notValidAccountId = function () {
    validMsgAccountId.classList.add("hide");
    errorMsgAccountId.classList.remove("hide");
    accountId.classList.remove("valid-input");
    accountId.classList.add("error-input");
};

// on hide
bfh_selectbox.on('hide.bfhselectbox', function () {
    accountId.value = $(bfh_selectbox).val();

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

    if (number.value.trim() === "" || number.value.trim().length < 20) {
        notValidNumber();
    } else {
        validNumber();
    }
});

// on keyup/change -> reset
number.addEventListener('keyup', resetNumber);
number.addEventListener('change', resetNumber);


/* Checks Amount */
let validMsgAmount = document.querySelector("#valid-msg-amount"),
    errorMsgAmount = document.querySelector("#error-msg-amount");

let resetAmount = function () {
    validMsgAmount.classList.add("hide");
    errorMsgAmount.classList.add("hide");
    amount.classList.remove("valid-input");
    amount.classList.remove("error-input");
};

let validAmount = function () {
    validMsgAmount.classList.remove("hide");
    errorMsgAmount.classList.add("hide");
    amount.classList.add("valid-input");
    amount.classList.remove("error-input");
};

let notValidAmount = function () {
    validMsgAmount.classList.add("hide");
    errorMsgAmount.classList.remove("hide");
    amount.classList.remove("valid-input");
    amount.classList.add("error-input");
};

// on blur
amount.addEventListener('blur', function () {
    resetAmount();

    if (amount.value.trim() === null || amount.value.trim() === "") {
        notValidAmount();
    } else {
        validAmount();
        if (amount.value.match(/\./g).length > 1) {
            notValidAmount();
        }
    }
});

function inputAmount(value) {
    let regExps = [/^\D+/, /[^.,\d]+/g, /[.,]+/, /(\d+\.\d{2}).*$/];
    return value.replace(regExps[0], '').replace(regExps[1], '').replace(regExps[2], '.').replace(regExps[3], '$1');
}

// on keyup/change -> reset
amount.addEventListener('keyup', resetAmount);
amount.addEventListener('change', resetAmount);

/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (accountId.value.trim() === null || accountId.value.trim() === "" || accountId.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        return false;
    }

    if (number.value.trim() === "" || number.value.trim().length < 20 || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        return false;
    }

    if (amount.value.trim() === null || amount.value.trim() === "" || amount.classList.contains("error-input")) {
        event.preventDefault();
        notValidAmount();
        return false;
    }

});