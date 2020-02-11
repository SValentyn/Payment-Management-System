// Elements on recovery.jsp page to check
let password = document.querySelector("#password");
let submitBtn = document.querySelector("#submit");


/* Configuring the phone number input field.
* "token" must be obtained on the api website */
let iti = window.intlTelInput(phone, {
    separateDialCode: true,
    hiddenInput: "full_phone",
    initialCountry: "auto",
    geoIpLookup: function (callback) {
        $.get('http://ipinfo.io/?token=b3f3eb675dab44', function () {
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


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (phone.value.trim() === "" || phone.classList.contains("error-input")) {
        event.preventDefault();
        notValidPhone();
        return false;
    }

});