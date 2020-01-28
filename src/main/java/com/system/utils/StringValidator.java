package com.system.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Checks input strings on valid pattern uses for form validation
 */
public class StringValidator {

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
}
