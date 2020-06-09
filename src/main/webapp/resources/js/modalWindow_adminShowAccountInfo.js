/**
 * The script to call the modal window "deleteAccountModal"
 */
let deleteAccountModal = $('#deleteAccountModal');

function showDeleteAccountModal() {
    deleteAccountModal.modal('show');
}

deleteAccountModal.on('shown.bs.modal', () => {
    let accountNumber;

    if (window.location.href.split('accountNumber=').length === 1) {
        accountNumber = window.location.href.split('accountNumber=')[1];
    } else {
        let length = window.location.href.split('accountNumber=').length;
        accountNumber = window.location.href.split('accountNumber=')[length - 1];
    }

    $('#accountNumber').val(accountNumber);
    $('#accountNumberText').val(accountNumber);
});

/**
 * The script to call the modal window "detachCardModal"
 */
let detachCardModal = $('#detachCardModal');

function showDetachCardModal() {
    detachCardModal.modal('show');
}

detachCardModal.on('shown.bs.modal', () => {
    let params = window.location.href
        .split('detachCardModal')[1]
        .replace('?', '')
        .split('&')
        .reduce((element, e) => {
            let param_value = e.split('=');
            element[decodeURIComponent(param_value[0])] = decodeURIComponent(param_value[1]);
            return element;
        }, {});

    $('#cardId').val(params['cardId']);
    $('#cardNumberText').val(params['cardNumber']);
});

// Closing modal windows using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        deleteAccountModal.modal('hide');
        detachCardModal.modal('hide');
    }
});