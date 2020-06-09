let alert = $("#alert");
let language = document.getElementById("language");
let dropdown = document.getElementById("dropdown");

setTimeout(() => {
    alert.alert('close');
}, 5000);

language.addEventListener('click', () => {
    alert.alert('close');
});

if (dropdown !== null) {
    dropdown.addEventListener('click', () => {
        alert.alert('close');
    });
}
