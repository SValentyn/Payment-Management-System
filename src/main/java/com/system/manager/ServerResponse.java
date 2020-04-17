package com.system.manager;

public enum ServerResponse {

    INVALID_DATA("invalidData"),
    LOGIN_NOT_EXIST("loginNotExist"),
    AUTHENTICATION_ERROR("authenticationError"),
    PHONE_EXIST_ERROR("phoneExistError"),
    EMAIL_EXIST_ERROR("emailExistError"),
    REGISTRATION_SUCCESS("registrationSuccess"),
    REGISTRATION_ERROR("registrationError"),
    PASSWORD_SENT("passwordSent"),
    SHOW_USER_ERROR("showUserError"),
    ADD_USER_SUCCESS("addUserSuccess"),
    ADD_USER_ERROR("addUserError"),
    UNABLE_GET_USER_ID("unableGetUserId"),
    ACCOUNT_ATTACHED_SUCCESS("accountAttachedSuccess"),
    MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR("manyAccountWithThisCurrencyError"),
    ACCOUNT_ATTACHED_ERROR("accountAttachError"),
    DATA_UPDATED_SUCCESS("dataUpdatedSuccess"),
    DATA_UPDATED_ERROR("dataUpdatedError"),
    USER_DELETED_SUCCESS("userDeletedSuccess"),
    USER_HAS_FUNDS_ERROR("userHasFundsError"),
    USER_DELETED_ERROR("userDeletedError"),
    SHOW_USER_PAYMENTS_ERROR("showUserPaymentsError"),
    SHOW_USER_ACCOUNTS_ERROR("showUserAccountsError"),
    UNABLE_GET_ACCOUNT_ID("unableGetAccountId"),
    SHOW_ACCOUNT_ERROR("showAccountError"),
    ACCOUNT_BLOCKED_ERROR("accountBlockedError"),
    ACCOUNT_UNBLOCKED_ERROR("accountUnblockedError"),
    ACCOUNT_DELETED_SUCCESS("accountDeletedSuccess"),
    ACCOUNT_HAS_FUNDS_ERROR("accountHasFundsError"),
    ACCOUNT_DELETED_ERROR("accountDeletedError"),
    CARD_BLOCKED_SUCCESS("cardBlockedSuccess"),
    CARD_BLOCKED_ERROR("cardBlockedError"),
    SHOW_LETTERS_ERROR("showLettersError"),
    UNABLE_GET_LETTER_ID("unableGetLetterId"),
    SHOW_LETTER_ERROR("showLetterError"),
    LETTER_PROCESSED_SUCCESS("letterProcessedSuccess"),
    LETTER_WAS_PROCESSED("letterWasProcessed"),
    LETTER_PROCESSED_ERROR("letterProcessedError");

    private final String response;

    ServerResponse(String response) {
        this.response = response;
    }

    public String getResponse() {
        return response;
    }

}
