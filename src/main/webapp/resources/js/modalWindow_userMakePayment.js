/**
 * The script to call the modal windows "paymentConfirmationModal-AN" and "paymentConfirmationModal-CN"
 */
let paymentConfirmationModal_AN = $('#paymentConfirmationModal-AN');
let paymentConfirmationModal_CN = $('#paymentConfirmationModal-CN');

function showModal_AN() {
    paymentConfirmationModal_AN.modal('show');
}

function showModal_CN() {
    paymentConfirmationModal_CN.modal('show');
}

// Closing modal windows using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        paymentConfirmationModal_AN.modal('hide');
        paymentConfirmationModal_CN.modal('hide');
    }
});