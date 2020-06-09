/**
 * The functions below used to control the visibility of the password in the corresponding fields
 */

function toggle_password(target) {
    let input = document.getElementById('password');

    if (input.getAttribute('type') === 'password') {
        target.classList.add('view');
        input.setAttribute('type', 'text');
    } else {
        target.classList.remove('view');
        input.setAttribute('type', 'password');
    }

    return false;
}

function toggle_passwordConfirmation(target) {
    let input = document.getElementById('passwordConfirmation');

    if (input.getAttribute('type') === 'password') {
        target.classList.add('view');
        input.setAttribute('type', 'text');
    } else {
        target.classList.remove('view');
        input.setAttribute('type', 'password');
    }

    return false;
}

function toggle_oldPassword(target) {
    let input = document.getElementById('oldPassword');

    if (input.getAttribute('type') === 'password') {
        target.classList.add('view');
        input.setAttribute('type', 'text');
    } else {
        target.classList.remove('view');
        input.setAttribute('type', 'password');
    }

    return false;
}

function toggle_newPassword(target) {
    let input = document.getElementById('newPassword');

    if (input.getAttribute('type') === 'password') {
        target.classList.add('view');
        input.setAttribute('type', 'text');
    } else {
        target.classList.remove('view');
        input.setAttribute('type', 'password');
    }

    return false;
}
