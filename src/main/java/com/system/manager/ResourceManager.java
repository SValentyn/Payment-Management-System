package com.system.manager;

import java.util.ResourceBundle;

/**
 * Resource manager for dealing with redirect paths
 */
public class ResourceManager {

    // *************************
    // UNREGISTERED USER'S PAGES
    // *************************
    public static final String INDEX = "INDEX";
    public static final String REGISTRATION = "REGISTRATION";
    public static final String RECOVERY = "RECOVERY";
    public static final String ERROR = "ERROR";
    // ************
    // USER'S PAGES
    // ************
    public static final String USER = "USER";
    public static final String USER_UPDATE_DATA = "USER_UPDATE_PERSONAL_DATA";
    public static final String USER_UPDATE_PASSWORD = "USER_UPDATE_PASSWORD";
    public static final String USER_SHOW_ACCOUNTS = "USER_SHOW_ACCOUNTS";
    public static final String USER_SHOW_PAYMENTS = "USER_SHOW_PAYMENTS";
    public static final String USER_SHOW_ACCOUNT_SETTINGS = "USER_SHOW_ACCOUNT_SETTINGS";
    public static final String USER_SHOW_ACCOUNT_CARDS = "USER_SHOW_ACCOUNT_CARDS";
    public static final String USER_SHOW_ACCOUNT_PAYMENTS = "USER_SHOW_ACCOUNT_PAYMENTS";
    public static final String USER_SHOW_PAYMENT_INFO = "USER_SHOW_PAYMENT_INFO";
    public static final String USER_CREATE_ACCOUNT = "USER_CREATE_ACCOUNT";
    public static final String USER_ATTACH_CARD = "USER_ATTACH_CARD";
    public static final String USER_MAKE_PAYMENT = "USER_MAKE_PAYMENT";
    public static final String USER_SUPPORT = "USER_SUPPORT";
    // *************
    // ADMIN'S PAGES
    // *************
    public static final String ADMIN = "ADMIN";
    public static final String ADMIN_UPDATE_DATA = "ADMIN_UPDATE_PERSONAL_DATA";
    public static final String ADMIN_UPDATE_PASSWORD = "ADMIN_UPDATE_PASSWORD";
    public static final String ADMIN_SHOW_ACCOUNTS = "ADMIN_SHOW_ACCOUNTS";
    public static final String ADMIN_SHOW_USER = "ADMIN_SHOW_USER";
    public static final String ADMIN_UPDATE_USER_DATA = "ADMIN_UPDATE_USER_DATA";
    public static final String ADMIN_SHOW_USER_PAYMENTS = "ADMIN_SHOW_USER_PAYMENTS";
    public static final String ADMIN_SHOW_PAYMENT_INFO = "ADMIN_SHOW_PAYMENT_INFO";
    public static final String ADMIN_SHOW_USER_ACCOUNTS = "ADMIN_SHOW_USER_ACCOUNTS";
    public static final String ADMIN_SHOW_ACCOUNT_INFO = "ADMIN_SHOW_ACCOUNT_INFO";
    public static final String ADMIN_ADD_USER = "ADMIN_ADD_USER";
    public static final String ADMIN_ATTACH_ACCOUNT = "ADMIN_ATTACH_ACCOUNT";
    public static final String ADMIN_SUPPORT = "ADMIN_SUPPORT";
    public static final String ADMIN_SHOW_LETTER_INFO = "ADMIN_SHOW_LETTER_INFO";
    // ****************************
    // UNREGISTERED USER'S COMMANDS
    // ****************************
    public static final String COMMAND_INDEX = "COMMAND_INDEX";
    public static final String COMMAND_RECOVERY = "COMMAND_RECOVERY";
    public static final String COMMAND_REGISTRATION = "COMMAND_REGISTRATION";
    // ***************
    // USER'S COMMANDS
    // ***************
    public static final String COMMAND_USER_UPDATE_DATA = "COMMAND_USER_UPDATE_PERSONAL_DATA";
    public static final String COMMAND_USER_UPDATE_PASSWORD = "COMMAND_USER_UPDATE_PASSWORD";
    public static final String COMMAND_USER_SHOW_ACCOUNTS = "COMMAND_USER_SHOW_ACCOUNTS";
    public static final String COMMAND_USER_SHOW_PAYMENTS = "COMMAND_USER_SHOW_PAYMENTS";
    public static final String COMMAND_USER_SHOW_ACCOUNT_SETTINGS = "COMMAND_USER_SHOW_ACCOUNT_SETTINGS";
    public static final String COMMAND_USER_SHOW_ACCOUNT_CARDS = "COMMAND_USER_SHOW_ACCOUNT_CARDS";
    public static final String COMMAND_USER_SHOW_ACCOUNT_PAYMENTS = "COMMAND_USER_SHOW_ACCOUNT_PAYMENTS";
    public static final String COMMAND_USER_SHOW_PAYMENT_INFO = "COMMAND_USER_SHOW_PAYMENT_INFO";
    public static final String COMMAND_USER_CREATE_ACCOUNT = "COMMAND_USER_CREATE_ACCOUNT";
    public static final String COMMAND_USER_ATTACH_CARD = "COMMAND_USER_ATTACH_CARD";
    public static final String COMMAND_USER_MAKE_PAYMENT = "COMMAND_USER_MAKE_PAYMENT";
    public static final String COMMAND_USER_SUPPORT = "COMMAND_USER_SUPPORT";
    // ****************
    // ADMIN'S COMMANDS
    // ****************
    public static final String COMMAND_ADMIN_UPDATE_DATA = "COMMAND_ADMIN_UPDATE_PERSONAL_DATA";
    public static final String COMMAND_ADMIN_UPDATE_PASSWORD = "COMMAND_ADMIN_UPDATE_PASSWORD";
    public static final String COMMAND_ADMIN_SHOW_ACCOUNTS = "COMMAND_ADMIN_SHOW_ACCOUNTS";
    public static final String COMMAND_ADMIN_SHOW_USER = "COMMAND_ADMIN_SHOW_USER";
    public static final String COMMAND_ADMIN_UPDATE_USER_DATA = "COMMAND_ADMIN_UPDATE_USER_DATA";
    public static final String COMMAND_ADMIN_SHOW_USER_PAYMENTS = "COMMAND_ADMIN_SHOW_USER_PAYMENTS";
    public static final String COMMAND_ADMIN_SHOW_PAYMENT_INFO = "COMMAND_ADMIN_SHOW_PAYMENT_INFO";
    public static final String COMMAND_ADMIN_SHOW_USER_ACCOUNTS = "COMMAND_ADMIN_SHOW_USER_ACCOUNTS";
    public static final String COMMAND_ADMIN_SHOW_ACCOUNT_INFO = "COMMAND_ADMIN_SHOW_ACCOUNT_INFO";
    public static final String COMMAND_ADMIN_ADD_USER = "COMMAND_ADMIN_ADD_USER";
    public static final String COMMAND_ADMIN_ATTACH_ACCOUNT = "COMMAND_ADMIN_ATTACH_ACCOUNT";
    public static final String COMMAND_ADMIN_SUPPORT = "COMMAND_ADMIN_SUPPORT";
    public static final String COMMAND_ADMIN_SHOW_LETTER_INFO = "COMMAND_ADMIN_SHOW_LETTER_INFO";

    // Configuration file name
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
