package com.system.command;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.UserService;
import com.system.utils.StringValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandLogin implements ICommand {

    public static final String LOGIN_PARAMETER = "login";
    public static final String PASSWORD_PARAMETER = "password";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);
        HttpSession session = request.getSession();

        // Data
        String login = request.getParameter(LOGIN_PARAMETER);
        String password = request.getParameter(PASSWORD_PARAMETER);

        // Check
        if (checkLogin(request, login, password) || checkPassword(request, login, password)) {
            return page;
        }

        // Authentication
        User user = UserService.getInstance().loginUser(login, password);
        if (user != null) { // If the data is confirmed
            session.setAttribute("currentUser", user);
            String role = UserService.getInstance().getRole(user);
            if (role.equals(Role.ROLE_ADMIN)) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
            } else if (role.equals(Role.ROLE_CLIENT)) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.HOME);
            }
        } else {
            request.setAttribute("loginError", true);
            request.setAttribute("phoneValue", login);
            request.setAttribute("passwordValue", password);
        }

        return page;
    }

    private boolean checkLogin(HttpServletRequest request, String login, String password) {
        if (login == null || login.isEmpty() || !StringValidator.checkPhoneNumber(login)) {
            request.setAttribute("phoneError", true);
            request.setAttribute("phoneValue", login);
            request.setAttribute("passwordValue", password);
            return true;
        }
        return false;
    }

    private boolean checkPassword(HttpServletRequest request, String login, String password) {
        if (password == null || password.isEmpty() || !StringValidator.checkPassword(password)) {
            request.setAttribute("passwordError", true);
            request.setAttribute("phoneValue", login);
            request.setAttribute("passwordValue", password);
            return true;
        }
        return false;
    }

}
