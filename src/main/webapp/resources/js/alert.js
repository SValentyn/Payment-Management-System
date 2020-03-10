let alert = $("#alert");
let language = document.getElementById("language");
let dropdown = document.getElementById("dropdown");

setTimeout(function () {
    alert.alert('close');
}, 5500);

language.addEventListener('click', function () {
    alert.alert('close');
});

if (dropdown !== null) {
    dropdown.addEventListener('click', function () {
        alert.alert('close');
    });
}
