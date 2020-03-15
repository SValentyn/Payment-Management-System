package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowUsers implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("showUserError", false);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        List<User> users = UserService.getInstance().findAllUsers();
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", users.size());

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USERS);
    }

}
