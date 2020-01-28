package com.system.command;

import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.UserService;
import com.system.utils.StringValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAddUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADD_USER);
        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("phone");

            // Check
            if (checkName(request, name, surname, phone) ||
                    checkSurname(request, name, surname, phone) ||
                    checkPhone(request, name, surname, phone)) {
                return page;
            }

            // Create
            int status = UserService.getInstance().addNewUser(name, surname, phone); // id
            if (status == 0) {
                userCreateError(request);
            } else {
                // change page (ADD_USER -> ADMIN) and set attributes
                page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN);
                request.setAttribute("showUser", true);
                request.setAttribute("user", UserService.getInstance().findUserById(status));
            }
        }

        return page;
    }

    private boolean checkName(HttpServletRequest request, String name, String surname, String phone) {
        if (name == null || name.isEmpty()) {
            request.setAttribute("nameError", true);
            request.setAttribute("nameValue", name);
            request.setAttribute("surnameValue", surname);
            request.setAttribute("phoneValue", phone);
            return true;
        }
        return false;
    }

    private boolean checkSurname(HttpServletRequest request, String name, String surname, String phone) {
        if (surname == null || surname.isEmpty()) {
            request.setAttribute("surnameError", true);
            request.setAttribute("nameValue", name);
            request.setAttribute("surnameValue", surname);
            request.setAttribute("phoneValue", phone);
            return true;
        }
        return false;
    }

    private boolean checkPhone(HttpServletRequest request, String name, String surname, String phone) {
        if (phone == null || phone.isEmpty() || !StringValidator.checkPhoneNumber(phone)) {
            request.setAttribute("phoneError", true);
            request.setAttribute("nameValue", name);
            request.setAttribute("surnameValue", surname);
            request.setAttribute("phoneValue", phone);
            return true;
        }
        return false;
    }

    private void userCreateError(HttpServletRequest request) {
        request.setAttribute("errorOccurred", true);
    }
}