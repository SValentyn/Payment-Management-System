package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowUsers implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        request.setAttribute("noUsers", false);

        List<User> allUsers = UserService.getInstance().findAll();
        if (allUsers.isEmpty()) {
            request.setAttribute("noUsers", true);
        } else {
            request.setAttribute("showUsers", true);
            request.setAttribute("users", allUsers);
        }

        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
    }
}
