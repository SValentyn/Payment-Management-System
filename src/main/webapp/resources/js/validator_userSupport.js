// Elements on userSupport.jsp page to check
let typeQuestion = document.querySelector("#typeQuestion");
let bfh_selectbox_class = $('.bfh-selectbox');
let submitBtn = document.querySelector("#submit");


/* Checks TypeQuestion */
let validMsgTypeQuestion = document.querySelector("#valid-msg-typeQuestion"),
    errorMsgTypeQuestion = document.querySelector("#error-msg-typeQuestion");

let resetTypeQuestion = function () {
    validMsgTypeQuestion.classList.add("hide");
    errorMsgTypeQuestion.classList.add("hide");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let validTypeQuestion = function () {
    validMsgTypeQuestion.classList.remove("hide");
    errorMsgTypeQuestion.classList.add("hide");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidTypeQuestion = function () {
    validMsgTypeQuestion.classList.add("hide");
    errorMsgTypeQuestion.classList.remove("hide");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("error-input");
};

// on hide
bfh_selectbox_class.on('hide.bfhselectbox', function () {
    typeQuestion.value = $(bfh_selectbox_class).val();

    resetTypeQuestion();

    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "") {
        notValidTypeQuestion();
    } else {
        validTypeQuestion();
    }
});

// on keyup/change -> reset
typeQuestion.addEventListener('keyup', resetTypeQuestion);
typeQuestion.addEventListener('change', resetTypeQuestion);


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "" || typeQuestion.classList.contains("error-input")) {
        event.preventDefault();
        notValidTypeQuestion();
        return false;
    }

});