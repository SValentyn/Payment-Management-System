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
    private static final String CREATE_USER = "INSERT INTO users (name, surname, phone, email, password, registration_date, role_id) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_USER = "UPDATE users SET name = ?, surname = ?, phone = ?, email = ?, password = ? WHERE user_id = ?";
    private static final String DELETE_USER = "DELETE FROM users WHERE user_id = ?";
    private static final String FIND_BY_ID = "SELECT users.*, roles.title FROM users JOIN roles ON users.role_id = roles.id WHERE users.user_id = ?";
    private static final String FIND_BY_LOGIN_PASSWORD = "SELECT users.*, roles.title FROM users JOIN roles ON users.role_id = roles.id WHERE users.phone = ? AND users.password = ?";
    private static final String FIND_BY_PHONE = "SELECT users.*, roles.title FROM users JOIN roles ON users.role_id = roles.id WHERE users.phone = ?";
    private static final String FIND_ALL = "SELECT users.*, roles.title FROM users JOIN roles ON users.role_id = roles.id";

    private static UserDaoImpl instance = null;
    private final QueryExecutor executor = QueryExecutor.getInstance();

    private UserDaoImpl() throws SQLException {
    }

    public static synchronized UserDaoImpl getInstance() throws SQLException {
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
                entity.getRole().getId()
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
            ResultSet rs = executor.getResultSet(FIND_BY_ID, userId);
            if (rs.next()) {
                user = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

    @Override
    public User findUserByLoginAndPassword(String login, String password) {
        User user = null;
        if (login != null && password != null) {
            try {
                ResultSet rs = executor.getResultSet(FIND_BY_LOGIN_PASSWORD, login, password);
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
            ResultSet rs = executor.getResultSet(FIND_BY_PHONE, phone);
            if (rs.next())
                user = createEntity(rs);
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

    @Override
    public List<User> findAllUsers() {
        User user;
        List<User> users = new ArrayList<>();
        try {
            ResultSet rs = executor.getResultSet(FIND_ALL);
            while (rs.next()) {
                user = createEntity(rs);
                users.add(user);
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
            role.setId(rs.getInt("role_id"));
            role.setRolename(rs.getString("title"));
            user.setRole(role);
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

}
