package com.system.command;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * The interface contains abstract methods for the behavior of controllers
 *
 * @author Syniuk Valentyn
 */
public interface ICommand {

    /**
     * This method reads the incoming command from the request and processes it.
     *
     * @return the name of the page or command to redirect to
     */
    String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException;

    /**
     * @return the name of the corresponding command
     */
    default String getName() {
        return getClass().getSimpleName();
    }

}
