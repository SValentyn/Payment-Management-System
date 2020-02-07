package com.system.manager;

import java.util.ResourceBundle;

/**
 * Resource manager for dealing with pages path
 */
public class ResourceManager {

    // Configuration file name
    private final static String BUNDLE_NAME = "configuration";
    // ALL
    public static final String INDEX = "INDEX";
    public static final String REGISTRATION = "REGISTRATION";
    public static final String ERROR = "ERROR";
    // USER
    public static final String USER = "USER";
    public static final String USER_CHANGE_DATA = "USER_CHANGE_DATA";
    public static final String USER_CHANGE_PASSWORD = "USER_CHANGE_PASSWORD";
    public static final String USER_CREATE_ACCOUNT = "USER_CREATE_ACCOUNT";
    public static final String USER_MAKE_PAYMENT = "USER_MAKE_PAYMENT";
    public static final String USER_ADD_CARD = "USER_ADD_CARD";
    public static final String USER_SUPPORT = "USER_SUPPORT";
    // ADMIN
    public static final String ADMIN = "ADMIN";
    public static final String ADMIN_CHANGE_DATA = "ADMIN_CHANGE_DATA";
    public static final String ADMIN_CHANGE_PASSWORD = "ADMIN_CHANGE_PASSWORD";
    public static final String ACCOUNTS_CONTROL = "ADMIN_ACCOUNTS_CONTROL";
    public static final String ADMIN_CREATE_ACCOUNT = "ADMIN_CREATE_ACCOUNT";
    public static final String ADMIN_ADD_CARD = "ADMIN_ADD_CARD";
    public static final String ADMIN_ADD_USER = "ADMIN_ADD_USER";
    public static final String ADMIN_SUPPORT = "ADMIN_SUPPORT";
    public static final String LETTER_INFO = "ADMIN_LETTER_INFO";

    private static ResourceManager instance;
    private ResourceBundle resourceBundle;

    private ResourceManager() {
    }

    public static synchronized ResourceManager getInstance() {
        if (instance == null) {
            instance = new ResourceManager();
            instance.resourceBundle = ResourceBundle.getBundle(BUNDLE_NAME);
        }
        return instance;
    }

    /**
     * Getting property from Resource Bundle by key
     */
    public String getProperty(String key) {
        return (String) resourceBundle.getObject(key);
    }

}
