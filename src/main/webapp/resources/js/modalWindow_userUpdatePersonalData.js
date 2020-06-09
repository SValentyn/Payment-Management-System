/**
 * The script to call the modal window "deleteUserModal"
 */
let deleteUserModal = $('#deleteUserModal');

function showDeleteUserModal() {
    deleteUserModal.modal('show');
}

// Closing a modal window using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        deleteUserModal.modal('hide');
    }
});