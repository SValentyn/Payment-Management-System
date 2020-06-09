/**
 * Elements on adminUpdatePersonalData.jsp page for validation
 */
let name = document.querySelector("#name");
let surname = document.querySelector("#surname");
let phone = document.querySelector("#phone");
let email = document.querySelector("#email");
let password = document.querySelector("#password");
let submitBtn = document.querySelector("#submit");

/**
 * It starts immediately after the page loads
 */
window.addEventListener("load", () => {
    validationName();
    validationSurname();
    validationPhone();
    validationEmail();
});

/**
 * Configuring the phone number input field.
 * "token" must be obtained on the API website.
 */
let iti = window.intlTelInput(phone, {
    separateDialCode: true,
    hiddenInput: "full_phone",
    initialCountry: "auto",
    geoIpLookup: (callback) => {
        $.get('https://ipinfo.io', () => {
        }, "jsonp").always((response) => {
            let countryCode = (response && response.country) ? response.country : "";
            callback(countryCode);
        });
    },
});

/**
 * Name validation
 */
let validMsgName = document.querySelector("#valid-msg-name"),
    errorMsgName = document.querySelector("#error-msg-name");

let resetName = function () {
    validMsgName.classList.add("invisible");
    errorMsgName.classList.add("invisible");
    name.classList.remove("valid-input");
    name.classList.remove("error-input");
}

function validName() {
    validMsgName.classList.remove("invisible");
    errorMsgName.classList.add("invisible");
    name.classList.add("valid-input");
    name.classList.remove("error-input");
}

function notValidName() {
    validMsgName.classList.add("invisible");
    errorMsgName.classList.remove("invisible");
    name.classList.remove("valid-input");
    name.classList.add("error-input");
}

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

/**
 * Surname validation
 */
let validMsgSurname = document.querySelector("#valid-msg-surname"),
    errorMsgSurname = document.querySelector("#error-msg-surname");

function resetSurname() {
    validMsgSurname.classList.add("invisible");
    errorMsgSurname.classList.add("invisible");
    surname.classList.remove("valid-input");
    surname.classList.remove("error-input");
}

function validSurname() {
    validMsgSurname.classList.remove("invisible");
    errorMsgSurname.classList.add("invisible");
    surname.classList.add("valid-input");
    surname.classList.remove("error-input");
}

function notValidSurname() {
    validMsgSurname.classList.add("invisible");
    errorMsgSurname.classList.remove("invisible");
    surname.classList.remove("valid-input");
    surname.classList.add("error-input");
}

surname.addEventListener('click', resetSurname);
surname.addEventListener('blur', validationSurname);
surname.addEventListener('keyup', validationSurname);
surname.addEventListener('change', validationSurname);

function validationSurname() {
    resetSurname();

    if (surname.value.trim() === "") {
        notValidSurname();
    } else {
        if (surname.value.trim().search(/[a-zA-Zа-яА-ЯёЁїЇ ]{1,32}/) === -1) {
            notValidSurname();
        } else {
            validSurname();
        }
    }
}

/**
 * Phone number validation
 */
let validMsgPhone = document.querySelector("#valid-msg-phone"),
    errorMsgPhone = document.querySelector("#error-msg-phone");

function resetPhone() {
    validMsgPhone.classList.add("invisible");
    errorMsgPhone.classList.add("invisible");
    phone.classList.remove("valid-input");
    phone.classList.remove("error-input");
}

function validPhone() {
    validMsgPhone.classList.remove("invisible");
    errorMsgPhone.classList.add("invisible");
    phone.classList.add("valid-input");
    phone.classList.remove("error-input");
}

function notValidPhone() {
    validMsgPhone.classList.add("invisible");
    errorMsgPhone.classList.remove("invisible");
    phone.classList.remove("valid-input");
    phone.classList.add("error-input");
}

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

/**
 * Email validation
 */
let validMsgEmail = document.querySelector("#valid-msg-email"),
    errorMsgEmail = document.querySelector("#error-msg-email");

function resetEmail() {
    validMsgEmail.classList.add("invisible");
    errorMsgEmail.classList.add("invisible");
    email.classList.remove("valid-input");
    email.classList.remove("error-input");
}

function validEmail() {
    validMsgEmail.classList.remove("invisible");
    errorMsgEmail.classList.add("invisible");
    email.classList.add("valid-input");
    email.classList.remove("error-input");
}

function notValidEmail() {
    validMsgEmail.classList.add("invisible");
    errorMsgEmail.classList.remove("invisible");
    email.classList.remove("valid-input");
    email.classList.add("error-input");
}

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

/**
 * Password validation
 */
let validMsgPassword = document.querySelector("#valid-msg-password"),
    errorMsgPassword = document.querySelector("#error-msg-password");

function resetPassword() {
    validMsgPassword.classList.add("invisible");
    errorMsgPassword.classList.add("invisible");
    password.classList.remove("valid-input");
    password.classList.remove("error-input");
}

function validPassword() {
    validMsgPassword.classList.remove("invisible");
    errorMsgPassword.classList.add("invisible");
    password.classList.add("valid-input");
    password.classList.remove("error-input");
}

function notValidPassword() {
    validMsgPassword.classList.add("invisible");
    errorMsgPassword.classList.remove("invisible");
    password.classList.remove("valid-input");
    password.classList.add("error-input");
}

password.addEventListener('click', resetPassword);
password.addEventListener('blur', validationPassword);
password.addEventListener('keyup', validationPassword);
password.addEventListener('change', validationPassword);

function validationPassword() {
    resetPassword();

    if (password.value.trim() === "" || password.value.trim().length < 6 || password.value.trim().length > 255) {
        notValidPassword();
    } else {
        validPassword();
    }
}

/**
 * Checks for errors on the page
 */
submitBtn.addEventListener('click', (event) => {

    validationName();
    if (name.classList.contains("error-input")) {
        event.preventDefault();
        notValidName();
        return false;
    }

    validationSurname();
    if (surname.classList.contains("error-input")) {
        event.preventDefault();
        notValidSurname();
        return false;
    }

    validationPhone();
    if (phone.classList.contains("error-input")) {
        event.preventDefault();
        notValidPhone();
        return false;
    }

    validationEmail();
    if (email.classList.contains("error-input")) {
        event.preventDefault();
        notValidEmail();
        return false;
    }

    validationPassword();
    if (password.classList.contains("error-input")) {
        event.preventDefault();
        notValidPassword();
        return false;
    }
});
