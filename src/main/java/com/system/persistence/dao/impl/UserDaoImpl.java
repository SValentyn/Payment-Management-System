package com.system.persistence.dao.impl;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.persistence.dao.UserDao;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from UserDao interface
 *
 * @author Syniuk Valentyn
 */
public class UserDaoImpl implements UserDao {

    private static final Logger LOGGER = LogManager.getLogger(UserDaoImpl.class);

    /**
     * SQL queries
     */
    private static final String CREATE_USER =
            "INSERT INTO users (name, surname, phone, email, password, registration_date, role_id) " +
                    "VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_USER =
            "UPDATE users SET name = ?, surname = ?, phone = ?, email = ?, password = ? " +
                    "WHERE user_id = ?";
    private static final String DELETE_USER = "DELETE FROM users WHERE user_id = ?";
    private static final String FIND_USER_BY_ID =
            "SELECT users.*, roles.* FROM users " +
                    "INNER JOIN roles ON users.role_id = roles.role_id " +
                    "WHERE users.user_id = ?";
    private static final String FIND_USER_BY_PHONE_AND_PASSWORD =
            "SELECT users.*, roles.* FROM users " +
                    "INNER JOIN roles ON users.role_id = roles.role_id " +
                    "WHERE users.phone = ? AND users.password = ?";
    private static final String FIND_USER_BY_PHONE =
            "SELECT users.*, roles.* FROM users " +
                    "INNER JOIN roles ON users.role_id = roles.role_id " +
                    "WHERE users.phone = ?";
    private static final String FIND_ALL_USERS =
            "SELECT users.*, roles.* FROM users " +
                    "INNER JOIN roles ON users.role_id = roles.role_id";
    private static final String SEARCH_BY_CRITERIA =
            "SELECT users.*, roles.* FROM users " +
                    "INNER JOIN roles ON users.role_id = roles.role_id " +
                    "WHERE users.role_id = 1 AND name LIKE CONCAT(?,'%') AND surname LIKE CONCAT(?,'%') AND " +
                    "phone LIKE CONCAT(?,'%') AND email LIKE CONCAT(?,'%') ORDER BY registration_date DESC";

    private static UserDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

    private UserDaoImpl() {
    }

    public static synchronized UserDaoImpl getInstance() {
        if (instance == null) {
            instance = new UserDaoImpl();
        }
        return instance;
    }

    @Override
    public int create(User entity) {
        entity.setName(StringEscapeUtils.escapeJava(entity.getName()));
        entity.setSurname(StringEscapeUtils.escapeJava(entity.getSurname()));

        Object[] args = {
                entity.getName(),
                entity.getSurname(),
                entity.getPhone(),
                entity.getEmail(),
                entity.getPassword(),
                entity.getRegistrationDate(),
                entity.getRole().getRoleId()
        };
        return executor.executeStatement(CREATE_USER, args);
    }

    @Override
    public int update(User entity) {
        entity.setName(StringEscapeUtils.escapeJava(entity.getName()));
        entity.setSurname(StringEscapeUtils.escapeJava(entity.getSurname()));

        Object[] args = {
                entity.getName(),
                entity.getSurname(),
                entity.getPhone(),
                entity.getEmail(),
                entity.getPassword(),
                entity.getUserId()
        };
        return executor.executeStatement(UPDATE_USER, args);
    }

    @Override
    public int delete(Integer id) {
        return executor.executeStatement(DELETE_USER, id);
    }

    @Override
    public User findUserByUserId(Integer userId) {
        User user = null;
        try {
            ResultSet rs = executor.executeQuery(FIND_USER_BY_ID, userId);
            if (rs.next()) {
                user = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

    @Override
    public User findUserByPhoneAndPassword(String phone, String password) {
        User user = null;
        if (phone != null && password != null) {
            try {
                ResultSet rs = executor.executeQuery(FIND_USER_BY_PHONE_AND_PASSWORD, phone, password);
                if (rs.next()) {
                    user = createEntity(rs);
                }
            } catch (SQLException e) {
                LOGGER.error("SQL exception: " + e.getMessage());
            }
        }
        return user;
    }

    @Override
    public User findUserByPhoneNumber(String phone) {
        User user = null;
        try {
            ResultSet rs = executor.executeQuery(FIND_USER_BY_PHONE, phone);
            if (rs.next()) {
                user = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

    @Override
    public List<User> findAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(FIND_ALL_USERS);
            while (rs.next()) {
                users.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return users;
    }

    @Override
    public List<User> searchByCriteria(String name, String surname, String phone, String email) {
        name = StringEscapeUtils.escapeJava(name);
        surname = StringEscapeUtils.escapeJava(surname);

        if (name.startsWith("\\") || surname.startsWith("\\")) {
            name = name.replaceAll("\\\\u", "%");
            surname = surname.replaceAll("\\\\u", "%");
        }

        List<User> users = new ArrayList<>();
        try {
            ResultSet rs = executor.executeQuery(SEARCH_BY_CRITERIA, name, surname, phone, email);
            while (rs.next()) {
                users.add(createEntity(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return users;
    }

    /**
     * Creates entity from result set
     */
    private User createEntity(ResultSet rs) {
        User user = new User();
        try {
            user.setUserId(rs.getInt("user_id"));
            user.setName(StringEscapeUtils.unescapeJava(rs.getString("name")));
            user.setSurname(StringEscapeUtils.unescapeJava(rs.getString("surname")));
            user.setPhone(rs.getString("phone"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setRegistrationDate(rs.getString("registration_date"));
            Role role = new Role();
            role.setRoleId(rs.getInt("role_id"));
            role.setRoleTitle(rs.getString("role_title"));
            user.setRole(role);
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

}
