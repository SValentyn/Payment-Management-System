function show_hide_password(target) {
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

function show_hide_passwordConfirmation(target) {
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