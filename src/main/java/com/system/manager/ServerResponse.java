package com.system.manager;

public enum ServerResponse {

    LOGIN_NOT_EXIST("loginNotExist"),
    INVALID_LOGIN_DATA("invalidLoginData"),
    AUTHENTICATION_ERROR("authenticationError"),
    INCORRECT_REGISTRATION_DATA("incorrectRegistrationData"),
    PHONE_EXIST_ERROR("phoneExistError"),
    EMAIL_EXIST_ERROR("emailExistError"),
    REGISTRATION_ERROR("registrationError"),
    REGISTRATION_SUCCESS("registrationSuccess"),
    PASSWORD_SENT("passwordSent"),
    SHOW_USER_ERROR("showUserError");

    private String response;

    ServerResponse(String response) {
        this.response = response;
    }

    public String getResponse() {
        return response;
    }

}
