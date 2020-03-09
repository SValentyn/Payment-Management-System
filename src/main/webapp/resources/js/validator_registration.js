// Elements on registration.jsp page to check
let name = document.querySelector("#name");
let surname = document.querySelector("#surname");
let phone = document.querySelector("#phone");
let email = document.querySelector("#email");
let password = document.querySelector("#password");
let passwordConfirmation = document.querySelector("#passwordConfirmation");
let submitBtn = document.querySelector("#submit");


/* Checks name */
let validMsgName = document.querySelector("#valid-msg-name"),
    errorMsgName = document.querySelector("#error-msg-name");

let resetName = function () {
    validMsgName.classList.add("invisible");
    errorMsgName.classList.add("invisible");
    name.classList.remove("valid-input");
    name.classList.remove("error-input");
};

let validName = function () {
    validMsgName.classList.remove("invisible");
    errorMsgName.classList.add("invisible");
    name.classList.add("valid-input");
    name.classList.remove("error-input");
};

let notValidName = function () {
    validMsgName.classList.add("invisible");
    errorMsgName.classList.remove("invisible");
    name.classList.remove("valid-input");
    name.classList.add("error-input");
};


name.addEventListener('click', resetName);
name.addEventListener('blur', validationName);
name.addEventListener('keyup', validationName);
name.addEventListener('change', validationName);

function validationName() {
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
}


/* Checks surname */
let validMsgSurname = document.querySelector("#valid-msg-surname"),
    errorMsgSurname = document.querySelector("#error-msg-surname");

let resetSurname = function () {
    validMsgSurname.classList.add("invisible");
    errorMsgSurname.classList.add("invisible");
    surname.classList.remove("valid-input");
    surname.classList.remove("error-input");
};

let validSurname = function () {
    validMsgSurname.classList.remove("invisible");
    errorMsgSurname.classList.add("invisible");
    surname.classList.add("valid-input");
    surname.classList.remove("error-input");
};

let notValidSurname = function () {
    validMsgSurname.classList.add("invisible");
    errorMsgSurname.classList.remove("invisible");
    surname.classList.remove("valid-input");
    surname.classList.add("error-input");
};

surname.addEventListener('click', resetSurname);
surname.addEventListener('blur', validationSurname);
surname.addEventListener('keyup', validationSurname);
surname.addEventListener('change', validationSurname);

function validationSurname() {
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
}


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
    validMsgPhone.classList.add("invisible");
    errorMsgPhone.classList.add("invisible");
    phone.classList.remove("valid-input");
    phone.classList.remove("error-input");
};

let validPhone = function () {
    validMsgPhone.classList.remove("invisible");
    errorMsgPhone.classList.add("invisible");
    phone.classList.add("valid-input");
    phone.classList.remove("error-input");
};

let notValidPhone = function () {
    validMsgPhone.classList.add("invisible");
    errorMsgPhone.classList.remove("invisible");
    phone.classList.remove("valid-input");
    phone.classList.add("error-input");
};

phone.addEventListener('click', resetPhone);
phone.addEventListener('blur', validationPhone);
phone.addEventListener('keyup', validationPhone);
phone.addEventListener('change', validationPhone);

function validationPhone() {
    resetPhone();

    if (phone.value.trim() === "") {
        notValidPhone();
    } else {
        if (iti.isValidNumber()) {
            validPhone();
        } else {
            notValidPhone();
        }
    }
}


/* Checks email */
let validMsgEmail = document.querySelector("#valid-msg-email"),
    errorMsgEmail = document.querySelector("#error-msg-email");

let resetEmail = function () {
    validMsgEmail.classList.add("invisible");
    errorMsgEmail.classList.add("invisible");
    email.classList.remove("valid-input");
    email.classList.remove("error-input");
};

let validEmail = function () {
    validMsgEmail.classList.remove("invisible");
    errorMsgEmail.classList.add("invisible");
    email.classList.add("valid-input");
    email.classList.remove("error-input");
};

let notValidEmail = function () {
    validMsgEmail.classList.add("invisible");
    errorMsgEmail.classList.remove("invisible");
    email.classList.remove("valid-input");
    email.classList.add("error-input");
};

email.addEventListener('click', resetEmail);
email.addEventListener('blur', validationEmail);
email.addEventListener('keyup', validationEmail);
email.addEventListener('change', validationEmail);

function validationEmail() {
    resetEmail();

    let regExp = /[a-zA-Z0-9._-]+@[a-z0-9.-]+.[a-z]{2,}$/;
    if (email.value.trim() !== "") {
        if (email.value.trim().search(regExp) === -1) {
            notValidEmail();
        } else {
            validEmail();
        }
    }
}


/* Checks password */
let validMsgPassword = document.querySelector("#valid-msg-password"),
    errorMsgPassword = document.querySelector("#error-msg-password");

let resetPassword = function () {
    validMsgPassword.classList.add("invisible");
    errorMsgPassword.classList.add("invisible");
    password.classList.remove("valid-input");
    password.classList.remove("error-input");
};

let validPassword = function () {
    validMsgPassword.classList.remove("invisible");
    errorMsgPassword.classList.add("invisible");
    password.classList.add("valid-input");
    password.classList.remove("error-input");
};

let notValidPassword = function () {
    validMsgPassword.classList.add("invisible");
    errorMsgPassword.classList.remove("invisible");
    password.classList.remove("valid-input");
    password.classList.add("error-input");
};

password.addEventListener('click', resetPassword);
password.addEventListener('blur', validationPassword);
password.addEventListener('keyup', validationPassword);
password.addEventListener('change', validationPassword);

function validationPassword() {
    resetPassword();

    if (password.value.trim() === "" || password.value.trim().length < 6) {
        notValidPassword();
        if (passwordConfirmation.classList.contains("valid-input") ||
            passwordConfirmation.classList.contains("error-input")) {
            matching();
        }
    } else {
        validPassword();
        if (passwordConfirmation.classList.contains("valid-input") ||
            passwordConfirmation.classList.contains("error-input")) {
            matching();
        }
    }
}


/* Checks password confirmation */
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
        if (passwordConfirmation.value.trim() === password.value.trim()) {
            validPasswordConfirmation();
        } else {
            notValidPasswordConfirmation();
        }
    }
}

/* Check passwords for match */
var matching = function () {
    if (passwordConfirmation.value.trim() === "") {
        notValidPasswordConfirmation();
    } else {
        if (passwordConfirmation.value.trim() === password.value.trim()) {
            validPasswordConfirmation();
        } else {
            notValidPasswordConfirmation();
        }
    }
};


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

    if (passwordConfirmation.value.trim() === "" || passwordConfirmation.value.trim().length < 6 || passwordConfirmation.classList.contains("error-input")) {
        event.preventDefault();
        notValidPasswordConfirmation();
        return false;
    }

});