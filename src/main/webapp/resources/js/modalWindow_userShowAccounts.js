let smallModal = $('#smallModal');

function showModal() {
    smallModal.modal('show');
}

smallModal.on('shown.bs.modal', function () {
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
        smallModal.modal('hide');
    }
});