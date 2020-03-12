// Disabling paste
$(document).ready(function () {
    $('#passwordConfirmation').on("paste", function (e) {
        e.preventDefault();
    });

    $('#CVV').on("paste", function (e) {
        e.preventDefault();
    });
});

// Entering only numbers
function onlyNumbers() {
    if (event.keyCode !== 13) {
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }
}
