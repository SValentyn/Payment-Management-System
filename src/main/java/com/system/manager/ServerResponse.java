package com.system.manager;

public enum ServerResponse {

    LOGIN_NOT_EXIST("loginNotExist"),
    INVALID_LOGIN_DATA("invalidLoginData"),
    AUTHENTICATION_ERROR("authenticationError"),
    PASSWORD_SENT("passwordSent");

    private String response;

    ServerResponse(String response) {
        this.response = response;
    }

    public String getResponse() {
        return response;
    }

}
