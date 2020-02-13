package com.system.service;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.persistence.dao.UserDao;
import com.system.persistence.factory.DaoFactory;
import com.system.utils.PasswordEncryptor;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.util.List;
import java.util.Random;

/**
 * Provides service methods for UserDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class UserService {

    private static final Logger LOGGER = LogManager.getLogger(UserService.class);

    private static final String UNKNOWN = "unknown";
    private static final String ADMIN = "admin";
    private static final String USER = "client";

    private static UserService instance = null;
    private UserDao userDao = DaoFactory.createUserDao();
    private PasswordEncryptor encryptor = new PasswordEncryptor();

    private UserService() throws SQLException {
    }

    public static synchronized UserService getInstance() throws SQLException {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    /**
     * Check user role
     */
    public String getRole(User user) {
        String role = null;
        if (user == null) {
            role = UNKNOWN;
        } else if (user.getRole().getRolename().equalsIgnoreCase(Role.ROLE_ADMIN)) {
            role = ADMIN;
        } else if (user.getRole().getRolename().equalsIgnoreCase(Role.ROLE_CLIENT)) {
            role = USER;
        }
        return role;
    }

    /**
     * Finds user by login and encrypted password
     */
    public User loginUser(String login, String password) {
        return userDao.findUserByLoginAndPassword(login, encryptor.encode(password));
    }

    /**
     * Checks if the user is registered in the system.
     * Registers the user in the system by the entered phone number and password.
     */
    public int registerUser(String name, String surname, String phone, String email, String password) {
        int status = 0;
        User user = findUserByPhoneNumber(phone);
        if (user == null) {
            Role role = new Role();
            role.setRolename(Role.ROLE_CLIENT);
            user = new User(name, surname, phone, email, encryptor.encode(password), role);
            status = userDao.create(user);
        }
        return status;
    }

    /**
     * Checks if the user is registered in the system.
     * Generates a random alphanumeric password.
     * Registers the user in the system by the entered phone number and the generated password.
     * [in the future] Sends the generated password to the phone.
     */
    public int registerUser(String name, String surname, String phone, String email) {
        int status;

        User user = findUserByPhoneNumber(phone);
        if (user == null) {
            String password = generatePassword(8);
            Role role = new Role();
            role.setRolename(Role.ROLE_CLIENT);
            user = new User(name, surname, phone, email, encryptor.encode(password), role);
            status = userDao.create(user);

            // ------------------------------------------------------------- //
            // There must be an API to send the password to the user's phone //
            // ------------------------------------------------------------- //
        } else {
            status = 0; // if user is registered in the payment system
        }
        return status;
    }

    private String generatePassword(int lengthPassword) {
        String alphanumeric = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        Random random = new Random();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < lengthPassword; i++) {
            result.append(alphanumeric.charAt(random.nextInt(alphanumeric.length())));
        }

        return result.toString();
    }

    /**
     * Checks if user id not null and updates it
     */
    public int updateUser(User user) {
        int status = 0;
        if (user.getUserId() != null) {
            status = userDao.update(user);
        }
        return status;
    }

    /**
     * Checks if user id not null and deletes it
     */
    public void deleteUserById(Integer userId) {
        if (userId != null) {
            userDao.delete(userId);
        }
    }

    /**
     * Finds user by phone number and checks if user is registered already
     */
    private User findUserByPhoneNumber(String phone) {
        return userDao.findUserByPhoneNumber(phone);
    }

    /**
     * Finds user entity by userId
     */
    public User findUserById(Integer userId) {
        return userDao.findUserByUserId(userId);
    }

    /**
     * Finds all users
     */
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }

}
