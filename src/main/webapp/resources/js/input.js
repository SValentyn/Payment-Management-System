/*
    Disabling paste
 */
$(document).ready(function () {
    $('#passwordConfirmation').on("paste", function (e) {
        e.preventDefault();
    });

    $('#CVV').on("paste", function (e) {
        e.preventDefault();
    });
});

/*
    Entering only numbers
 */
function onlyNumbers() {
    if (event.keyCode !== 13) {
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }
}

/*
    Enter the card number
*/
function card_format(value) {
    let initValue = value.replace(/\s/gi, '').replace(/[^0-9]/gi, '');
    let matches = initValue.match(/\d{4,16}/g);
    let match = matches && matches[0] || '';
    let parts = [];

    for (let i = 0, length = match.length; i < length; i += 4) {
        parts.push(match.substring(i, i + 4));
    }

    if (parts.length) {
        return parts.join(' ');
    } else {
        return value;
    }
}