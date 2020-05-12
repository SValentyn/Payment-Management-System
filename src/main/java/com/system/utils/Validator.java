package com.system.utils;

import com.system.entity.*;
import com.system.service.*;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Class for validation input parameters from a form
 */
public class Validator {

    private static final Logger LOGGER = LogManager.getLogger(Validator.class);

    /**
     * @return true, if the login is not NULL and its length is in the range of 6 to 18 digits
     * and also if it in the system
     */
    public static boolean checkLogin(String login) throws SQLException {
        if (login == null) return false;
        Pattern p = Pattern.compile(".{6,18}");
        Matcher m = p.matcher(login);
        if (!m.matches()) return false;

        List<User> users = UserService.getInstance().findAllUsers();
        List<String> userLogins = new ArrayList<>();
        for (User user : users) {
            userLogins.add(user.getPhone());
        }

        return userLogins.contains(login);
    }

    /**
     * @return true, if the identifier is a non-negative number
     * and user found by identifier is not an admin
     */
    public static boolean checkUserIsAdmin(String userId) throws SQLException {
        if (!checkUserId(userId)) return false;

        User user = UserService.getInstance().findUserById(Integer.valueOf(userId));
        return !user.getRole().getRolename().equals("admin");
    }

    /**
     * @return true, if the identifier is a non-negative number and is in the system
     */
    public static boolean checkUserId(String userId) throws SQLException {
        if (userId == null || isNegative(userId)) return false;

        List<User> users = UserService.getInstance().findAllUsers();
        List<Integer> userIds = new ArrayList<>();
        for (User user : users) {
            userIds.add(user.getUserId());
        }

        return userIds.contains(Integer.valueOf(userId));
    }

    /**
     * @return true, if the identifier is a non-negative number and is in the system
     */
    public static boolean checkAccountId(String accountId) throws SQLException {
        if (accountId == null || isNegative(accountId)) return false;

        List<Account> accounts = AccountService.getInstance().findAllAccounts();
        List<Integer> accountIds = new ArrayList<>();
        for (Account account : accounts) {
            accountIds.add(account.getAccountId());
        }

        return accountIds.contains(Integer.valueOf(accountId));
    }

    /**
     * @return true, if the identifier is a non-negative number and is in the system
     */
    public static boolean checkCardId(String cardId) throws SQLException {
        if (cardId == null || isNegative(cardId)) return false;

        List<BankCard> cards = BankCardService.getInstance().findAllCards();
        List<Integer> cardIds = new ArrayList<>();
        for (BankCard card : cards) {
            cardIds.add(card.getCardId());
        }

        return cardIds.contains(Integer.valueOf(cardId));
    }

    /**
     * @return true, if the identifier is a non-negative number and is in the system
     */
    public static boolean checkPaymentId(String paymentId) throws SQLException {
        if (paymentId == null || isNegative(paymentId)) return false;

        List<Payment> payments = PaymentService.getInstance().findAllPayments();
        List<Integer> paymentIds = new ArrayList<>();
        for (Payment payment : payments) {
            paymentIds.add(payment.getPaymentId());
        }

        return paymentIds.contains(Integer.valueOf(paymentId));
    }

    /**
     * @return true, if the identifier is a non-negative number and is in the system
     */
    public static boolean checkLetterId(String letterId) throws SQLException {
        if (letterId == null || isNegative(letterId)) return false;

        List<Letter> letters = LetterService.getInstance().findAllLetters();
        List<Integer> letterIds = new ArrayList<>();
        for (Letter letter : letters) {
            letterIds.add(letter.getLetterId());
        }

        return letterIds.contains(Integer.valueOf(letterId));
    }

    /**
     * @return true, if the first name is not NULL or an empty string and its length is not more than 24 characters
     */
    public static boolean checkName(String name) {
        return name != null && !name.equals("") && name.length() <= 24;
    }

    /**
     * @return true, if the last name is not NULL or an empty string and its length is not more than 32 characters
     */
    public static boolean checkSurname(String surname) {
        return surname != null && !surname.equals("") && surname.length() <= 32;
    }

    /**
     * @return true, if the phone number is not NULL and its length is in the range of 6 to 18 characters,
     * and also if it is not already in the system
     */
    public static boolean checkPhone(String phone) throws SQLException {
        if (phone == null) return false;
        Pattern p = Pattern.compile(".{6,18}");
        Matcher m = p.matcher(phone);
        if (!m.matches()) return false;

        List<User> users = UserService.getInstance().findAllUsers();
        for (User user : users) {
            if (user.getPhone().equals(phone)) {
                return false;
            }
        }

        return true;
    }

    /**
     * @return true, if the email is not already in the system
     */
    public static boolean checkEmail(String email) throws SQLException {
        List<User> users = UserService.getInstance().findAllUsers();
        for (User user : users) {
            if (user.getEmail().equals(email) && !email.equals("")) {
                return false;
            }
        }

        return true;
    }

