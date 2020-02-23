package com.system.persistence;

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

public class ConnectionPool {

    private static DataSource datasource;

    private ConnectionPool() {
    }

    /**
     * Getting parameters from file (in context.xml resource is created)
     *
     * @return DataSource, from which connection to DB can be gotten
     */
    public static synchronized Connection getConnection() throws URISyntaxException, SQLException {
//        if (datasource == null) {
            URI dbUri = new URI(System.getenv("DATABASE_URL"));

            String username = dbUri.getUserInfo().split(":")[0];
            String password = dbUri.getUserInfo().split(":")[1];
            String dbUrl = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();

            return DriverManager.getConnection(dbUrl, username, password);

//            try {
//                Context initialContext = new InitialContext();
//                Context environmentContext = (Context) initialContext.lookup("java:comp/env");
//                datasource = (DataSource) environmentContext.lookup("jdbc/pool");
//            } catch (NamingException ex) {
//                Logger.getLogger(ConnectionPool.class.getName()).error("NamingException: " + ex.getMessage());
//            }
//        }
//        return datasource;
    }

}
