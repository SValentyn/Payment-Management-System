package com.system.controller;

import com.system.command.ICommand;
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
    protected void doGet(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> GET processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> POST processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> PUT processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("===> DELETE processing");
        try {
            processing(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void processing(final HttpServletRequest request, final HttpServletResponse response) throws IOException, ServletException, SQLException {
        ICommand command = ControllerHelper.getInstance().getCommand(request);
        String pathRedirect = command.execute(request, response);
        request.getRequestDispatcher(pathRedirect).forward(request, response);
    }

}
