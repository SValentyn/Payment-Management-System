// Elements on index.jsp page to check
let login = document.querySelector("#login");
let password = document.querySelector("#password");
let submitBtn = document.querySelector("#submit");


/* Configuring the phone number input field.
* "token" must be obtained on the api website */
let iti = window.intlTelInput(login, {
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
let validMsgLogin = document.querySelector("#valid-msg-login"),
    errorMsgLogin = document.querySelector("#error-msg-login");

let resetLogin = function () {
    validMsgLogin.classList.add("invisible");
    errorMsgLogin.classList.add("invisible");
    login.classList.remove("valid-input");
    login.classList.remove("error-input");
};

let validLogin = function () {
    validMsgLogin.classList.remove("invisible");
    errorMsgLogin.classList.add("invisible");
    login.classList.add("valid-input");
    login.classList.remove("error-input");
};

let notValidLogin = function () {
    validMsgLogin.classList.add("invisible");
    errorMsgLogin.classList.remove("invisible");
    login.classList.remove("valid-input");
    login.classList.add("error-input");
};

login.addEventListener('click', resetLogin);
login.addEventListener('blur', validationLogin);
login.addEventListener('keyup', validationLogin);
login.addEventListener('change', validationLogin);

function validationLogin() {
    resetLogin();

    if (login.value.trim() === "") {
        notValidLogin();
    } else {
        if (iti.isValidNumber()) {
            validLogin();
        } else {
            notValidLogin();
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

    if (login.value.trim() === "" || login.classList.contains("error-input")) {
        event.preventDefault();
        notValidLogin();
        return false;
    }

    if (password.value.trim() === "" || password.value.trim().length < 6 || password.classList.contains("error-input")) {
        event.preventDefault();
        notValidPassword();
        return false;
    }

});