package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class CommandAdminDeleteUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("showUsers", true);
        request.setAttribute("deleted", false);
        request.setAttribute("deleteUserError", false);

        String userId = request.getParameter("userId");

        if (userId != null) {
            UserService.getInstance().deleteUserById(Integer.valueOf(userId));
            request.setAttribute("users", UserService.getInstance().findAllUsers());
            request.setAttribute("deleted", true);
        } else {
            request.setAttribute("deleteUserError", true);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
    }

}
