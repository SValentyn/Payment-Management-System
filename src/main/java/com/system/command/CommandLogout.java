package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.ActionLogService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandLogout implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        User user = (User) request.getSession().getAttribute("currentUser");
        ActionLogService.getInstance().addNewLogEntry(user.getUserId(), "SESSION_ENDED");

        request.getSession().invalidate();
        return ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
    }

}
