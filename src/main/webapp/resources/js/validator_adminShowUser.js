/**
 * Elements on adminShowUser.jsp page for validation
 */
let phone = document.querySelector("#phone");
let phone_admin = document.querySelector("#phone_admin");

/**
 * Configuring the phone number input field.
 * "token" must be obtained on the API website.
 */
let iti;

if (phone != null) {
    iti = window.intlTelInput(phone, {
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
}

if (phone_admin != null) {
    iti = window.intlTelInput(phone_admin, {
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
}
