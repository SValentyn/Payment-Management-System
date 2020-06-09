/**
 * The script to call the modal window "deleteUserModal"
 */
let deleteUserModal = $('#deleteUserModal');

function showDeleteUserModal() {
    deleteUserModal.modal('show');
}

deleteUserModal.on('shown.bs.modal', () => {
    let params = window.location.href
        .split('deleteUserModal')[1]
        .replace('?', '')
        .split('&')
        .reduce((element, e) => {
            let param_value = e.split('=');
            element[decodeURIComponent(param_value[0])] = decodeURIComponent(param_value[1]);
            return element;
        }, {});

    $('#user_bio').val(params['name'] + " " + params['surname']);
});

// Closing a modal window using ESC
document.addEventListener('keyup', (event) => {
    if (event.keyCode === 27) {
        deleteUserModal.modal('hide');
    }
});