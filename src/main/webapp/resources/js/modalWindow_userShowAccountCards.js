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

// Closing a modal window using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        detachCardModal.modal('hide');
    }
});