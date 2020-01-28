package com.system.persistence.dao.impl;

import com.mysql.jdbc.Statement;
import com.system.persistence.ConnectionPool;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.sql.*;

public class QueryExecutor {

    private static final Logger LOGGER = LogManager.getLogger(QueryExecutor.class);

    private PreparedStatement preparedStatement;
    private Connection connection = getConnection();

    private QueryExecutor() throws SQLException {
    }

    private static QueryExecutor instance = null;

    public static synchronized QueryExecutor getInstance() throws SQLException {
        if (instance == null) {
            instance = new QueryExecutor();
        }
        return instance;
    }

    /**
     * Getting connection from connection pool
     */
    private Connection getConnection() throws SQLException {
        return ConnectionPool.getInstance().getConnection();

//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//
//        String URL = "jdbc:mysql://localhost:3306/PMS_DB?useSSL=false&amp;useUnicode=true&amp;autoReconnect=true&amp;useJDBCCompliantTimezoneShift=true&amp;useLegacyDatetimeCode=false&amp;serverTimezone=UTC";
//        String username = "root";
//        String password = "pppp";
//
//        return DriverManager.getConnection(URL, username, password);
    }

    /**
     * Executes insert, update and delete queries
     *
     * @return id
     */
    public int executeStatement(String query, Object... args) {
        try {
            preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            setValues(preparedStatement, args);
            int res = preparedStatement.executeUpdate();
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                return res;
            }
        } catch (SQLException e) {
            LOGGER.error("Execute statement error: " + e.getMessage());
        }
        return 0;
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
            connection.close();
        } catch (SQLException e) {
            LOGGER.error("Error while closing connection..");
        }
    }
}
