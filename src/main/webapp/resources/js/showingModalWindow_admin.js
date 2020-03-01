let smallModal = $('#smallModal');

function showModal() {
    smallModal.modal('show');
}

smallModal.on('shown.bs.modal', function () {
    let userId;
    let user_bio;

    let params = window.location.href
        .split('smallModal')[1]
        .replace('?', '')
        .split('&')
        .reduce(
            function (element, e) {
                let param_value = e.split('=');
                element[decodeURIComponent(param_value[0])] = decodeURIComponent(param_value[1]);
                return element;
            }, {}
        );
    userId = params['userId'];
    user_bio = params['name'] + " " + params['surname'];

    $('#userId').val(userId);
    $('#user_bio').val(user_bio);
});

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        smallModal.modal('hide');
    }
});