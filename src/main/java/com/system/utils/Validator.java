package com.system.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Validates input strings for validity for form validation
 */
public class Validator {

    public static boolean checkPhoneNumber(String number) {
        Pattern p = Pattern.compile("\\d{10}");
        Matcher m = p.matcher(number);
        return m.matches();
    }

    public static boolean checkPassword(String password) {
        Pattern p = Pattern.compile(".{6,}");
        Matcher m = p.matcher(password);
        return m.matches();
    }

    public static boolean checkAccountNumber(String number) {
        Pattern p = Pattern.compile("\\d{20}");
        Matcher m = p.matcher(number);
        return m.matches();
    }

    public static boolean checkCardNumber(String number) {
        Pattern p = Pattern.compile("\\d{16}");
        Matcher m = p.matcher(number);
        return m.matches();
    }

    public static boolean checkCVV(String CVV) {
        Pattern p = Pattern.compile("\\d{3}");
        Matcher m = p.matcher(CVV);
        return m.matches();
    }

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

    public static boolean isNumeric(String strNum) {
        try {
            Integer.parseInt(strNum);
        } catch (NumberFormatException | NullPointerException e) {
            return false;
        }
        return true;
    }

}
