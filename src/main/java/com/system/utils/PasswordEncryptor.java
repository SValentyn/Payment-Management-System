package com.system.utils;

import org.apache.log4j.Logger;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Encrypt password in MD5 algorithm
 */
public class PasswordEncryptor {

    private static final Logger LOGGER = Logger.getLogger(PasswordEncryptor.class);

    /**
     * ALGORITHM name
     */
    private static final String ALGORITHM = "MD5";

    private static final String CHARSET = "UTF-8";

    /**
     * Encrypts passwords in MD5
     *
     * @return hashed password
     */
    public String encode(String password) {
        MessageDigest md5;
        String md5StrWithoutZerous;
        StringBuilder md5StrWithZerous = new StringBuilder(32);

        try {
            md5 = MessageDigest.getInstance(ALGORITHM);
            md5.reset();

            // sends byte-code of string to MessageDigest
            md5.update(password.getBytes(CHARSET));

            // gets MD5-hash without zeros in front
            md5StrWithoutZerous = new BigInteger(1, md5.digest()).toString(16);

            // adds zeros in front if it is necessary
            for (int i = 0, count = 32 - md5StrWithoutZerous.length(); i < count; i++) {
                md5StrWithZerous.append("0");
            }

            md5StrWithZerous.append(md5StrWithoutZerous);

        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            LOGGER.error("Cannot generate byte-code of string: " + e.getMessage());
        }

        return md5StrWithZerous.toString();
    }
}
