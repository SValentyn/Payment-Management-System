/**
 * The script to call the modal window "clearActionLogModal"
 */
let clearActionLogModal = $('#clearActionLogModal');

function showClearActionLogModal() {
    clearActionLogModal.modal('show');
}

// Closing a modal window using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        clearActionLogModal.modal('hide');
    }
});