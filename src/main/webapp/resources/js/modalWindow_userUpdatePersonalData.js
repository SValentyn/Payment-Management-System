let smallModal = $('#smallModal');

function showModal() {
    smallModal.modal('show');
}

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        smallModal.modal('hide');
    }
});