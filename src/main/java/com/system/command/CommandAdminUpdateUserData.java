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

public class CommandAdminUpdateUserData implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_USER_DATA);

        request.setAttribute("updated", false);
        request.setAttribute("phoneExistError", false);
        request.setAttribute("updateUserDataError", false);

        String userId = request.getParameter("userId");
        request.setAttribute("userId", userId);

        if (userId == null) {
            request.setAttribute("updateUserDataError", true);
            return page;
        }

        User user = UserService.getInstance().findUserById(Integer.valueOf(userId));

        // Set Attributes
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");

            // Check
            if (checkName(request, name) ||
                    checkSurname(request, surname) ||
                    checkPhone(request, phone)) {
                setRequestAttributes(request, name, surname, phone, email);
                return page;
            }

            // Check
            if (!user.getPhone().equals(phone)) {
                List<User> users = UserService.getInstance().findAllUsers();
                for (User aUser : users) {
                    if (aUser.getPhone().equals(phone)) {
                        setRequestAttributes(request, name, surname, phone, email);
                        request.setAttribute("phoneExistError", true);
                        return page;
                    }
                }
            }

            // Set new user properties
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);

            // Update
            int status = UserService.getInstance().updateUser(user);
            setRequestAttributes(request, name, surname, phone, email);
            if (status == 0) {
                request.setAttribute("updateUserDataError", true);
            } else {
                request.setAttribute("updated", true);
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

    private void setRequestAttributes(HttpServletRequest request, String name, String surname, String phone, String email) {
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
    }

}