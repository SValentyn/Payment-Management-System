<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="registration.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon-white.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/intlTelInput.css">
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<div class="main">
    <!-- Header -->
    <div class="header header-without-margin">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="logo">
                        <a href="/" onfocus="this.blur()">
                            <img src="resources/images/logo-white.png" alt="Logotype"/>
                        </a>
                        <h1>Payment Management System</h1>
                        <form class="language-form">
                            <select id="language" name="language" onchange="submit()" onfocus="this.blur()">
                                <option value="en" ${language == 'en' ? 'selected' : ''}>EN</option>
                                <option value="ru" ${language == 'ru' ? 'selected' : ''}>RU</option>
                                <option value="ua" ${language == 'ua' ? 'selected' : ''}>UA</option>
                            </select>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Alert Success -->
    <c:if test="${created == true}">
        <div id="alert" class="alert alert-success fade in" role="alert" style="width: 493px; margin-top: 22px;">
            <p><strong>Success!</strong> Account created. Try <a href="/" class="alert-link">logging</a>
                into your account.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert phoneExistError -->
    <c:if test="${phoneExistError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 466px; margin-top: 22px;">
            <p><strong>Failed!</strong> A user with such a phone is already registered.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert registrationError -->
    <c:if test="${registrationError == true}">
        <div id="alert" class="alert alert-danger fade in" role="alert" style="width: 494px; margin-top: 22px;">
            <p><strong>Failed!</strong> Sorry, but we were unable to register you. Try later.</p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="login-bg">
        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper" style="top: 22px;">
                        <div class="box" style="padding-bottom: 0;">
                            <div class="content-wrap">
                                <fmt:message key="registration.formHeader" var="registration"/>
                                <fmt:message key="registration.name" var="name"/>
                                <fmt:message key="registration.surname" var="surname"/>
                                <fmt:message key="registration.email" var="email"/>
                                <fmt:message key="registration.password" var="password"/>
                                <fmt:message key="registration.confirmation" var="confirmation"/>
                                <fmt:message key="registration.nameError" var="nameError"/>
                                <fmt:message key="registration.surnameError" var="surnameError"/>
                                <fmt:message key="registration.phoneError" var="phoneError"/>
                                <fmt:message key="registration.emailError" var="emailError"/>
                                <fmt:message key="registration.passwordError" var="passwordError"/>
                                <fmt:message key="registration.passwordConfirmationError"
                                             var="passwordConfirmationError"/>
                                <fmt:message key="registration.correct" var="correct"/>
                                <fmt:message key="registration.signupButton" var="signupButton"/>
                                <fmt:message key="registration.tooltipOnlyLetters" var="tooltipOnlyLetters"/>
                                <fmt:message key="registration.tooltipPhone" var="tooltipPhone"/>
                                <fmt:message key="registration.tooltipEmail" var="tooltipEmail"/>
                                <fmt:message key="registration.tooltipPassword" var="tooltipPassword"/>
                                <fmt:message key="registration.tooltipPasswordConfirmation"
                                             var="tooltipPasswordConfirmation"/>

                                <h4>
                                    ${registration}
                                </h4>

                                <form action="" role="form" method="POST">
                                    <input type="hidden" name="command" value="registration">

                                    <!-- Name -->
                                    <input id="name" name="name" class="form-control" style="height: 36px;"
                                           type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                           maxlength="24" placeholder="${name}*"
                                           value="${nameValue}"/>
                                    <label for="name" class="reg-error-label">
                                        <span id="valid-msg-name" class="hide">${correct} ✓</span>
                                        <span id="error-msg-name" class="hide">${nameError}</span>
                                    </label>

                                    <!-- Surname -->
                                    <input id="surname" name="surname" class="form-control" style="height: 36px;"
                                           type="text" data-toggle="tooltip" data-title="${tooltipOnlyLetters}"
                                           maxlength="24" placeholder="${surname}*"
                                           value="${surnameValue}">
                                    <label for="surname" class="reg-error-label">
                                        <span id="valid-msg-surname" class="hide">${correct} ✓</span>
                                        <span id="error-msg-surname" class="hide">${surnameError}</span>
                                    </label>

                                    <!-- Phone -->
                                    <input id="phone" name="phone" type="tel" class="form-control"
                                           style="height: 36px; padding-left: 94px;"
                                           data-toggle="tooltip" data-title="${tooltipPhone}"
                                           onkeypress="onlyNumbers()"
                                           value="${phoneValue}"/>
                                    <label for="phone" class="reg-error-label">
                                        <span id="valid-msg-phone" class="hide">${correct} ✓</span>
                                        <span id="error-msg-phone" class="hide">${phoneError}</span>
                                    </label>

                                    <!-- Email -->
                                    <input id="email" name="email" class="form-control" style="height: 36px;"
                                           type="email" data-toggle="tooltip" data-title="${tooltipEmail}"
                                           maxlength="45" placeholder="${email}"
                                           value="${emailValue}">
                                    <label for="email" class="reg-error-label">
                                        <span id="valid-msg-email" class="hide">${correct} ✓</span>
                                        <span id="error-msg-email" class="hide">${emailError}</span>
                                    </label>

                                    <!-- Password -->
                                    <input id="password" name="password" class="form-control" style="height: 36px;"
                                           type="password" data-toggle="tooltip" data-title="${tooltipPassword}"
                                           placeholder="${password}*"
                                           value=${passwordValue}>
                                    <label for="password" class="reg-error-label">
                                        <span id="valid-msg-password" class="hide">${correct} ✓</span>
                                        <span id="error-msg-password" class="hide">${passwordError}</span>
                                    </label>

                                    <!-- Password Confirmation -->
                                    <input id="passwordConfirmation" name="passwordConfirmation"
                                           class="form-control" style="height: 36px;" type="password"
                                           data-toggle="tooltip" data-title="${tooltipPasswordConfirmation}"
                                           placeholder="${confirmation}*"
                                           value=${passwordConfirmationValue}>
                                    <label for="passwordConfirmation" class="reg-error-label">
                                        <span id="valid-msg-passwordConfirmation" class="hide">${correct} ✓</span>
                                        <span id="error-msg-passwordConfirmation" class="hide">
                                            ${passwordConfirmationError}
                                        </span>
                                    </label>

                                    <!-- Submit -->
                                    <div class="action" style="padding: 25px 0 30px 0">
                                        <button id="submit" type="submit"
                                                class="btn btn-primary signup" onfocus="this.blur()">
                                            ${signupButton}
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="already">
                            <p><fmt:message key="registration.haveAccountAlready"/></p>
                            <a href="/" onfocus="this.blur()">
                                <fmt:message key="registration.login"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
