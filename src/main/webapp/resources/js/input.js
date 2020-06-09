/**
 * Function that disabling paste in fields: passwordConfirmation and CVV
 */
window.addEventListener("load", () => {
    let passwordConfirmationField = document.querySelector("#passwordConfirmation");
    let cvvField = document.querySelector("#CVV");

    if (passwordConfirmationField != null) {
        passwordConfirmationField.addEventListener('paste', (event) => {
            event.preventDefault();
        });
    }

    if (cvvField != null) {
        cvvField.addEventListener('paste', (event) => {
            event.preventDefault();
        });
    }
});

/**
 * Function that allows you to enter only numbers in the field
 */
function inputOnlyNumbers() {
    if (event.keyCode !== 13) {
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }
}

/**
 * Function for entering an amount of funds correctly
 */
function inputAmount(amount) {
    let regExps = [/^\D+/, /[^.,\d]+/g, /[.,]+/, /(\d+\.\d{2}).*$/];
    return amount.replace(regExps[0], '').replace(regExps[1], '').replace(regExps[2], '.').replace(regExps[3], '$1');
}

/**
 * Function for entering a bank card number correctly
 */
function inputCardNumber(cardNumber) {
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

/**
 * Function for adjusting the value in the card number field
 */
function adjustInputCardNumber(cardNumber) {
    return cardNumber.value.replace(/(\d{1,4}(?=(?:\d\d\d\d)+(?!\d)))/g, "$1" + ' ');
}
