package com.system.manager;

/**
 * Enum that stores HTTP protocol method constants
 */
public enum HTTPMethod {

    GET("GET"),
    POST("POST"),
    PUT("PUT"),
    DELETE("DELETE");

    private final String method;

    HTTPMethod(String method) {
        this.method = method;
    }

    public String getMethod() {
        return method;
    }

}
