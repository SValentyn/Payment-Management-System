package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminAddUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ADD_USER);

        request.setAttribute("added", false);
        request.setAttribute("phoneExistError", false);
        request.setAttribute("userId", null);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");

            // Check
            List<User> users = UserService.getInstance().findAllUsers();
            for (User user : users) {
                if (user.getPhone().equals(phone)) {
                    setRequestAttributes(request, name, surname, phone, email);
                    request.setAttribute("phoneExistError", true);
                    return page;
                }
            }

            // Register User
            int status = UserService.getInstance().registerUser(name, surname, phone, email);
            if (status == 0) {
                setRequestAttributes(request, name, surname, phone, email);
                request.setAttribute("addUserError", true);
            } else {
                request.setAttribute("userId", status);
                request.setAttribute("added", true);
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String name, String surname, String phone, String email) {
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
    }

}