package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
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

        // Data
        String login = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
        String password = request.getParameter("password");

        // Validation
        if (!validation(login, password)) {
            setRequestAttributes(login);
            return pathRedirect += "&typeOfError=invalidData";
        }

        // Authentication
        User user = UserService.getInstance().loginUser(login, password);
        if (user != null) {
            request.getSession().setAttribute("currentUser", user);
        } else {
            setRequestAttributes(login);
            pathRedirect += "&typeOfError=authenticationError";
        }

        return pathRedirect;
    }

    private boolean validation(String login, String password) throws SQLException {
        return Validator.checkLogin(login) &&
                Validator.checkPassword(password);
    }

    private void setRequestAttributes(String login) {
        pathRedirect = "?login=" + login;
    }

}
