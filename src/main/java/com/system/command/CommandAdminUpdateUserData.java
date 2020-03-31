package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminUpdateUserData implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_USER_DATA);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("phoneExistError", false);
        request.setAttribute("updateUserDataError", false);
        request.setAttribute("updated", false);

        // Data
        String userIdParam = request.getParameter("userId");

        // Validation
        if (!Validator.checkUserId(userIdParam)) {
            request.setAttribute("updateUserDataError", true);
            return page;
        }

        Integer userId = Integer.parseInt(userIdParam);
        User user = UserService.getInstance().findUserById(userId);

        // Set Attributes
        setRequestAttributes(request, user);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");

            // Validation
            if (!validation(name, surname)) {
                request.setAttribute("updateUserDataError", true);
                return page;
            }

            // Check if the phone has been changed
            if (!user.getPhone().equals(phone)) {
                if (!Validator.checkPhone(phone)) {
                    setRequestAttributes(request, userId, name, surname, phone, email);
                    request.setAttribute("phoneExistError", true);
                    return page;
                }
            }

            // Check if the email has been changed
            if (!user.getEmail().equals(email)) {
                if (!Validator.checkEmail(email)) {
                    setRequestAttributes(request, userId, name, surname, phone, email);
                    request.setAttribute("emailExistError", true);
                    return page;
                }
            }

            // Set new user properties
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);

            // Update
            setRequestAttributes(request, user);
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                request.setAttribute("updateUserDataError", true);
            } else {
                request.setAttribute("updated", true);
            }
        }

        return page;
    }

    private boolean validation(String name, String surname) {
        return Validator.checkName(name) &&
                Validator.checkSurname(surname);
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
    }

    private void setRequestAttributes(HttpServletRequest request, Integer userId, String name, String surname, String phone, String email) {
        request.setAttribute("userId", userId);
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
    }

}
