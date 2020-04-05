package com.system.command;

import com.system.entity.Role;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandIndex implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        // if the POST method is received
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
        }

        // Data
        User user = (User) request.getSession().getAttribute("currentUser");

        // Check
        if (user != null) {
            String role = user.getRole().getRolename();
            if (role.equals(Role.ROLE_ADMIN)) {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
            } else if (role.equals(Role.ROLE_CLIENT)) {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER);
            }
        } else {
            setRequestAttributes(request);
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("loginValue", null);
        request.setAttribute("typeOfError", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String login = (String) session.getAttribute("login");
        if (login != null) {
            request.setAttribute("loginValue", login);
            session.removeAttribute("login");
        }

        String typeOfError = (String) session.getAttribute("typeOfError");
        if (typeOfError != null) {
            request.setAttribute("typeOfError", typeOfError);
            session.removeAttribute("typeOfError");
        }
    }

}