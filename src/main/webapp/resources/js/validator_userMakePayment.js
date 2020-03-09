// Elements on userMakePayment.jsp page to check
let bfh_selectbox = $('.bfh-selectbox');
let accountId = document.querySelector("#accountId");
let numberByAccountId = document.querySelector("#numberByAccountId");
let number = document.querySelector("#number");
let amount = document.querySelector("#amount");
let appointment = document.querySelector("#appointment");
let submitBtn = document.querySelector("#submit");
let isRepeatCommand = document.querySelector('#isRepeatCommand');


/* Checks Account Id */
let validMsgAccountId = document.querySelector("#valid-msg-accountId"),
    errorMsgAccountId = document.querySelector("#error-msg-accountId");

let resetAccountId = function () {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let validAccountId = function () {
    validMsgAccountId.classList.remove("invisible");
    errorMsgAccountId.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidAccountId = function () {
    validMsgAccountId.classList.add("invisible");
    errorMsgAccountId.classList.remove("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("error-input");
};

// on hide
bfh_selectbox.on('hide.bfhselectbox', function () {
    resetAccountId();

    if (isRepeatCommand.value === "0") {
        accountId.value = $(bfh_selectbox).val();
        if (accountId.value.trim() === null || accountId.value.trim() === "") {
            notValidAccountId();
            return;
        } else {
            validAccountId();
        }
    } else {
        isRepeatCommand.value = "0";
        validAccountId();
    }

    numberByAccountId.value = $(bfh_selectbox).find('span')[0].innerHTML;
});

// on keyup/change -> reset
accountId.addEventListener('keyup', resetAccountId);
accountId.addEventListener('change', resetAccountId);


/* Checks accountNumber */
let validMsgNumber = document.querySelector("#valid-msg-accountNumber"),
    errorMsgNumber = document.querySelector("#error-msg-accountNumber");

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

    if (number.value.trim() === "" || number.value.trim().length < 20) {
        notValidNumber();
    } else {
        validNumber();
        if (number.value.match(/[^0-9]/g).length > 1) {
            notValidNumber();
        }
    }
}


/* Checks Amount */
let validMsgAmount = document.querySelector("#valid-msg-amount"),
    errorMsgAmount = document.querySelector("#error-msg-amount");

let resetAmount = function () {
    validMsgAmount.classList.add("invisible");
    errorMsgAmount.classList.add("invisible");
    document.querySelector(".ui-spinner").classList.remove("valid-input");
    document.querySelector(".ui-spinner").classList.remove("error-input");
};

let validAmount = function () {
    validMsgAmount.classList.remove("invisible");
    errorMsgAmount.classList.add("invisible");
    document.querySelector(".ui-spinner").classList.add("valid-input");
    document.querySelector(".ui-spinner").classList.remove("error-input");
};

let notValidAmount = function () {
    validMsgAmount.classList.add("invisible");
    errorMsgAmount.classList.remove("invisible");
    document.querySelector(".ui-spinner").classList.remove("valid-input");
    document.querySelector(".ui-spinner").classList.add("error-input");
};

amount.addEventListener('click', resetAmount);
amount.addEventListener('blur', validationAmount);
amount.addEventListener('keyup', validationAmount);
amount.addEventListener('change', validationAmount);

function validationAmount() {
    resetAmount();

    if (amount.value.trim() === null || amount.value.trim() === "") {
        notValidAmount();
    } else {
        validAmount();
        if (amount.value.match(/[.,]/g).length > 1) {
            notValidAmount();
        }
    }
}

function inputAmount(value) {
    let regExps = [/^\D+/, /[^.,\d]+/g, /[.,]+/, /(\d+\.\d{2}).*$/];
    return value.replace(regExps[0], '').replace(regExps[1], '').replace(regExps[2], '.').replace(regExps[3], '$1');
}


/* Checks errors on the page and displays a modal window, if everything is in order */
submitBtn.addEventListener('click', function (event) {

    // let isShow = true;

    if (accountId.value.trim() === null || accountId.value.trim() === "" || accountId.classList.contains("error-input")) {
        event.preventDefault();
        notValidAccountId();
        // isShow = false;
        return false;
    }

    if (number.value.trim() === "" || number.value.trim().length < 20 || number.classList.contains("error-input")) {
        event.preventDefault();
        notValidNumber();
        // isShow = false;
        return false;
    }

    if (amount.value.trim() === "" || amount.classList.contains("error-input")) {
        event.preventDefault();
        notValidAmount();
        // isShow = false;
        return false;
    }

    // if (isShow === true) {
        document.querySelector("#accountIdModal").value = accountId.value;
        document.querySelector("#numberModal").value = number.value;
        document.querySelector("#amountModal").value = amount.value;
        document.querySelector("#appointmentModal").value = appointment.value;

        document.querySelector("#numberByAccountIdModalText").value = numberByAccountId.value;
        document.querySelector("#numberModalText").value = number.value;
        document.querySelector("#amountModalText").value = amount.value;

        $('#smallModal').modal('show');
    // }

});
