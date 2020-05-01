/*
    Disabling paste in fields: passwordConfirmation and CVV
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

/*
    The function adjusts the format of the card input field
 */
function correct_card_format(cardNumber) {
    let matches = cardNumber.value.match(/\d{4,16}/g);
    let match = matches && matches[0] || '';
    let parts = [];

    for (let i = 0, length = match.length; i < length; i += 4) {
        parts.push(match.substring(i, i + 4));
    }

    cardNumber.value = parts.join(' ');
}

/*
    Enter the amount of funds
*/
function inputAmount(value) {
    let regExps = [/^\D+/, /[^.,\d]+/g, /[.,]+/, /(\d+\.\d{2}).*$/];
    return value.replace(regExps[0], '').replace(regExps[1], '').replace(regExps[2], '.').replace(regExps[3], '$1');
}
