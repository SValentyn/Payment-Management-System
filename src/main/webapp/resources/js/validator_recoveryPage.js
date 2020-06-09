/**
 * Elements on recovery.jsp page for validation
 */
let login = document.querySelector("#login");
let submitBtn = document.querySelector("#submit");

/**
 * Configuring the phone number input field.
 * "token" must be obtained on the API website.
 */
let iti = window.intlTelInput(login, {
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
 * Login (phone number) validation
 */
let validMsgLogin = document.querySelector("#valid-msg-login"),
    errorMsgLogin = document.querySelector("#error-msg-login");

function resetLogin() {
    validMsgLogin.classList.add("invisible");
    errorMsgLogin.classList.add("invisible");
    login.classList.remove("valid-input");
    login.classList.remove("error-input");
}

function validLogin() {
    validMsgLogin.classList.remove("invisible");
    errorMsgLogin.classList.add("invisible");
    login.classList.add("valid-input");
    login.classList.remove("error-input");
}

function notValidLogin() {
    validMsgLogin.classList.add("invisible");
    errorMsgLogin.classList.remove("invisible");
    login.classList.remove("valid-input");
    login.classList.add("error-input");
}

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

/**
 * Checks for errors on the page
 */
submitBtn.addEventListener('click', (event) => {

    validationLogin();
    if (login.classList.contains("error-input")) {
        event.preventDefault();
        notValidLogin();
        return false;
    }
});