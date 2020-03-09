// Elements on index.jsp page to check
let phone = document.querySelector("#login");
let password = document.querySelector("#password");
let submitBtn = document.querySelector("#submit");


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


/* Checks login (phone number) */
let validMsgPhone = document.querySelector("#valid-msg-login"),
    errorMsgPhone = document.querySelector("#error-msg-login");

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


/* Checks password */
let errorMsgPassword = document.querySelector("#error-msg-password"),
    validMsgPassword = document.querySelector("#valid-msg-password");

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
    } else {
        validPassword();
    }
}


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (phone.value.trim() === "" || phone.classList.contains("error-input")) {
        event.preventDefault();
        notValidPhone();
        return false;
    }

    if (password.value.trim() === "" || password.value.trim().length < 6 || password.classList.contains("error-input")) {
        event.preventDefault();
        notValidPassword();
        return false;
    }

});