package com.system.command;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandLogin implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);

        // Data
        String login = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
        String password = request.getParameter("password");

        // Authentication
        User user = UserService.getInstance().loginUser(login, password);
        if (user != null) {
            request.getSession().setAttribute("currentUser", user);

            String role = UserService.getInstance().getRole(user);
            if (role.equals(Role.ROLE_ADMIN)) {
                request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
                request.setAttribute("totalUsers", UserService.getInstance().findAllUsers().size());
                page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
            } else if (role.equals(Role.ROLE_CLIENT)) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.USER);
            }
        } else {
            setRequestAttributes(request, login, password);
            request.setAttribute("loginError", true);
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String login, String password) {
        request.setAttribute("loginValue", login);
        request.setAttribute("passwordValue", password);
    }

}
