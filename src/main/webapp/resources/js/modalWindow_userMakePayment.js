let smallModal_AN = $('#smallModal-AN');
let smallModal_CN = $('#smallModal-CN');

function showModal_AN() {
    smallModal_AN.modal('show');
}

function showModal_CN() {
    smallModal_CN.modal('show');
}

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        smallModal_AN.modal('hide');
        smallModal_CN.modal('hide');
    }
});