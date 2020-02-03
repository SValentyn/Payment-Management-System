function onlyNumbers() {
    if (event.keyCode !== 13) {
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }
}

// second variant for checking entered characters (onkeyup)
// function onlyNumbers() {
//     $(this).val($(this).val().replace(/\d/g, ''));
// }


$(document).ready(function () {
    $('#passwordConfirmation').on("paste", function (e) {
        e.preventDefault();
    });

    $('#CVV').on("paste", function (e) {
        e.preventDefault();
    });
});
