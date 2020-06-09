package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminSearchUsers implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);

            // Form Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");

            // Action (search users)
            List<User> users = UserService.getInstance().searchByCriteria(name, surname, phone, email);

            // Check and set attributes
            if (users == null) {
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.SEARCH_USERS_ERROR);
            } else {
                if (users.isEmpty()) {
                    setSessionAttributes(request, users, name, surname, phone, email, ServerResponse.SEARCH_USERS_WARNING);
                } else {
                    setSessionAttributes(request, users, name, surname, phone, email, ServerResponse.SEARCH_USERS_SUCCESS);
                }
            }
        }

        return pathRedirect;
    }

    private void setSessionAttributes(HttpServletRequest request, List<User> users, String name, String surname, String phone, String email, ServerResponse serverResponse) {
        request.getSession().setAttribute("users", users);
        request.getSession().setAttribute("numberOfUsers", String.valueOf(users.size()));
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String name, String surname, String phone, String email, ServerResponse serverResponse) {
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
