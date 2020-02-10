// Elements on userSupport.jsp page to check
let typeQuestion = document.querySelector("#typeQuestion");
let submitBtn = document.querySelector("#submit");


/* Checks TypeQuestion */
let validMsgTypeQuestion = document.querySelector("#valid-msg-typeQuestion"),
    errorMsgTypeQuestion = document.querySelector("#error-msg-typeQuestion");

let resetTypeQuestion = function () {
    validMsgTypeQuestion.classList.add("hide");
    errorMsgTypeQuestion.classList.add("hide");
    typeQuestion.classList.remove("valid-input");
    typeQuestion.classList.remove("error-input");
};

let validTypeQuestion = function () {
    validMsgTypeQuestion.classList.remove("hide");
    errorMsgTypeQuestion.classList.add("hide");
    typeQuestion.classList.add("valid-input");
    typeQuestion.classList.remove("error-input");
};

let notValidTypeQuestion = function () {
    validMsgTypeQuestion.classList.add("hide");
    errorMsgTypeQuestion.classList.remove("hide");
    typeQuestion.classList.remove("valid-input");
    typeQuestion.classList.add("error-input");
};

// on blur
typeQuestion.addEventListener('blur', function () {
    resetTypeQuestion();

    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "0") {
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

    if (typeQuestion.value.trim() === null || typeQuestion.value.trim() === "0" || typeQuestion.classList.contains("error-input")) {
        event.preventDefault();
        notValidTypeQuestion();
        return false;
    }

});