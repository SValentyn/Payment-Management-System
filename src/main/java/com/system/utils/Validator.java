package com.system.utils;

import javax.faces.view.EditableValueHolderAttachedObjectHandler;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Validates input strings for validity for form validation
 */
public class Validator {

    public static boolean checkLengthName(String name) {
        return name.length() > 18;
    }

    public static boolean checkLengthSurname(String surname) {
        return surname.length() > 24;
    }

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

    public static boolean checkValidity(String validity) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date date = null, now = null;
        try {
            date = formatter.parse(validity);
            now = formatter.getCalendar().getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return Objects.requireNonNull(date).before(now);
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
