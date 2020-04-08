package com.system.utils;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.service.AccountService;
import com.system.service.UserService;

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
     * @return true, if the identifier is a non-negative number and is in the system
     */
    public static boolean checkUserId(String userId) throws SQLException {
        if (userId == null || isNegative(userId)) {
            return false;
        }

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
        if (accountId == null || isNegative(accountId)) {
            return false;
        }

        List<Account> accounts = AccountService.getInstance().findAllAccounts();
        List<Integer> accountIds = new ArrayList<>();
        for (Account account : accounts) {
            accountIds.add(account.getAccountId());
        }

        return accountIds.contains(Integer.valueOf(accountId));
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
     * @return true, if the account number is not NULL and is 20 digits
     */
    public static boolean checkAccountNumber(String number) {
        if (number == null) return false;
        Pattern p = Pattern.compile("\\d{20}");
        Matcher m = p.matcher(number);
        return m.matches();
    }

    /**
     * @return true, if the currency is not NULL and is 3 letters
     */
    public static boolean checkCurrency(String currency) {
        if (currency == null || currency.equals("") || currency.length() != 3) {
            return false;
        }

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
     * @return true, if the obtained values of the month and year, as a result, earlier than the current month and year
     */
    public static boolean checkValidity(String month, String year) {
        DateFormat parser = new SimpleDateFormat("MM/yyyy");
        Date date = null, now = null;

        try {
            date = parser.parse(month + "/" + year);
            now = new GregorianCalendar().getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return Objects.requireNonNull(date).before(now);
    }

    /**
     * @return true, if the amount of funds is a non-negative integer number
     */
    public static boolean checkAmount(String amount) {
        return !isNegative(amount);
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
