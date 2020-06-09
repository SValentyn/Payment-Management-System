/**
 * Elements on adminShowLetterInfo.jsp page for validation
 */
let phone = document.querySelector("#phone");
let submitBtn = document.querySelector("#submit");

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
