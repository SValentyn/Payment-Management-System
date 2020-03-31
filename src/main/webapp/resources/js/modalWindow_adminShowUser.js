let smallModal = $('#smallModal');

function showModal() {
    smallModal.modal('show');
}

smallModal.on('shown.bs.modal', function () {
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

    $('#user_bio').val(params['name'] + " " + params['surname']);
});

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        smallModal.modal('hide');
    }
});