/**
 * The script to call the modal window "deleteAccountModal"
 */
let deleteAccountModal = $('#deleteAccountModal');

function showDeleteAccountModal() {
    deleteAccountModal.modal('show');
}

// Closing a modal window using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        deleteAccountModal.modal('hide');
    }
});