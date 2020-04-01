package com.system.command;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * @author Syniuk Valentyn
 */
public interface ICommand {

    /**
     * This method reads a command from the request and processes it.
     * The result will be given as a page to forward to
     */
    String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException;

    default String getName() {
        return getClass().getSimpleName();
    }
}
