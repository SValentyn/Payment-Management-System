// Elements on userSupport.jsp page to check
let typeQuestion = document.querySelector("#typeQuestion");
let bfh_selectbox_class = $('.bfh-selectbox');
let submitBtn = document.querySelector("#submit");


/* Checks TypeQuestion */
let validMsgTypeQuestion = document.querySelector("#valid-msg-typeQuestion"),
    errorMsgTypeQuestion = document.querySelector("#error-msg-typeQuestion");

let resetTypeQuestion = function () {
    validMsgTypeQuestion.classList.add("invisible");
    errorMsgTypeQuestion.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let validTypeQuestion = function () {
    validMsgTypeQuestion.classList.remove("invisible");
    errorMsgTypeQuestion.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
};

let notValidTypeQuestion = function () {
    validMsgTypeQuestion.classList.add("invisible");
    errorMsgTypeQuestion.classList.remove("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("error-input");
};

typeQuestion.addEventListener('click', resetTypeQuestion);
typeQuestion.addEventListener('blur', validationTypeQuestion);
typeQuestion.addEventListener('keyup', validationTypeQuestion);
typeQuestion.addEventListener('change', validationTypeQuestion);

bfh_selectbox_class.on('hide.bfhselectbox', function () {
    validationTypeQuestion();
});

function validationTypeQuestion() {
    resetTypeQuestion();

    typeQuestion.value = $(bfh_selectbox_class).val();
    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "") {
        notValidTypeQuestion();
    } else {
        validTypeQuestion();
    }
}


/* Checks for at least one error on the page */
submitBtn.addEventListener('click', function (event) {

    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "" || typeQuestion.classList.contains("error-input")) {
        event.preventDefault();
        notValidTypeQuestion();
        return false;
    }

});