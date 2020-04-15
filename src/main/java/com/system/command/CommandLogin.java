package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandLogin implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);

            // Data
            String login = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String password = request.getParameter("password");

            // Validation
            if (!Validator.checkLogin(login)) {
                setSessionAttributes(request, login, ServerResponse.LOGIN_NOT_EXIST);
                return pathRedirect;
            }

            // Validation
            if (!Validator.checkPassword(password)) {
                setSessionAttributes(request, login, ServerResponse.INVALID_DATA);
                return pathRedirect;
            }

            // Authentication
            User user = UserService.getInstance().loginUser(login, password);
            if (user != null) {
                request.getSession().setAttribute("currentUser", user);
            } else {
                setSessionAttributes(request, login, ServerResponse.AUTHENTICATION_ERROR);
            }
        }

        return pathRedirect;
    }

    private void setSessionAttributes(HttpServletRequest request, String login, ServerResponse serverResponse) {
        request.getSession().setAttribute("login", login);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
