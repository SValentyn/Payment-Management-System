package com.system.persistence.dao.impl;

import com.mysql.jdbc.Statement;
import com.system.persistence.ConnectionPool;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * It implements the basic methods for working with the database:
 * - obtaining a connection to the connection pool
 * - performing CRUD operations
 * - closing a pool connection
 *
 * @author Syniuk Valentyn
 */
public class QueryExecutor {

    private static final Logger LOGGER = LogManager.getLogger(QueryExecutor.class);

    private static QueryExecutor instance = null;
    private final Connection connection = getConnection();
    private PreparedStatement preparedStatement;

    private QueryExecutor() {
    }

    public static synchronized QueryExecutor getInstance() {
        if (instance == null) {
            instance = new QueryExecutor();
        }
        return instance;
    }

    /**
     * This connection used on localhost.
     * Uncomment the code below and comment on this code.
     *
     * @return ready connection to the DB
     */
//    private synchronized Connection getConnection() {
//        try {
//            return ConnectionPool.getDatasource().getConnection();
//        } catch (SQLException e) {
//            LOGGER.error("SQLException: " + e.getMessage());
//            return null;
//        }
//    }

    /**
     * This connection used on hosting.
     * Uncomment this code and comment on the code above.
     *
     * @return ready connection to the DB
     */
    private synchronized Connection getConnection() {
        try {
            return ConnectionPool.getConnection();
        } catch (URISyntaxException | SQLException e) {
            LOGGER.error("SQLException: " + e.getMessage());
            return null;
        }
    }

    /**
     * Executes SELECT queries
     *
     * @return result set
     */
    public ResultSet executeQuery(String query, Object... args) throws SQLException {
        if (connection != null) {
            preparedStatement = connection.prepareStatement(query);
            setValues(preparedStatement, args);
        }

        return preparedStatement.executeQuery();
    }

    /**
     * Executes INSERT, UPDATE and DELETE queries
     *
     * @return ID or boolean result
     */
    public int executeStatement(String query, Object... args) {
        int result = 0;
        try {
            if (connection != null) {
                preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                setValues(preparedStatement, args);

                result = preparedStatement.executeUpdate();
                ResultSet resultSet = preparedStatement.getGeneratedKeys();
                if (resultSet.next()) {
                    result = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Execute statement error: " + e.getMessage());
        }
        return result;
    }

    /**
     * Inserts an array of objects into prepared statement
     */
    private void setValues(PreparedStatement preparedStatement, Object... values) throws SQLException {
        for (int i = 1; i <= values.length; i++) {
            preparedStatement.setObject(i, values[i - 1]);
        }
    }

    /**
     * Close connection to pool
     */
    public void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            LOGGER.error("Error while closing connection. SQLException: " + e.getMessage());
        }
    }

}
