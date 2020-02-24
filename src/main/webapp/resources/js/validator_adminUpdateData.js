// Elements on adminUpdateData.jsp page to check
let name = document.querySelector("#name");
let surname = document.querySelector("#surname");
let phone = document.querySelector("#phone");
let email = document.querySelector("#email");
let password = document.querySelector("#password");
let submitBtn = document.querySelector("#submit");


/* Checks name */
let validMsgName = document.querySelector("#valid-msg-name"),
    errorMsgName = document.querySelector("#error-msg-name");

let resetName = function () {
    validMsgName.classList.add("hide");
    errorMsgName.classList.add("hide");
    name.classList.remove("valid-input");
    name.classList.remove("error-input");
};

let validName = function () {
    validMsgName.classList.remove("hide");
    errorMsgName.classList.add("hide");
    name.classList.add("valid-input");
    name.classList.remove("error-input");
};

let notValidName = function () {
    validMsgName.classList.add("hide");
    errorMsgName.classList.remove("hide");
    name.classList.remove("valid-input");
    name.classList.add("error-input");
};

// on blur
name.addEventListener('blur', function () {
    resetName();

    if (name.value.trim() === "") {
        notValidName();
    } else {
        if (name.value.trim().search(/[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}/) === -1) {
            notValidName();
        } else {
            validName();
        }
    }
});

// on keyup/change -> reset
name.addEventListener('keyup', resetName);
name.addEventListener('change', resetName);


/* Checks surname */
let validMsgSurname = document.querySelector("#valid-msg-surname"),
    errorMsgSurname = document.querySelector("#error-msg-surname");

let resetSurname = function () {
    validMsgSurname.classList.add("hide");
    errorMsgSurname.classList.add("hide");
    surname.classList.remove("valid-input");
    surname.classList.remove("error-input");
};

let validSurname = function () {
    validMsgSurname.classList.remove("hide");
    errorMsgSurname.classList.add("hide");
    surname.classList.add("valid-input");
    surname.classList.remove("error-input");
};

let notValidSurname = function () {
    validMsgSurname.classList.add("hide");
    errorMsgSurname.classList.remove("hide");
    surname.classList.remove("valid-input");
    surname.classList.add("error-input");
};

// on blur
surname.addEventListener('blur', function () {
    resetSurname();

    if (surname.value.trim() === "") {
        notValidSurname();
    } else {
        if (surname.value.trim().search(/[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}/) === -1) {
            notValidSurname();
        } else {
            validSurname();
        }
    }
});

// on keyup/change -> reset
surname.addEventListener('keyup', resetSurname);
surname.addEventListener('change', resetSurname);


/* Configuring the phone number input field.
* "token" must be obtained on the api website */
let iti = window.intlTelInput(phone, {
    separateDialCode: true,
    hiddenInput: "full_phone",
    initialCountry: "auto",
    geoIpLookup: function (callback) {
        $.get('https://ipinfo.io', function () {
        }, "jsonp").always(function (resp) {
            let countryCode = (resp && resp.country) ? resp.country : "";
            callback(countryCode);
        });
    },
});


/* Checks phone number */
let validMsgPhone = document.querySelector("#valid-msg-phone"),
    errorMsgPhone = document.querySelector("#error-msg-phone");

let resetPhone = function () {
    validMsgPhone.classList.add("hide");
    errorMsgPhone.classList.add("hide");
    phone.classList.remove("valid-input");
    phone.classList.remove("error-input");
};

let validPhone = function () {
    validMsgPhone.classList.remove("hide");
    errorMsgPhone.classList.add("hide");
    phone.classList.add("valid-input");
    phone.classList.remove("error-input");
};

let notValidPhone = function () {
    validMsgPhone.classList.add("hide");
    errorMsgPhone.classList.remove("hide");
    phone.classList.remove("valid-input");
    phone.classList.add("error-input");
};

// on blur
phone.addEventListener('blur', function () {
    resetPhone();

    if (phone.value.trim() === "") {
        notValidPhone();
    } else if (phone.value.trim()) {
        if (iti.isValidNumber()) {
            validPhone();
        } else {
            notValidPhone();
        }
    }
});

// on keyup/change -> reset
phone.addEventListener('keyup', resetPhone);
phone.addEventListener('change', resetPhone);


/* Checks email */
let validMsgEmail = document.querySelector("#valid-msg-email"),
    errorMsgEmail = document.querySelector("#error-msg-email");

let resetEmail = function () {
    validMsgEmail.classList.add("hide");
    errorMsgEmail.classList.add("hide");
    email.classList.remove("valid-input");
    email.classList.remove("error-input");
};

let validEmail = function () {
    validMsgEmail.classList.remove("hide");
    errorMsgEmail.classList.add("hide");
    email.classList.add("valid-input");
    email.classList.remove("error-input");
};

let notValidEmail = function () {
    validMsgEmail.classList.add("hide");
    errorMsgEmail.classList.remove("hide");
    email.classList.remove("valid-input");
    email.classList.add("error-input");
};

// on blur
email.addEventListener('blur', function () {
    resetEmail();

    if (email.value.trim() !== "") {
        if (email.value.trim().search(/[a-zA-Z0-9._-]+@[a-z0-9.-]+.[a-z]{2,}$/) === -1) {
            notValidEmail();
        } else {
            validEmail();
        }
    }
});

// on keyup/change -> reset
email.addEventListener('keyup', resetEmail);
email.addEventListener('change', resetEmail);


/* Checks password */
let validMsgPassword = document.querySelector("#valid-msg-password"),
    errorMsgPassword = document.querySelector("#error-msg-password");

let resetPassword = function () {
    document.querySelector("#passwordNotMatchError").classList.add("hide");
    validMsgPassword.classList.add("hide");
    errorMsgPassword.classList.add("hide");
    password.classList.remove("valid-input");
    password.classList.remove("error-input");
};

let validPassword = function () {
    validMsgPassword.classList.remove("hide");
    errorMsgPassword.classList.add("hide");
    password.classList.add("valid-input");
    password.classList.remove("error-input");
};

let notValidPassword = function () {
    validMsgPassword.classList.add("hide");
    errorMsgPassword.classList.remove("hide");
    password.classList.remove("valid-input");
    password.classList.add("error-input");
};

// on blur
password.addEventListener('blur', function () {
    resetPassword();

    if (password.value.trim() === "" || password.value.trim().length < 6) {
        notValidPassword();
    } else {
        validPassword();
    }
});

// on keyup/change -> reset
password.addEventListener('keyup', resetPassword);
password.addEventListener('change', resetPassword);


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (name.value.trim() === "" || name.classList.contains("error-input")) {
        event.preventDefault();
        notValidName();
        return false;
    }

    if (surname.value.trim() === "" || surname.classList.contains("error-input")) {
        event.preventDefault();
        notValidSurname();
        return false;
    }

    if (phone.value.trim() === "" || phone.classList.contains("error-input")) {
        event.preventDefault();
        notValidPhone();
        return false;
    }

    if (email.classList.contains("error-input")) {
        event.preventDefault();
        notValidEmail();
        return false;
    }

    if (password.value.trim() === "" || password.value.trim().length < 6 || password.classList.contains("error-input")) {
        event.preventDefault();
        notValidPassword();
        return false;
    }

});