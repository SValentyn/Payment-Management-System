// call modal window "deleteAccountModal"
let deleteAccountModal = $('#deleteAccountModal');

function showDeleteAccountModal() {
    deleteAccountModal.modal('show');
}

deleteAccountModal.on('shown.bs.modal', function () {
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


// call modal window "detachCardModal"
let detachCardModal = $('#detachCardModal');

function showDetachCardModal() {
    detachCardModal.modal('show');
}

detachCardModal.on('shown.bs.modal', function () {
    let cardNumber;

    if (window.location.href.split('cardNumber=').length === 1) {
        cardNumber = window.location.href.split('cardNumber=')[1];
    } else {
        let length = window.location.href.split('cardNumber=').length;
        cardNumber = window.location.href.split('cardNumber=')[length - 1];
    }

    $('#cardNumber').val(cardNumber);
    $('#cardNumberText').val(cardNumber);
});

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        deleteAccountModal.modal('hide');
        detachCardModal.modal('hide');
    }
});