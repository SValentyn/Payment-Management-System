let detachCardModal = $('#detachCardModal');

function showDetachCardModal() {
    detachCardModal.modal('show');
}

detachCardModal.on('shown.bs.modal', function () {
    let params = window.location.href
        .split('detachCardModal')[1]
        .replace('?', '')
        .split('&')
        .reduce(
            function (element, e) {
                let param_value = e.split('=');
                element[decodeURIComponent(param_value[0])] = decodeURIComponent(param_value[1]);
                return element;
            }, {}
        );

    $('#cardId').val(params['cardId']);
    $('#cardNumberText').val(params['cardNumber']);
});

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        detachCardModal.modal('hide');
    }
});