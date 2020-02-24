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
        $.get('http://ipinfo.io/', function () {
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


/* Checks password */
let errorMsgPassword = document.querySelector("#error-msg-password");

let resetPassword = function () {
    errorMsgPassword.classList.add("hide");
    password.classList.remove("error-input");
};

let validPassword = function () {
    errorMsgPassword.classList.add("hide");
    password.classList.remove("error-input");
};

let notValidPassword = function () {
    errorMsgPassword.classList.remove("hide");
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