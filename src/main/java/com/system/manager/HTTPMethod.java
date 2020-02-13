package com.system.manager;

/**
 * Enum that stores HTTP protocol method constants
 */
public enum HTTPMethod {

    GET("GET"),
    POST("POST");

    private String method;

    HTTPMethod(String method) {
        this.method = method;
    }

    public String getMethod() {
        return method;
    }

}
