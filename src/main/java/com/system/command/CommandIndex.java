package com.system.command;

import com.system.entity.Account;
import com.system.entity.Role;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.AccountService;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandIndex implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.INDEX);

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");

            // Check and set attributes
            if (currentUser != null) {
                String role = currentUser.getRole().getRoleTitle();
                if (role.equals(Role.ROLE_USER)) {
                    pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER);

                    List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId());
                    if (accounts.isEmpty()) {
                        request.setAttribute("accountsEmpty", true);
                    } else {
                        request.setAttribute("accountsEmpty", false);
                        request.setAttribute("accounts", accounts);
                    }
                } else if (role.equals(Role.ROLE_ADMIN)) {
                    pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);

                    if (request.getAttribute("users") == null) {
                        request.setAttribute("users", UserService.getInstance().findAllUsers());
                    }
                }
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
        }

        return pathRedirect;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String login = (String) session.getAttribute("login");
        if (login != null) {
            request.setAttribute("loginValue", login);
            session.removeAttribute("login");
        }

        List<User> users = (List<User>) session.getAttribute("users");
        if (users != null) {
            request.setAttribute("users", users);
            session.removeAttribute("users");
        }

        String numberOfUsers = (String) session.getAttribute("numberOfUsers");
        if (numberOfUsers != null) {
            request.setAttribute("numberOfUsers", numberOfUsers);
            session.removeAttribute("numberOfUsers");
        }

        String name = (String) session.getAttribute("name");
        if (name != null) {
            request.setAttribute("nameValue", name);
            session.removeAttribute("name");
        }

        String surname = (String) session.getAttribute("surname");
        if (surname != null) {
            request.setAttribute("surnameValue", surname);
            session.removeAttribute("surname");
        }

        String phone = (String) session.getAttribute("phone");
        if (phone != null) {
            request.setAttribute("phoneValue", phone);
            session.removeAttribute("phone");
        }

        String email = (String) session.getAttribute("email");
        if (email != null) {
            request.setAttribute("emailValue", email);
            session.removeAttribute("email");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

}
