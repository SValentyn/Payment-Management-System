package com.system.command;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandLogin implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);

        // Data
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        // Check
        if (checkLogin(request, login) ||
                checkPassword(request, password)) {
            setRequestAttributes(request, login, password);
            return page;
        }

        // Authentication
        User user = UserService.getInstance().loginUser(login, password);
        if (user == null) {
            request.setAttribute("loginError", true);
            setRequestAttributes(request, login, password);
        } else {
            request.getSession().setAttribute("currentUser", user);

            String role = UserService.getInstance().getRole(user);
            if (role.equals(Role.ROLE_ADMIN)) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
            } else if (role.equals(Role.ROLE_CLIENT)) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.HOME);
            }
        }

        return page;
    }

    private boolean checkLogin(HttpServletRequest request, String login) {
        if (login == null || login.isEmpty() || !Validator.checkPhoneNumber(login)) {
            request.setAttribute("phoneError", true);
            return true;
        }
        return false;
    }

    private boolean checkPassword(HttpServletRequest request, String password) {
        if (password == null || password.isEmpty() || !Validator.checkPassword(password)) {
            request.setAttribute("passwordError", true);
            return true;
        }
        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String login, String password) {
        request.setAttribute("phoneValue", login);
        request.setAttribute("passwordValue", password);
    }

}
