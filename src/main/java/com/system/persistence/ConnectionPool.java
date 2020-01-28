package com.system.persistence;

import org.apache.log4j.Logger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionPool {

    private static DataSource datasource;

    private ConnectionPool() {
    }

    /**
     * Getting parameters from file (in context.xml resource is created)
     *
     * @return DataSource, from which connection to DB can be gotten
     */
    public static synchronized DataSource getInstance() {
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
