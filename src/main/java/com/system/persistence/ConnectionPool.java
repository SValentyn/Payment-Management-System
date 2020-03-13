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
 * A class that provides access to the database by obtaining a Connection or Datasource
 *
 * @author Syniuk Valentyn
 */
public class ConnectionPool {

    private static final Logger LOGGER = LogManager.getLogger(ConnectionPool.class);

    private static DataSource datasource;

    private ConnectionPool() {
    }

    /**
     * [For use on the site]
     * <p>
     * Getting parameters from file (in context.xml resource is created)
     *
     * @return ready connection to the DB
     */
    public static synchronized Connection getConnection() throws URISyntaxException, SQLException {
        try {
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
            } catch (ClassNotFoundException e) {
                LOGGER.error("ClassNotFoundException: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (InstantiationException | IllegalAccessException e) {
            LOGGER.error("Class object cannot be instantiated! Exception:" + e.getMessage());
            e.printStackTrace();
        }

        // mysql://b13cd007edb0bd:a480f834@eu-cdbr-west-02.cleardb.net/heroku_a77bbc8929247c7?useUnicode=true&amp;characterEncoding=utf-8&amp;autoReconnect=true
        URI dbUri = new URI(System.getenv("CLEARDB_DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();

        return DriverManager.getConnection(dbUrl, username, password);
    }

    /**
     * [For local use (localhost)]
     * <p>
     * Getting parameters from file (in context.xml resource is created)
     *
     * @return DataSource, from which connection to DB can be gotten
     */
    public static synchronized DataSource getDatasource() {
        if (datasource == null) {
            try {
                Context initialContext = new InitialContext();
                Context environmentContext = (Context) initialContext.lookup("java:comp/env");
                datasource = (DataSource) environmentContext.lookup("jdbc/pool");
            } catch (NamingException ex) {
                Logger.getLogger(ConnectionPool.class.getName()).error("NamingException: " + ex.getMessage());
            }
        }
        return datasource;
    }

}
