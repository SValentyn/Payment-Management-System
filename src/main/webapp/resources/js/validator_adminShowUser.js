// Elements on adminShowUser.jsp page to check
let phone = document.querySelector("#phone");
let phone_admin = document.querySelector("#phone_admin");

/* Configuring the phone number input field.
 * "token" must be obtained on the api website */
let iti;

if (phone != null) {
    iti = window.intlTelInput(phone, {
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
}

if (phone_admin != null) {
    iti = window.intlTelInput(phone_admin, {
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
}