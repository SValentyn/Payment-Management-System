let deleteAccountModal = $('#deleteAccountModal');

function showDeleteAccountModal() {
    deleteAccountModal.modal('show');
}

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        deleteAccountModal.modal('hide');
    }
});