<script>

    // Elements on page to check
    let name = document.querySelector("#name");
    let surname = document.querySelector("#surname");
    let phone = document.querySelector("#phone");
    let email = document.querySelector("#email");
    let password = document.querySelector("#password");
    let passwordConfirmation = document.querySelector("#passwordConfirmation");
    let submitBtn = document.querySelector("#submit");


    /* Checks name */
    let validMsgName = document.querySelector("#valid-msg-name"),
        errorMsgName = document.querySelector("#error-msg-name");

    let resetName = function () {
        validMsgName.classList.add("hide");
        errorMsgName.classList.add("hide");
        name.classList.remove("valid-input");
        name.classList.remove("error-input");
    };

    let validName = function () {
        validMsgName.classList.remove("hide");
        errorMsgName.classList.add("hide");
        name.classList.add("valid-input");
        name.classList.remove("error-input");
    };

    let notValidName = function () {
        validMsgName.classList.add("hide");
        errorMsgName.classList.remove("hide");
        name.classList.remove("valid-input");
        name.classList.add("error-input");
    };

    // on blur
    name.addEventListener('blur', function () {
        resetName();

        if (name.value.trim() === "") {
            notValidName();
        } else {
            if (name.value.trim().search(/[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}/) === -1) {
                notValidName();
            } else {
                validName();
            }
        }
    });

    // on keyup/change -> reset
    name.addEventListener('keyup', resetName);
    name.addEventListener('change', resetName);


    /* Checks surname */
    let validMsgSurname = document.querySelector("#valid-msg-surname"),
        errorMsgSurname = document.querySelector("#error-msg-surname");

    let resetSurname = function () {
        validMsgSurname.classList.add("hide");
        errorMsgSurname.classList.add("hide");
        surname.classList.remove("valid-input");
        surname.classList.remove("error-input");
    };

    let validSurname = function () {
        validMsgSurname.classList.remove("hide");
        errorMsgSurname.classList.add("hide");
        surname.classList.add("valid-input");
        surname.classList.remove("error-input");
    };

    let notValidSurname = function () {
        validMsgSurname.classList.add("hide");
        errorMsgSurname.classList.remove("hide");
        surname.classList.remove("valid-input");
        surname.classList.add("error-input");
    };

    // on blur
    surname.addEventListener('blur', function () {
        resetSurname();

        if (surname.value.trim() === "") {
            notValidSurname();
        } else {
            if (surname.value.trim().search(/[a-zA-Zа-яА-ЯёЁїЇ ]{1,24}/) === -1) {
                notValidSurname();
            } else {
                validSurname();
            }
        }
    });

    // on keyup/change -> reset
    surname.addEventListener('keyup', resetSurname);
    surname.addEventListener('change', resetSurname);


    /* Configuring the phone number input field.
    * "token" must be obtained on the api website */
    let iti = window.intlTelInput(phone, {
        separateDialCode: true,
        hiddenInput: "full_phone",
        initialCountry: "auto",
        geoIpLookup: function (callback) {
            $.get('http://ipinfo.io/?token=b3f3eb675dab44', function () {
            }, "jsonp").always(function (resp) {
                let countryCode = (resp && resp.country) ? resp.country : "";
                callback(countryCode);
            });
        },
    });


    /* Checks phone number */
    let validMsgPhone = document.querySelector("#valid-msg-phone"),
        errorMsgPhone = document.querySelector("#error-msg-phone");

    let resetPhone = function () {
        validMsgPhone.classList.add("hide");
        errorMsgPhone.classList.add("hide");
        phone.classList.remove("valid-input");
        phone.classList.remove("error-input");
    };

    let validPhone = function () {
        validMsgPhone.classList.remove("hide");
        errorMsgPhone.classList.add("hide");
        phone.classList.add("valid-input");
        phone.classList.remove("error-input");
    };

    let notValidPhone = function () {
        validMsgPhone.classList.add("hide");
        errorMsgPhone.classList.remove("hide");
        phone.classList.remove("valid-input");
        phone.classList.add("error-input");
    };

    // on blur
    phone.addEventListener('blur', function () {
        resetPhone();

        if (phone.value.trim() === "") {
            notValidPhone();
        } else if (phone.value.trim()) {
            if (iti.isValidNumber()) {
                validPhone();
            } else {
                notValidPhone();
            }
        }
    });

    // on keyup/change -> reset
    phone.addEventListener('keyup', resetPhone);
    phone.addEventListener('change', resetPhone);


    /* Checks email */
    let validMsgEmail = document.querySelector("#valid-msg-email"),
        errorMsgEmail = document.querySelector("#error-msg-email");

    let resetEmail = function () {
        validMsgEmail.classList.add("hide");
        errorMsgEmail.classList.add("hide");
        email.classList.remove("valid-input");
        email.classList.remove("error-input");
    };

    let validEmail = function () {
        validMsgEmail.classList.remove("hide");
        errorMsgEmail.classList.add("hide");
        email.classList.add("valid-input");
        email.classList.remove("error-input");
    };

    let notValidEmail = function () {
        validMsgEmail.classList.add("hide");
        errorMsgEmail.classList.remove("hide");
        email.classList.remove("valid-input");
        email.classList.add("error-input");
    };

    // on blur
    email.addEventListener('blur', function () {
        resetEmail();

        if (email.value.trim() !== "") {
            if (email.value.trim().search(/[a-zA-Z0-9._-]+@[a-z0-9.-]+.[a-z]{2,}$/) === -1) {
                notValidEmail();
            } else {
                validEmail();
            }
        }
    });

    // on keyup/change -> reset
    email.addEventListener('keyup', resetEmail);
    email.addEventListener('change', resetEmail);


    /* Checks password */
    let validMsgPassword = document.querySelector("#valid-msg-password"),
        errorMsgPassword = document.querySelector("#error-msg-password");

    let resetPassword = function () {
        validMsgPassword.classList.add("hide");
        errorMsgPassword.classList.add("hide");
        password.classList.remove("valid-input");
        password.classList.remove("error-input");
    };

    let validPassword = function () {
        validMsgPassword.classList.remove("hide");
        errorMsgPassword.classList.add("hide");
        password.classList.add("valid-input");
        password.classList.remove("error-input");
    };

    let notValidPassword = function () {
        validMsgPassword.classList.add("hide");
        errorMsgPassword.classList.remove("hide");
        password.classList.remove("valid-input");
        password.classList.add("error-input");
    };

    // on blur
    password.addEventListener('blur', function () {
        resetPassword();

        if (password.value.trim() === "") {
            notValidPassword();
        } else {
            if (password.value.trim().length < 6) {
                notValidPassword();
            } else {
                validPassword();
            }
        }
    });

    // on keyup/change -> reset
    password.addEventListener('keyup', resetPassword);
    password.addEventListener('change', resetPassword);


    /* Checks password confirmation */
    let validMsgPasswordConfirmation = document.querySelector("#valid-msg-passwordConfirmation"),
        errorMsgPasswordConfirmation = document.querySelector("#error-msg-passwordConfirmation");

    let resetPasswordConfirmation = function () {
        validMsgPasswordConfirmation.classList.add("hide");
        errorMsgPasswordConfirmation.classList.add("hide");
        passwordConfirmation.classList.remove("valid-input");
        passwordConfirmation.classList.remove("error-input");
    };

    let validPasswordConfirmation = function () {
        validMsgPasswordConfirmation.classList.remove("hide");
        errorMsgPasswordConfirmation.classList.add("hide");
        passwordConfirmation.classList.add("valid-input");
        passwordConfirmation.classList.remove("error-input");
    };

    let notValidPasswordConfirmation = function () {
        validMsgPasswordConfirmation.classList.add("hide");
        errorMsgPasswordConfirmation.classList.remove("hide");
        passwordConfirmation.classList.remove("valid-input");
        passwordConfirmation.classList.add("error-input");
    };

    // on blur
    passwordConfirmation.addEventListener('blur', function () {
        resetPasswordConfirmation();

        if (passwordConfirmation.value.trim() === "") {
            notValidPasswordConfirmation();
        } else {
            if (passwordConfirmation.value.trim() === password.value.trim()) {
                validPasswordConfirmation();
            } else {
                notValidPasswordConfirmation();
            }
        }
    });

    // on keyup/change -> reset
    passwordConfirmation.addEventListener('keyup', resetPasswordConfirmation);
    passwordConfirmation.addEventListener('change', resetPasswordConfirmation);


    /* Checks for at least one error on the page */
    submitBtn.addEventListener('click', function (event) {
        if (name.value.trim() === "" ||
            surname.value.trim() === "" ||
            phone.value.trim() === "" ||
            password.value.trim() === "" ||
            passwordConfirmation.value.trim() === "" ||
            name.classList.contains("error-input") ||
            surname.classList.contains("error-input") ||
            phone.classList.contains("error-input") ||
            email.classList.contains("error-input") ||
            password.classList.contains("error-input") ||
            passwordConfirmation.classList.contains("error-input")
        ) event.preventDefault();
    });

</script>
</body>
</html>