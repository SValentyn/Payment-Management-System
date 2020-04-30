package com.system.manager;

public enum ServerResponse {

    INVALID_DATA("invalidData"),
    LOGIN_NOT_EXIST("loginNotExist"),
    AUTHENTICATION_ERROR("authenticationError"),
    REGISTRATION_SUCCESS("registrationSuccess"),
    REGISTRATION_ERROR("registrationError"),
    PASSWORD_SENT("passwordSent"),
    UNABLE_GET_USER("unableGetUser"),
    SHOW_USER_ERROR("showUserError"),
    ADD_USER_SUCCESS("addUserSuccess"),
    ADD_USER_ERROR("addUserError"),
    UNABLE_GET_USER_ID("unableGetUserId"),
    UNABLE_GET_USER_BY_USER_ID("unableGetUserByUserId"),
    ACCOUNT_CREATED_SUCCESS("accountCreatedSuccess"),
    MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR("manyAccountWithThisCurrencyError"),
    ACCOUNT_CREATED_ERROR("accountCreatedError"),
    ACCOUNT_ATTACHED_SUCCESS("accountAttachedSuccess"),
    ACCOUNT_ATTACHED_ERROR("accountAttachError"),
    DATA_UPDATED_SUCCESS("dataUpdatedSuccess"),
    PASSWORD_NOT_MATCH_ERROR("passwordNotMatchError"),
    PHONE_EXIST_ERROR("phoneExistError"),
    EMAIL_EXIST_ERROR("emailExistError"),
    DATA_UPDATED_ERROR("dataUpdatedError"),
    PASSWORD_UPDATED_SUCCESS("passwordUpdatedSuccess"),
    OLD_PASSWORD_ERROR("oldPasswordError"),
    NEW_PASSWORD_ERROR("newPasswordError"),
    PASSWORD_UPDATED_ERROR("passwordUpdatedError"),
    USER_DELETED_SUCCESS("userDeletedSuccess"),
    USER_HAS_FUNDS_ERROR("userHasFundsError"),
    USER_DELETED_ERROR("userDeletedError"),
    SHOW_USER_PAYMENTS_ERROR("showUserPaymentsError"),
    SHOW_USER_ACCOUNTS_ERROR("showUserAccountsError"),
    UNABLE_GET_ACCOUNT_ID("unableGetAccountId"),
    UNABLE_GET_ACCOUNT_BY_USER_ID("unableGetAccountByUserId"),
    UNABLE_GET_CARD_ID("unableGetCardId"),
    UNABLE_GET_CARD("unableGetCard"),
    SHOW_ACCOUNT_ERROR("showAccountError"),
    ACCOUNT_BLOCKED_ERROR("accountBlockedError"),
    ACCOUNT_UNBLOCKED_ERROR("accountUnblockedError"),
    ACCOUNT_DELETED_SUCCESS("accountDeletedSuccess"),
    ACCOUNT_HAS_FUNDS_ERROR("accountHasFundsError"),
    ACCOUNT_DELETED_ERROR("accountDeletedError"),
    CARD_BLOCKED_SUCCESS("cardBlockedSuccess"),
    CARD_BLOCKED_ERROR("cardBlockedError"),
    CARD_UNBLOCKED_SUCCESS("cardUnblockedSuccess"),
    CARD_UNBLOCKED_ERROR("cardUnblockedError"),
    CARD_ATTACHED_SUCCESS("cardAttachedSuccess"),
    VALIDITY_EXPIRED_ERROR("validityExpiredError"),
    CARD_ALREADY_ATTACHED_ERROR("cardAlreadyAttachedError"),
    CARD_ATTACHED_ERROR("cardAttachedError"),
    CARD_DETACHED_SUCCESS("cardDetachedSuccess"),
    CARD_DETACHED_ERROR("cardDetachedError"),
    UNABLE_GET_PAYMENT_ID("unableGetPaymentId"),
    UNABLE_GET_PAYMENT_BY_USER_ID("unableGetPaymentByUserId"),
    SHOW_PAYMENT_ERROR("showPaymentError"),
    SHOW_LETTERS_ERROR("showLettersError"),
    UNABLE_GET_LETTER_ID("unableGetLetterId"),
    SHOW_LETTER_ERROR("showLetterError"),
    LETTER_PROCESSED_SUCCESS("letterProcessedSuccess"),
    LETTER_WAS_PROCESSED("letterWasProcessed"),
    LETTER_PROCESSED_ERROR("letterProcessedError"),
    LETTER_SENT_SUCCESS("letterSentSuccess"),
    MANY_LETTERS_SENT_ERROR("manyLettersSentError"),
    LETTER_SENT_ERROR("letterSentError");

    private final String response;

    ServerResponse(String response) {
        this.response = response;
    }

    public String getResponse() {
        return response;
    }

}
