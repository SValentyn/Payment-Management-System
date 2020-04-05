package com.system.manager;

public enum ServerResponse {

    INVALID_LOGIN_DATA("invalidLoginData"),
    AUTHENTICATION_ERROR("authenticationError");

    private String response;

    ServerResponse(String response) {
        this.response = response;
    }

    public String getResponse() {
        return response;
    }
}
