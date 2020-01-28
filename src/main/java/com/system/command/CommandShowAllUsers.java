package com.system.command;

import com.system.manager.ResourceManager;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandShowAllUsers implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        request.setAttribute("showUsers", true);
        request.setAttribute("users", UserService.getInstance().findAll());
        return ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
    }
}
