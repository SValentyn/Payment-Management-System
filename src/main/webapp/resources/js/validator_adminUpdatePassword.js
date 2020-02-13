// Elements on adminUpdatePassword.jsp page to check
let newPassword = document.querySelector("#newPassword");
let passwordConfirmation = document.querySelector("#passwordConfirmation");
let oldPassword = document.querySelector("#oldPassword");
let submitBtn = document.querySelector("#submit");


/* Checks New Password */
let validMsgNewPassword = document.querySelector("#valid-msg-newPassword"),
    errorMsgNewPassword = document.querySelector("#error-msg-newPassword");

let resetNewPassword = function () {
    document.querySelector("#passwordNotMatchError").classList.add("hide");
    validMsgNewPassword.classList.add("hide");
    errorMsgNewPassword.classList.add("hide");
    newPassword.classList.remove("valid-input");
    newPassword.classList.remove("error-input");
};

let validNewPassword = function () {
    validMsgNewPassword.classList.remove("hide");
    errorMsgNewPassword.classList.add("hide");
    newPassword.classList.add("valid-input");
    newPassword.classList.remove("error-input");
};

let notValidNewPassword = function () {
    validMsgNewPassword.classList.add("hide");
    errorMsgNewPassword.classList.remove("hide");
    newPassword.classList.remove("valid-input");
    newPassword.classList.add("error-input");
};

// on blur
newPassword.addEventListener('blur', function () {
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
});

// on keyup/change -> reset
newPassword.addEventListener('keyup', resetNewPassword);
newPassword.addEventListener('change', resetNewPassword);


/* Checks Password Confirmation */
let validMsgPasswordConfirmation = document.querySelector("#valid-msg-passwordConfirmation"),
    errorMsgPasswordConfirmation = document.querySelector("#error-msg-passwordConfirmation");

let resetPasswordConfirmation = function () {
    validMsgPasswordConfirmation.classList.add("hide");
    errorMsgPasswordConfirmation.classList.add("hide");
    passwordConfirmation.classList.remove("valid-input");
    passwordConfirmation.classList.remove("error-input");
};

let validPasswordConfirmation = function () {
    validMsgPasswordConfirmation.classList.remove("hide");
    errorMsgPasswordConfirmation.classList.add("hide");
    passwordConfirmation.classList.add("valid-input");
    passwordConfirmation.classList.remove("error-input");
};

let notValidPasswordConfirmation = function () {
    validMsgPasswordConfirmation.classList.add("hide");
    errorMsgPasswordConfirmation.classList.remove("hide");
    passwordConfirmation.classList.remove("valid-input");
    passwordConfirmation.classList.add("error-input");
};

// on blur
passwordConfirmation.addEventListener('blur', function () {
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
});

// on keyup/change -> reset
passwordConfirmation.addEventListener('keyup', resetPasswordConfirmation);
passwordConfirmation.addEventListener('change', resetPasswordConfirmation);


/* Check passwords for match */
var matching = function () {
    if (passwordConfirmation.value.trim() === "" || passwordConfirmation.value.trim().length < 6) {
        notValidPasswordConfirmation();
    } else {
        if (passwordConfirmation.value.trim() === newPassword.value.trim()) {
            validPasswordConfirmation();
        } else {
            notValidPasswordConfirmation();
        }
    }
};


/* Checks Old Password */
let validMsgOldPassword = document.querySelector("#valid-msg-oldPassword"),
    errorMsgOldPassword = document.querySelector("#error-msg-oldPassword");

let resetOldPassword = function () {
    document.querySelector("#passwordNotMatchError").classList.add("hide");
    validMsgOldPassword.classList.add("hide");
    errorMsgOldPassword.classList.add("hide");
    oldPassword.classList.remove("valid-input");
    oldPassword.classList.remove("error-input");
};

let validOldPassword = function () {
    validMsgOldPassword.classList.remove("hide");
    errorMsgOldPassword.classList.add("hide");
    oldPassword.classList.add("valid-input");
    oldPassword.classList.remove("error-input");
};

let notValidOldPassword = function () {
    validMsgOldPassword.classList.add("hide");
    errorMsgOldPassword.classList.remove("hide");
    oldPassword.classList.remove("valid-input");
    oldPassword.classList.add("error-input");
};

// on blur
oldPassword.addEventListener('blur', function () {
    resetOldPassword();

    if (oldPassword.value.trim() === "" || oldPassword.value.trim().length < 6) {
        notValidOldPassword();
    } else {
        validOldPassword();
    }
});

// on keyup/change -> reset
oldPassword.addEventListener('keyup', resetOldPassword);
oldPassword.addEventListener('change', resetOldPassword);


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

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

    if (oldPassword.value.trim() === "" || oldPassword.value.trim().length < 6 || oldPassword.classList.contains("error-input")) {
        event.preventDefault();
        notValidOldPassword();
        return false;
    }

});