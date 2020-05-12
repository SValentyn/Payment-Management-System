// Elements on userSupport.jsp page to check
let bfh_selectbox_class = $('.bfh-selectbox');
let typeQuestion = document.querySelector("#typeQuestion");
let submitBtn = document.querySelector("#submit");


/* Type question validation */
let validMsgTypeQuestion = document.querySelector("#valid-msg-typeQuestion"),
    errorMsgTypeQuestion = document.querySelector("#error-msg-typeQuestion");

function resetTypeQuestion() {
    validMsgTypeQuestion.classList.add("invisible");
    errorMsgTypeQuestion.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
}

function validTypeQuestion() {
    validMsgTypeQuestion.classList.remove("invisible");
    errorMsgTypeQuestion.classList.add("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("error-input");
}

function notValidTypeQuestion() {
    validMsgTypeQuestion.classList.add("invisible");
    errorMsgTypeQuestion.classList.remove("invisible");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.remove("valid-input");
    document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.add("error-input");
}

bfh_selectbox_class.on('hide.bfhselectbox', () => validationTypeQuestion());

typeQuestion.addEventListener('click', resetTypeQuestion);
typeQuestion.addEventListener('blur', validationTypeQuestion);
typeQuestion.addEventListener('keyup', validationTypeQuestion);
typeQuestion.addEventListener('change', validationTypeQuestion);

function validationTypeQuestion() {
    resetTypeQuestion();

    typeQuestion.value = $(bfh_selectbox_class).val();
    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "") {
        notValidTypeQuestion();
    } else {
        validTypeQuestion();
    }
}


/* Checks for errors on the page */
submitBtn.addEventListener('click', (event) => {

    validationTypeQuestion();
    if (document.querySelector(".bfh-selectbox .bfh-selectbox-toggle").classList.contains("error-input")) {
        event.preventDefault();
        notValidTypeQuestion();
        return false;
    }

});