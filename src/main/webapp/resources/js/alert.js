window.document.getElementById("dropdown").addEventListener('click', function () {
    $("#alert").alert('close');
});

setTimeout(function () {
    $("#alert").alert('close')
}, 5500);