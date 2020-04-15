package com.system.manager;

public enum ServerResponse {

    INVALID_DATA("invalidData"),
    LOGIN_NOT_EXIST("loginNotExist"),
    AUTHENTICATION_ERROR("authenticationError"),
    PHONE_EXIST_ERROR("phoneExistError"),
    EMAIL_EXIST_ERROR("emailExistError"),
    REGISTRATION_ERROR("registrationError"),
    REGISTRATION_SUCCESS("registrationSuccess"),
    PASSWORD_SENT("passwordSent"),
    SHOW_USER_ERROR("showUserError"),
    ADD_USER_SUCCESS("addUserSuccess"),
    ADD_USER_ERROR("addUserError"),
    UNABLE_GET_USER_ID("unableGetUserId"),
    MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR("manyAccountWithThisCurrencyError"),
    ACCOUNT_ATTACHED_SUCCESS("accountAttachedSuccess"),
    ACCOUNT_ATTACHED_ERROR("accountAttachError"),
    DATA_UPDATED_SUCCESS("dataUpdatedSuccess"),
    DATA_UPDATED_ERROR("dataUpdatedError");

    private final String response;

    ServerResponse(String response) {
        this.response = response;
    }

    public String getResponse() {
        return response;
    }

}
