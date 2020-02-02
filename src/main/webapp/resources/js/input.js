function onlyNumbers() {
    if (event.keyCode < 48 || event.keyCode > 57) {
        event.returnValue = false;
    }
}

// second option for checking entered characters (onkeyup)
/*
function onlyNumbers() {
    $(this).val($(this).val().replace(/\D/g, ''));
}
*/



