/*
    Disabling paste in fields: passwordConfirmation and CVV
 */
window.addEventListener("load", function () {
    let passwordConfirmation = document.querySelector("#passwordConfirmation");
    let cvv = document.querySelector("#CVV");

    if (passwordConfirmation != null) {
        passwordConfirmation.addEventListener('paste', function (event) {
            event.preventDefault();
        });
    }

    if (cvv != null) {
        cvv.addEventListener('paste', function (event) {
            event.preventDefault();
        });
    }
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
function card_format(cardNumber) {
    let initValue = cardNumber.replace(/\s/gi, '').replace(/[^0-9]/gi, '');
    let matches = initValue.match(/\d{4,16}/g);
    let match = matches && matches[0] || '';
    let parts = [];

    for (let i = 0, length = match.length; i < length; i += 4) {
        parts.push(match.substring(i, i + 4));
    }

    if (parts.length) {
        return parts.join(' ');
    } else {
        return cardNumber;
    }
}

/*
    The function adjusts the format of the card input field
 */
function correct_card_format(cardNumber) {
    return cardNumber.value.replace(/(\d{1,4}(?=(?:\d\d\d\d)+(?!\d)))/g, "$1" + ' ');
}

/*
    Enter the amount of funds
*/
function inputAmount(amount) {
    let regExps = [/^\D+/, /[^.,\d]+/g, /[.,]+/, /(\d+\.\d{2}).*$/];
    return amount.replace(regExps[0], '').replace(regExps[1], '').replace(regExps[2], '.').replace(regExps[3], '$1');
}
