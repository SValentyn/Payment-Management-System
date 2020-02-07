package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandRegistration implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.REGISTRATION);

        request.setAttribute("created", false);
        request.setAttribute("phoneExistError", false);
        request.setAttribute("registrationError", false);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String passwordConfirmation = request.getParameter("passwordConfirmation");

            // Check
            if (checkName(request, name) ||
                    checkSurname(request, surname) ||
                    checkPhone(request, phone) ||
                    checkPassword(request, password) ||
                    checkPasswordConfirmation(request, password, passwordConfirmation)) {
                setRequestAttributes(request, name, surname, phone, email, password, passwordConfirmation);
                return page;
            }

            // Check
            List<User> users = UserService.getInstance().findAllUsers();
            for (User user : users) {
                if (user.getPhone().equals(phone)) {
                    setRequestAttributes(request, name, surname, phone, email, password, passwordConfirmation);
                    request.setAttribute("phoneExistError", true);
                    return page;
                }
            }

            // Create
            int status = UserService.getInstance().registerUser(name, surname, phone, email, password);
            if (status == 0) {
                request.setAttribute("registrationError", true);
                setRequestAttributes(request, name, surname, phone, email, password, passwordConfirmation);
            } else {
                request.setAttribute("created", true);
            }
        }

        return page;
    }

    private boolean checkName(HttpServletRequest request, String name) {
        if (name == null || name.isEmpty()) {
            request.setAttribute("nameError", true);
            return true;
        }

        if (Validator.checkLengthName(name)) {
            request.setAttribute("nameLengthError", true);
            return true;
        }
        return false;
    }

    private boolean checkSurname(HttpServletRequest request, String surname) {
        if (surname == null || surname.isEmpty()) {
            request.setAttribute("surnameError", true);
            return true;
        }

        if (Validator.checkLengthSurname(surname)) {
            request.setAttribute("surnameLengthError", true);
            return true;
        }
        return false;
    }

    private boolean checkPhone(HttpServletRequest request, String phone) {
        if (phone == null || phone.isEmpty() || !Validator.checkPhoneNumber(phone)) {
            request.setAttribute("phoneError", true);
            return true;
        }
        return false;
    }

    private boolean checkPassword(HttpServletRequest request, String password) {
        if (password == null || password.isEmpty() || !Validator.checkPassword(password)) {
            request.setAttribute("passwordError", true);
            return true;
        }
        return false;
    }

    private boolean checkPasswordConfirmation(HttpServletRequest request, String password, String passwordConfirmation) {
        if (!password.equals(passwordConfirmation)) {
            request.setAttribute("passwordConfirmationError", true);
            return true;
        }
        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String name, String surname, String phone, String email, String password, String passwordConfirmation) {
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
        request.setAttribute("passwordValue", password);
        request.setAttribute("passwordConfirmationValue", passwordConfirmation);
    }

}
