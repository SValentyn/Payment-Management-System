// Elements on userMakePayment.jsp page to check
let accountId = document.querySelector("#accountId");
let bfh_selectbox = $('.bfh-selectbox');
let number = document.querySelector("#number");
let amount = document.querySelector("#amount");
let appointment = document.querySelector("#appointment");
let submitBtn = document.querySelector("#submit");


/* Checks Account Id */
let validMsgAccountId = document.querySelector("#valid-msg-accountId"),
    errorMsgAccountId = document.querySelector("#error-msg-accountId");

let resetAccountId = function () {
    validMsgAccountId.classList.add("hide");
    errorMsgAccountId.classList.add("hide");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let validAccountId = function () {
    validMsgAccountId.classList.remove("hide");
    errorMsgAccountId.classList.add("hide");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidAccountId = function () {
    validMsgAccountId.classList.add("hide");
    errorMsgAccountId.classList.remove("hide");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("error-input");
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
        if (number.value.match(/[^0-9]/g).length > 1) {
            notValidNumber();
        }
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
    document.querySelector(".ui-spinner").classList.remove("valid-input");
    document.querySelector(".ui-spinner").classList.remove("error-input");
};

let validAmount = function () {
    validMsgAmount.classList.remove("hide");
    errorMsgAmount.classList.add("hide");
    document.querySelector(".ui-spinner").classList.add("valid-input");
    document.querySelector(".ui-spinner").classList.remove("error-input");
};

let notValidAmount = function () {
    validMsgAmount.classList.add("hide");
    errorMsgAmount.classList.remove("hide");
    document.querySelector(".ui-spinner").classList.remove("valid-input");
    document.querySelector(".ui-spinner").classList.add("error-input");
};

// on blur
amount.addEventListener('blur', function () {
    resetAmount();

    if (amount.value.trim() === null || amount.value.trim() === "") {
        notValidAmount();
    } else {
        validAmount();
        if (amount.value.match(/[.,]/g).length > 1) {
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

    let isShow = true;

    if (accountId.value.trim() === null || accountId.value.trim() === "" || accountId.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        isShow = false;
        return false;
    }

    if (number.value.trim() === "" || number.value.trim().length < 20 || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        isShow = false;
        return false;
    }

    if (amount.value.trim() === null || amount.value.trim() === "" || amount.classList.contains("error-input")) {
        event.preventDefault();
        notValidAmount();
        isShow = false;
        return false;
    }

    if (isShow === true) {
        document.querySelector("#accountIdModal").value = accountId.value;
        document.querySelector("#numberModal").value = number.value;
        document.querySelector("#amountModal").value = amount.value;
        document.querySelector("#appointmentModal").value = appointment.value;

        $('#smallModal').modal('show');
    }

});
