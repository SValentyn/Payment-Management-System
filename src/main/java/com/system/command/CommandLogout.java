package com.system.command;

import com.system.manager.ResourceManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommandLogout implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
        return ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
    }

}
