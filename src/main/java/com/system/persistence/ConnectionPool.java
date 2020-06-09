package com.system.persistence;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Class provides access to the database by obtaining a Connection or Datasource
 *
 * @author Syniuk Valentyn
 */
public class ConnectionPool {

    private static final Logger LOGGER = LogManager.getLogger(ConnectionPool.class);

    private static DataSource datasource;

    private ConnectionPool() {
    }

    /**
     * This connection used on localhost. Gets the parameters from the context.xml file.
     *
     * @return DataSource, from which connection to DB can be gotten
     */
    public static synchronized DataSource getDatasource() {
        if (datasource == null) {
            try {
                Context initialContext = new InitialContext();
                Context environmentContext = (Context) initialContext.lookup("java:comp/env");
                datasource = (DataSource) environmentContext.lookup("jdbc/pool");
            } catch (NamingException e) {
                LOGGER.error("NamingException: " + e.getMessage());
            }
        }
        return datasource;
    }

    /**
     * This connection used on hosting.
     *
     * @return ready connection to the DB
     */
    public static synchronized Connection getConnection() throws URISyntaxException, SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            LOGGER.error("The driver class object could not be instantiated! Exception:" + e.getMessage());
        }

        URI uri = new URI(System.getenv("JAWSDB_URL"));
        String username = uri.getUserInfo().split(":")[0];
        String password = uri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:mysql://" + uri.getHost() + uri.getPath();

        return DriverManager.getConnection(dbUrl, username, password);
    }

}
