package com.system.command;

import com.system.entity.User;
import com.system.manager.ResourceManager;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandIndex implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);

        HttpSession session = request.getSession(false);
        session.setMaxInactiveInterval(-1);

        User user = (User) session.getAttribute("currentUser");
        if (user != null) {
            String role = UserService.getInstance().getRole(user);
            if (role.equals("admin")) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
            } else if (role.equals("client")) {
                page = ResourceManager.getInstance().getProperty(ResourceManager.USER);
            }
        }

        return page;
    }

}
