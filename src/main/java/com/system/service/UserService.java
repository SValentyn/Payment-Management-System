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

/**
 * Provides service methods for UserDao. Layout between DAO and Command
 *
 * @author Syniuk Valentyn
 */
public class UserService {

    private static final Logger LOGGER = LogManager.getLogger(UserService.class);

    private static final String UNKNOWN = "unknown";
    private static final String ADMIN = "admin";
    private static final String CLIENT = "client";
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
            role = CLIENT;
        }
        return role;
    }

    /**
     * Checks if user isn't in database and adds new user to the system
     */
    public int addNewUser(String name, String surname, String phone) {
        int status = 0;
        User user = userDao.findByPhone(phone);
        if (user != null) {
            LOGGER.info("Attempt to create an existing user!");
        } else {
            user = new User();
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            Role role = new Role();
            role.setId(1);
            role.setRolename(Role.ROLE_CLIENT);
            user.setRole(role);
            status = userDao.create(user);
        }

        return status;
    }

    /**
     * Registers user in system by phone. Check if user has already registered
     * in payment system as client and allows him to register in payment system
     */
    public int registerUser(String name, String surname, String phone, String email, String password) {
        int status = 0;
        User user = findUserInSystem(phone);
        if (user == null) {
            Role role = new Role();
            role.setRolename(Role.ROLE_CLIENT);
            user = new User(name, surname, phone, email, encryptor.encode(password), role);
            status = userDao.create(user);
        }
        return status;
    }

    /**
     * Finds user by login and encrypted password
     */
    public User loginUser(String login, String password) {
        return userDao.findByLoginAndPassword(login, encryptor.encode(password));
    }

    /**
     * Finds user by phone and checks if user is registered already
     */
    private User findUserInSystem(String phone) {
        return userDao.findByPhone(phone);
    }

    /**
     * Finds user entity by userId
     */
    public User findUserById(Integer userId) {
        return userDao.findById(userId);
    }

    /**
     * Finds all users
     */
    public List<User> findAll() {
        return userDao.findAll();
    }

}
