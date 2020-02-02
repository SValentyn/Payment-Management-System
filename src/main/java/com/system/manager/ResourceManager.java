package com.system.manager;

import java.util.ResourceBundle;

/**
 * Resource manager for dealing with pages path
 */
public class ResourceManager {

    public static final String INDEX = "INDEX";
    public static final String REGISTRATION = "REGISTRATION";
    public static final String HOME = "HOME";
    public static final String ADMIN = "ADMIN";
    public static final String ERROR = "ERROR";
    public static final String ACCOUNTS_CONTROL = "ACCOUNTS_CONTROL";
    public static final String CREATE_ACCOUNT = "CREATE_ACCOUNT";
    public static final String CHANGE_DATA = "CHANGE_DATA";
    public static final String MAKE_PAYMENT = "MAKE_PAYMENT";
    public static final String ADD_CARD = "ADD_CARD";
    public static final String ADD_USER = "ADD_USER";
    private final static String BUNDLE_NAME = "configuration";

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
