package com.system.service;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.persistence.dao.UserDao;
import com.system.persistence.factory.DaoFactory;
import com.system.utils.PasswordEncryptor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;

/**
 * Provides service methods for UserDao. Layout between DAO and Command.
 *
 * @author Syniuk Valentyn
 */
public class UserService {

    private static final String UNKNOWN = "unknown";
    private static final String USER = "user";
    private static final String ADMIN = "admin";

    private static UserService instance = null;
    private final UserDao userDao = DaoFactory.createUserDao();
    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    private UserService() {
    }

    public static synchronized UserService getInstance() {
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
        } else if (user.getRole().getRoleTitle().equalsIgnoreCase(Role.ROLE_USER)) {
            role = USER;
        } else if (user.getRole().getRoleTitle().equalsIgnoreCase(Role.ROLE_ADMIN)) {
            role = ADMIN;
        }
        return role;
    }

    /**
     * Finds user by a login and encrypted password
     */
    public User authentication(String login, String password) {
        return userDao.findUserByPhoneAndPassword(login, encryptor.encode(password));
    }

    /**
     * Checks if the user is registered in the system.
     * Registers the user in the system by the entered phone number and password.
     */
    public int registerUser(String name, String surname, String phone, String email, String password) {
        int userId = 0;

        User user = findUserByPhoneNumber(phone);
        if (user == null) {
            user = new User();
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);
            user.setPassword(encryptor.encode(password));
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            formatter.setTimeZone(TimeZone.getTimeZone("UTC"));
            user.setRegistrationDate(formatter.format(new Date()));
            Role role = new Role();
            role.setRoleTitle(Role.ROLE_USER);
            user.setRole(role);
            userId = userDao.create(user);
        }
        return userId;
    }

    /**
     * Checks if the user is registered in the system.
     * Generates a random alphanumeric password.
     * Registers the user in the system by the entered phone number and the generated password.
     * [in the future] Sends the generated password to the phone.
     */
    public int registerUser(String name, String surname, String phone, String email) {
        int userId = 0;

        User user = findUserByPhoneNumber(phone);
        if (user == null) {
            user = new User();
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);
            user.setPassword(encryptor.encode(generatePassword(8)));
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            formatter.setTimeZone(TimeZone.getTimeZone("UTC"));
            user.setRegistrationDate(formatter.format(new Date()));
            Role role = new Role();
            role.setRoleTitle(Role.ROLE_USER);
            user.setRole(role);
            userId = userDao.create(user);

            // ------------------------------------------------------------- //
            // There must be an API to send the password to the user's phone //
            // ------------------------------------------------------------- //
        }
        return userId;
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
     * Checks if user id not NULL and updates it
     */
    public int updateUser(User user) {
        int status = 0;
        if (user.getUserId() != null) {
            status = userDao.update(user);
        }
        return status;
    }

    /**
     * Checks if user id not NULL and deletes it
     */
    public int deleteUserById(Integer userId) {
        int status = 0;
        if (userId != null) {
            status = userDao.delete(userId);
        }
        return status;
    }

    /**
     * Finds user entity by user id
     */
    public User findUserById(Integer userId) {
        return userDao.findUserByUserId(userId);
    }

    /**
     * Finds user by phone number and checks if user is registered already
     */
    private User findUserByPhoneNumber(String phone) {
        return userDao.findUserByPhoneNumber(phone);
    }

    /**
     * Finds all users in the system
     */
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }

    /**
     * Searches all users by criteria
     */
    public List<User> searchByCriteria(String name, String surname, String phone, String email) {
        return userDao.searchByCriteria(name, surname, phone, email);
    }

}
