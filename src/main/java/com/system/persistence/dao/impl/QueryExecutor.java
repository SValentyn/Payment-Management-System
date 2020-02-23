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
    private PreparedStatement preparedStatement;
    private Connection connection = getConnection();

    private QueryExecutor() throws SQLException {
    }

    public static synchronized QueryExecutor getInstance() throws SQLException {
        if (instance == null) {
            instance = new QueryExecutor();
        }
        return instance;
    }

    /**
     * [For use on the site]
     *
     * Getting a connection directly from the DB
     */
    private Connection getConnection() throws SQLException {
        try {
            return ConnectionPool.getConnection();
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Uncomment the code below for local use (localhost) and comment out the code above (for the site)
     *
     * Getting connection from connection pool
     */
//    private Connection getConnection() throws SQLException {
//        return ConnectionPool.getDatasource().getConnection();
//    }

    /**
     * Executes insert, update and delete queries
     *
     * @return id or boolean result
     */
    public int executeStatement(String query, Object... args) {
        try {
            preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            setValues(preparedStatement, args);
            int result = preparedStatement.executeUpdate();
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                return result;
            }
        } catch (SQLException e) {
            LOGGER.error("Execute statement error: " + e.getMessage());
        }
        return 0;
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
     * Executes select query and returns result set
     */
    public ResultSet getResultSet(String query, Object... args) throws SQLException {
        preparedStatement = connection.prepareStatement(query);
        setValues(preparedStatement, args);
        return preparedStatement.executeQuery();
    }

    /**
     * Close connection to pool
     */
    public void closeConnection() {
        try {
            connection.close();
        } catch (SQLException e) {
            LOGGER.error("Error while closing connection..");
        }
    }

}
