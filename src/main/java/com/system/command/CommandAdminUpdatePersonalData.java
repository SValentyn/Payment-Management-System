package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;
import com.system.utils.PasswordEncryptor;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminUpdatePersonalData implements ICommand {

    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_DATA);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("passwordNotMatchError", false);
        request.setAttribute("phoneExistError", false);
        request.setAttribute("emailExistError", false);
        request.setAttribute("updateDataError", false);
        request.setAttribute("updated", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        if (user == null) {
            request.setAttribute("updateDataError", true);
            return page;
        }

        // Set Attributes
        setRequestAttributes(request, user);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            Integer userId = user.getUserId();
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Set Attributes
            setRequestAttributes(request, name, surname, phone, email);

            // Check
            if (!checkPassword(userId, password)) {
                request.setAttribute("passwordNotMatchError", true);
                return page;
            }

            // Validation
            if (!validation(name, surname)) {
                request.setAttribute("updateDataError", true);
                return page;
            }

            // Check if the phone has been changed
            if (!user.getPhone().equals(phone)) {
                if (!Validator.checkPhone(phone)) {
                    request.setAttribute("phoneExistError", true);
                    return page;
                }
            }

            // Check if the email has been changed
            if (!user.getEmail().equals(email)) {
                if (!Validator.checkEmail(email)) {
                    request.setAttribute("emailExistError", true);
                    return page;
                }
            }

            // Set new user properties
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);
            user.setPassword(encryptor.encode(password));

            // Action
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                request.setAttribute("updateDataError", true);
            } else {
                request.setAttribute("updated", true);
            }
        }

        return page;
    }

    private boolean checkPassword(Integer userId, String password) throws SQLException {
        if (!Validator.checkPassword(password)) return false;
        String correctPassword = UserService.getInstance().findUserById(userId).getPassword();
        return correctPassword.equals(encryptor.encode(password));
    }

    private boolean validation(String name, String surname) {
        return Validator.checkName(name) &&
                Validator.checkSurname(surname);
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
    }

    private void setRequestAttributes(HttpServletRequest request, String name, String surname, String phone, String email) {
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
    }

}
