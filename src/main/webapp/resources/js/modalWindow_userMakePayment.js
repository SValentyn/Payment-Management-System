let smallModal_AN = $('#smallModal-AN');
let smallModal_CN = $('#smallModal-CN');
let cardNumberParam = document.querySelector("#cardNumberParam-CN");
let submitBtn_CN = document.querySelector("#submitBtn-CN");

function showModal_AN() {
    smallModal_AN.modal('show');
}

function showModal_CN() {
    smallModal_CN.modal('show');
}

submitBtn_CN.addEventListener('click', function (event) {
    cardNumberParam.value = cardNumberParam.value.replace(/\s+/g, "");
});

document.addEventListener('keyup', function (e) {
    if (e.keyCode === 27) {
        smallModal_AN.modal('hide');
        smallModal_CN.modal('hide');
    }
});