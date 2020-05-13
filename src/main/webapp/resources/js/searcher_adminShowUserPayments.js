// Elements on adminShowUserPayments.jsp page to search
let isIncoming = document.querySelector("#isIncoming");
let isOutgoing = document.querySelector("#isOutgoing");
let checkbox_isIncoming = $("#checkbox-isIncoming");
let checkbox_isOutgoing = $("#checkbox-isOutgoing");
let start_date = document.querySelector("#datepicker-start-date");
let final_date = document.querySelector("#datepicker-final-date");
let searchBtn = document.querySelector("#search");


/* It starts immediately after the page loads */
window.addEventListener("load", () => {
    checkbox_isIncoming.checkboxradio({
        icon: false
    });

    if (isIncoming.value === "1") {
        checkbox_isIncoming.click();
        isIncoming.value = "1";
    } else {
        isIncoming.value = "0";
    }

    checkbox_isOutgoing.checkboxradio({
        icon: false
    });

    if (isOutgoing.value === "1") {
        checkbox_isOutgoing.click();
        isOutgoing.value = "1";
    } else {
        isOutgoing.value = "0";
    }
});

checkbox_isIncoming.on('click', () => {
    if (isIncoming.value === "1") {
        isIncoming.value = "0";
    } else if (isIncoming.value === "0") {
        isIncoming.value = "1";
    } else {
        checkbox_isIncoming.checkboxradio({
            icon: false,
            disabled: true
        });
    }
})

checkbox_isOutgoing.on('click', () => {
    if (isOutgoing.value === "1") {
        isOutgoing.value = "0";
    } else if (isOutgoing.value === "0") {
        isOutgoing.value = "1";
    } else {
        checkbox_isOutgoing.checkboxradio({
            icon: false,
            disabled: true
        });
    }
})

searchBtn.addEventListener('click', () => {

});
