package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandLogin implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String pathRedirect;

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);

            // Form Data
            String login = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String password = request.getParameter("password");

            // Validation
            if (!validation(request, login, password)) {
                return pathRedirect;
            }

            // Action (authentication)
            User user = UserService.getInstance().authentication(login, password);
            if (user != null) {
                ActionLogService.getInstance().addNewLogEntry(user.getUserId(), "SESSION_STARTED");
                request.getSession().setAttribute("currentUser", user);
            } else {
                setSessionAttributes(request, login, ServerResponse.AUTHENTICATION_ERROR);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String login, String password) {

        // Validation login
        if (!Validator.checkLogin(login)) {
            setSessionAttributes(request, login, ServerResponse.LOGIN_NOT_EXIST);
            return false;
        }

        // Validation password
        if (!Validator.checkPassword(password)) {
            setSessionAttributes(request, login, ServerResponse.INVALID_DATA);
            return false;
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, String login, ServerResponse serverResponse) {
        request.getSession().setAttribute("login", login);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
