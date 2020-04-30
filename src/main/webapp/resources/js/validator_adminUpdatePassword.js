// Elements on adminUpdatePassword.jsp page to check
let oldPassword = document.querySelector("#oldPassword");
let newPassword = document.querySelector("#newPassword");
let passwordConfirmation = document.querySelector("#passwordConfirmation");
let submitBtn = document.querySelector("#submit");


/* Checks Old Password */
let validMsgOldPassword = document.querySelector("#valid-msg-oldPassword"),
    errorMsgOldPassword = document.querySelector("#error-msg-oldPassword");

let resetOldPassword = function () {
    validMsgOldPassword.classList.add("invisible");
    errorMsgOldPassword.classList.add("invisible");
    oldPassword.classList.remove("valid-input");
    oldPassword.classList.remove("error-input");
};

let validOldPassword = function () {
    validMsgOldPassword.classList.remove("invisible");
    errorMsgOldPassword.classList.add("invisible");
    oldPassword.classList.add("valid-input");
    oldPassword.classList.remove("error-input");
};

let notValidOldPassword = function () {
    validMsgOldPassword.classList.add("invisible");
    errorMsgOldPassword.classList.remove("invisible");
    oldPassword.classList.remove("valid-input");
    oldPassword.classList.add("error-input");
};

oldPassword.addEventListener('click', resetOldPassword);
oldPassword.addEventListener('blur', validationOldPassword);
oldPassword.addEventListener('keyup', validationOldPassword);
oldPassword.addEventListener('change', validationOldPassword);

function validationOldPassword() {
    resetOldPassword();

    if (oldPassword.value.trim() === "" || oldPassword.value.trim().length < 6) {
        notValidOldPassword();
    } else {
        validOldPassword();
    }
}


/* Checks New Password */
let validMsgNewPassword = document.querySelector("#valid-msg-newPassword"),
    errorMsgNewPassword = document.querySelector("#error-msg-newPassword");

let resetNewPassword = function () {
    validMsgNewPassword.classList.add("invisible");
    errorMsgNewPassword.classList.add("invisible");
    newPassword.classList.remove("valid-input");
    newPassword.classList.remove("error-input");
};

let validNewPassword = function () {
    validMsgNewPassword.classList.remove("invisible");
    errorMsgNewPassword.classList.add("invisible");
    newPassword.classList.add("valid-input");
    newPassword.classList.remove("error-input");
};

let notValidNewPassword = function () {
    validMsgNewPassword.classList.add("invisible");
    errorMsgNewPassword.classList.remove("invisible");
    newPassword.classList.remove("valid-input");
    newPassword.classList.add("error-input");
};

newPassword.addEventListener('click', resetNewPassword);
newPassword.addEventListener('blur', validationNewPassword);
newPassword.addEventListener('keyup', validationNewPassword);
newPassword.addEventListener('change', validationNewPassword);

function validationNewPassword() {
    resetNewPassword();

    if (newPassword.value.trim() === "" || newPassword.value.trim().length < 6) {
        notValidNewPassword();
        if (passwordConfirmation.classList.contains("valid-input") ||
            passwordConfirmation.classList.contains("error-input")) {
            matching();
        }
    } else {
        validNewPassword();
        if (passwordConfirmation.classList.contains("valid-input") ||
            passwordConfirmation.classList.contains("error-input")) {
            matching();
        }
    }
}


/* Checks Password Confirmation */
let validMsgPasswordConfirmation = document.querySelector("#valid-msg-passwordConfirmation"),
    errorMsgPasswordConfirmation = document.querySelector("#error-msg-passwordConfirmation");

let resetPasswordConfirmation = function () {
    validMsgPasswordConfirmation.classList.add("invisible");
    errorMsgPasswordConfirmation.classList.add("invisible");
    passwordConfirmation.classList.remove("valid-input");
    passwordConfirmation.classList.remove("error-input");
};

let validPasswordConfirmation = function () {
    validMsgPasswordConfirmation.classList.remove("invisible");
    errorMsgPasswordConfirmation.classList.add("invisible");
    passwordConfirmation.classList.add("valid-input");
    passwordConfirmation.classList.remove("error-input");
};

let notValidPasswordConfirmation = function () {
    validMsgPasswordConfirmation.classList.add("invisible");
    errorMsgPasswordConfirmation.classList.remove("invisible");
    passwordConfirmation.classList.remove("valid-input");
    passwordConfirmation.classList.add("error-input");
};

passwordConfirmation.addEventListener('click', resetPasswordConfirmation);
passwordConfirmation.addEventListener('blur', validationPasswordConfirmation);
passwordConfirmation.addEventListener('keyup', validationPasswordConfirmation);
passwordConfirmation.addEventListener('change', validationPasswordConfirmation);

function validationPasswordConfirmation() {
    resetPasswordConfirmation();

    if (passwordConfirmation.value.trim() === "" || passwordConfirmation.value.trim().length < 6) {
        notValidPasswordConfirmation();
    } else {
        if (passwordConfirmation.value.trim() === newPassword.value.trim()) {
            validPasswordConfirmation();
        } else {
            notValidPasswordConfirmation();
        }
    }
}


/* Check passwords for match */
function matching () {
    if (passwordConfirmation.value.trim() === "" || passwordConfirmation.value.trim().length < 6) {
        notValidPasswordConfirmation();
    } else {
        if (passwordConfirmation.value.trim() === newPassword.value.trim()) {
            validPasswordConfirmation();
        } else {
            notValidPasswordConfirmation();
        }
    }
}


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (oldPassword.value.trim() === "" || oldPassword.value.trim().length < 6 || oldPassword.classList.contains("error-input")) {
        event.preventDefault();
        notValidOldPassword();
        return false;
    }

    if (newPassword.value.trim() === "" || newPassword.value.trim().length < 6 || newPassword.classList.contains("error-input")) {
        event.preventDefault();
        notValidNewPassword();
        return false;
    }

    if (passwordConfirmation.value.trim() === "" || passwordConfirmation.value.trim().length < 6 || passwordConfirmation.classList.contains("error-input")) {
        event.preventDefault();
        notValidPasswordConfirmation();
        return false;
    }

});