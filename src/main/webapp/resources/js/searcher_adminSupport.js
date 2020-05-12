// Elements on adminSupport.jsp page to search
let bfh_selectbox_typeQuestion = $('.bfh-selectbox');
let typeQuestion = document.querySelector("#typeQuestion");
let start_date = document.querySelector("#datepicker-start-date");
let final_date = document.querySelector("#datepicker-final-date");
let searchBtn = document.querySelector("#search");


/* It starts immediately after the page loads */
window.addEventListener("load", () => {
    if (typeQuestion.value.trim().length > 0) {
        $(bfh_selectbox_typeQuestion).val(typeQuestion.value);
    }
});


bfh_selectbox_typeQuestion.on('hide.bfhselectbox', () => typeQuestion.value = $(bfh_selectbox_typeQuestion).val());

searchBtn.addEventListener('click', (event) => {
    typeQuestion.value = typeQuestion.value.trim();
    start_date.value = start_date.value.trim();
    final_date.value = final_date.value.trim();

    if (typeQuestion.value.trim() === "" && start_date.value.trim() === "" && final_date.value.trim() === "") {
        event.preventDefault();
        return false;
    }
});