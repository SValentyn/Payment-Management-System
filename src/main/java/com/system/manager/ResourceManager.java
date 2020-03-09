package com.system.manager;

import java.util.ResourceBundle;

/**
 * Resource manager for dealing with pages path
 */
public class ResourceManager {

    // ALL
    public static final String INDEX = "INDEX";
    public static final String REGISTRATION = "REGISTRATION";
    public static final String RECOVERY = "RECOVERY";
    public static final String ERROR = "ERROR";
    // USER
    public static final String USER = "USER";
    public static final String USER_SHOW_ACCOUNTS = "USER_SHOW_ACCOUNTS";
    public static final String USER_SHOW_PAYMENTS = "USER_SHOW_PAYMENTS";
    public static final String USER_UPDATE_DATA = "USER_UPDATE_DATA";
    public static final String USER_UPDATE_PASSWORD = "USER_UPDATE_PASSWORD";
    public static final String USER_CREATE_ACCOUNT = "USER_CREATE_ACCOUNT";
    public static final String USER_MAKE_PAYMENT = "USER_MAKE_PAYMENT";
    public static final String USER_ATTACH_CARD = "USER_ATTACH_CARD";
    public static final String USER_SUPPORT = "USER_SUPPORT";
    // ADMIN
    public static final String ADMIN = "ADMIN";
    public static final String ADMIN_UPDATE_DATA = "ADMIN_UPDATE_DATA";
    public static final String ADMIN_UPDATE_PASSWORD = "ADMIN_UPDATE_PASSWORD";
    public static final String ADMIN_ACCOUNTS_CONTROL = "ADMIN_ACCOUNTS_CONTROL";
    public static final String ADMIN_UPDATE_USER_DATA = "ADMIN_UPDATE_USER_DATA";
    public static final String ADMIN_ATTACH_ACCOUNT = "ADMIN_ATTACH_ACCOUNT";
    public static final String ADMIN_ATTACH_CARD = "ADMIN_ATTACH_CARD";
    public static final String ADMIN_ADD_USER = "ADMIN_ADD_USER";
    public static final String ADMIN_SUPPORT = "ADMIN_SUPPORT";
    public static final String ADMIN_LETTER_INFO = "ADMIN_LETTER_INFO";

    private final static String BUNDLE_NAME = "configuration"; // Configuration file name
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
