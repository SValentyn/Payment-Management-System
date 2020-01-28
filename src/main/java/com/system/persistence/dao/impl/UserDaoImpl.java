package com.system.persistence.dao.impl;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.persistence.dao.UserDao;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Realizes methods from UserDao interface
 */
public class UserDaoImpl implements UserDao {

    private static final Logger LOGGER = LogManager.getLogger(UserDaoImpl.class);
    /**
     * SQL queries
     */
    private static final String CREATE_USER = "INSERT INTO users (username, surname, email, password, phone, role_id) VALUES(?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_USER = "UPDATE users SET email = ?, password = ? WHERE user_id = ?";
    private static final String FIND_BY_ID = "SELECT users.user_id, users.username, users.surname, users.email, users.password, users.phone, users.role_id, roles.title FROM users JOIN roles ON users.role_id = roles.id WHERE users.user_id = ?";
    private static final String FIND_BY_LOGIN_PASSWORD = "SELECT users.user_id, users.username, users.surname, users.email, users.password, users.phone, users.role_id, roles.title FROM users JOIN roles ON users.role_id = roles.id WHERE users.phone = ? AND users.password = ?";
    private static final String FIND_BY_PHONE = "SELECT users.user_id, users.username, users.surname, users.email, users.password, users.phone, users.role_id, roles.title FROM users JOIN roles ON users.role_id = roles.id WHERE users.phone = ?";
    private static final String FIND_ALL = "SELECT users.user_id, users.username, users.surname, users.email, users.password, users.phone, users.role_Id, roles.title FROM users JOIN roles ON users.role_id = roles.id AND users.role_id = 1";
    private static UserDaoImpl instance = null;
    private QueryExecutor executor = QueryExecutor.getInstance();

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
        Object[] args = {entity.getName(), entity.getSurname(), entity.getEmail(), entity.getPassword(), entity.getPhone(), entity.getRole().getId()};
        return executor.executeStatement(CREATE_USER, args);
    }

    @Override
    public int update(User entity) {
        Object[] args = {entity.getEmail(), entity.getPassword(), entity.getUserId()};
        return executor.executeStatement(UPDATE_USER, args);
    }

    @Override
    public User findById(Integer id) {
        User user = null;
        try {
            ResultSet rs = executor.getResultSet(FIND_BY_ID, id);
            if (rs.next()) {
                user = createEntity(rs);
            }
        } catch (SQLException e) {
            LOGGER.error("SQL exception: " + e.getMessage());
        }
        return user;
    }

    @Override
    public User findByLoginAndPassword(String login, String password) {
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
    public User findByPhone(String phone) {
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
    public List<User> findAll() {
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
     * Creates User entity
     */
    private User createEntity(ResultSet rs) {
        User user = new User();
        try {
            user.setUserId(rs.getInt("user_id"));
            user.setName(rs.getString("username"));
            user.setSurname(rs.getString("surname"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setPhone(rs.getString("phone"));
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
