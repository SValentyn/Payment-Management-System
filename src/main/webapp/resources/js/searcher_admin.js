// Elements on admin.jsp page to search
let name = document.querySelector("#name");
let surname = document.querySelector("#surname");
let phone = document.querySelector("#phone");
let searchBtn = document.querySelector("#search");


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


searchBtn.addEventListener('click', (event) => {
    name.value = name.value.trim();
    surname.value = surname.value.trim();
    phone.value = phone.value.trim();

    if (name.value.trim() === "" && surname.value.trim() === "" && phone.value.trim() === "") {
        event.preventDefault();
        return false;
    }
});