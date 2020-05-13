// Elements on userShowActionLog.jsp page to search
let start_date = document.querySelector("#datepicker-start-date");
let final_date = document.querySelector("#datepicker-final-date");
let searchBtn = document.querySelector("#search");


searchBtn.addEventListener('click', (event) => {
    start_date.value = start_date.value.trim();
    final_date.value = final_date.value.trim();

    if (start_date.value.trim() === "" && final_date.value.trim() === "") {
        event.preventDefault();
        return false;
    }
});