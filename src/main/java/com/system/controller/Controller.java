package com.system.controller;

import com.system.command.ICommand;
import com.system.manager.HTTPMethod;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * This servlet implementation class HttpServlet
 *
 * @author Syniuk Valentyn
 */
@WebServlet("/")
public class Controller extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOGGER = Logger.getLogger(Controller.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> GET processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> POST processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> PUT processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> DELETE processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void processing(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        String commandName = request.getParameter("command");
        LOGGER.info("Request parameter: command --> " + commandName);

        // obtain command object by its name
        ICommand command = ControllerHelper.getInstance().getCommand(request);
        LOGGER.info("Obtained command --> " + command.getName());

        // execute command and get forward address
        String pathRedirect = command.execute(request, response);
        LOGGER.info("Forward address --> " + pathRedirect);

        // the choice of redirection type depends on the HTTP method
        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            request.getRequestDispatcher(pathRedirect).forward(request, response);
        } else {
            response.sendRedirect(pathRedirect);
        }
    }

}