    /**
     * @return true, if the password is not NULL and its length is at least 6 characters
     */
    public static boolean checkPassword(String password) {
        if (password == null) return false;
        Pattern p = Pattern.compile(".{6,}");
        Matcher m = p.matcher(password);
        return m.matches();
    }

    /**
     * @return true, if the account number is not NULL and is 20 digits,
     * and also if it is not already in the system
     */
    public static boolean checkAccountNumber(String number) throws SQLException {
        if (number == null) return false;
        Pattern p = Pattern.compile("\\d{20}");
        Matcher m = p.matcher(number);
        if (!m.matches()) return false;

        List<Account> accounts = AccountService.getInstance().findAllAccounts();
        for (Account account : accounts) {
            if (account.getNumber().equals(number)) {
                return false;
            }
        }

        return true;
    }

    /**
     * @return true, if the account number is not NULL and is 20 digits, and also if it is in the system
     */
    public static boolean checkRecipientAccountNumber(String number) throws SQLException {
        if (number == null) return false;
        Pattern p = Pattern.compile("\\d{20}");
        Matcher m = p.matcher(number);
        if (!m.matches()) return false;

        List<Account> accounts = AccountService.getInstance().findAllAccounts();
        List<String> accountNumbers = new ArrayList<>();
        for (Account account : accounts) {
            accountNumbers.add(account.getNumber());
        }

        return accountNumbers.contains(number);
    }

    /**
     * @return true, if the currency is not NULL and is 3 letters
     */
    public static boolean checkCurrency(String currency) {
        if (currency == null || currency.equals("") || currency.length() != 3) return false;

        char[] chars = currency.toCharArray();
        for (int i = 0; i < currency.length() - 1; i++) {
            if (!Character.isLetter(chars[i])) {
                return false;
            }
        }

        return true;
    }

    /**
     * @return true, if the card number is not NULL and is 16 digits
     */
    public static boolean checkCardNumber(String number) {
        if (number == null) return false;
        number = number.replaceAll(" ", "");
        Pattern p = Pattern.compile("\\d{16}");
        Matcher m = p.matcher(number);
        return m.matches();
    }

    /**
     * @return true, if the CVV is not NULL and is 3 digits
     */
    public static boolean checkCVV(String CVV) {
        if (CVV == null) return false;
        Pattern p = Pattern.compile("\\d{3}");
        Matcher m = p.matcher(CVV);
        return m.matches();
    }

    /**
     * @return true, if the obtained values of the month and year are not negative
     */
    public static boolean checkDate(String month, String year) {
        return month != null && !isNegative(month) && year != null && !isNegative(year);
    }

    /**
     * @return true, if the obtained values of the month and year, as a result, earlier than the current month and year
     */
    public static boolean checkValidity(String month, String year) {
        DateFormat parser = new SimpleDateFormat("MM/yyyy");
        Date date, now;

        try {
            date = parser.parse(month + "/" + year);
            now = new GregorianCalendar().getTime();
        } catch (ParseException e) {
            LOGGER.error("Exception: Parsing error in Validator class. " + e.getMessage());
            return true;
        }

        return Objects.requireNonNull(date).before(now);
    }

    /**
     * @return true, if the amount of funds is a non-negative double number
     */
    public static boolean checkAmount(String amount) {
        try {
            if (new BigDecimal(amount).doubleValue() <= 0.00) {
                return false;
            }
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
        return true;
    }

    /**
     * @return true, if the question type is a non-negative integer ranging from 1 to 10
     */
    public static boolean checkTypeQuestion(String typeQuestion) {
        if (typeQuestion == null || isNegative(typeQuestion)) return false;
        return Integer.parseInt(typeQuestion) >= 1 && Integer.parseInt(typeQuestion) <= 10;
    }

    /**
     * @return true, if the start date is less than or equal to the final date
     */
    public static boolean checkDateRange(String startDateParam, String finalDateParam) {
        if (startDateParam == null || startDateParam.equals("") || finalDateParam == null || finalDateParam.equals("")) {
            return false;
        }

        DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        Date startDate, finalDate;

        try {
            startDate = format.parse(startDateParam);
            finalDate = format.parse(finalDateParam);
        } catch (ParseException e) {
            LOGGER.error("Exception: Parsing error in Validator class. " + e.getMessage());
            return false;
        }

        if (Objects.requireNonNull(startDate).equals(finalDate)) {
            return true;
        }

        return Objects.requireNonNull(startDate).before(finalDate);
    }

    /**
     * @return false, if the string is a non-negative integer number
     */
    public static boolean isNegative(String strNum) {
        try {
            if (Integer.parseInt(strNum) < 0) {
                return true;
            }
        } catch (NumberFormatException | NullPointerException e) {
            return true;
        }
        return false;
    }

    /**
     * @return true, if the string is a integer number
     */
    public static boolean isNumeric(String strNum) {
        try {
            Integer.parseInt(strNum);
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
        return true;
    }

}
