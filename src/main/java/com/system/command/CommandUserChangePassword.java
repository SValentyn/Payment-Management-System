package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.UserService;
import com.system.utils.PasswordEncryptor;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserChangePassword implements ICommand {
    PasswordEncryptor encryptor = new PasswordEncryptor();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_CHANGE_PASSWORD);

        request.setAttribute("updated", false);
        request.setAttribute("changePasswordError", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            Integer userId = user.getUserId();
            String newPassword = request.getParameter("newPassword");
            String passwordConfirmation = request.getParameter("passwordConfirmation");
            String oldPassword = request.getParameter("oldPassword");

            // Check
            if (checkNewPassword(request, newPassword) ||
                    checkPasswordConfirmation(request, newPassword, passwordConfirmation) ||
                    checkOldPassword(request, userId, oldPassword)) {
                setRequestAttributes(request, newPassword, passwordConfirmation, oldPassword);
                return page;
            }

            // Set new user properties
            user.setPassword(encryptor.encode(newPassword));

            // Update
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                setRequestAttributes(request, newPassword, passwordConfirmation, oldPassword);
                request.setAttribute("changePasswordError", true);
            } else {
                request.setAttribute("updated", true);
            }
        }

        return page;
    }

    private boolean checkNewPassword(HttpServletRequest request, String password) {
        if (password == null || password.isEmpty() || !Validator.checkPassword(password)) {
            request.setAttribute("newPasswordError", true);
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

    private boolean checkOldPassword(HttpServletRequest request, Integer userId, String oldPassword) throws SQLException {
        String correctPassword = UserService.getInstance().findUserById(userId).getPassword();
        if (!correctPassword.equals(encryptor.encode(oldPassword))) {
            request.setAttribute("oldPasswordError", true);
            return true;
        }
        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String password, String passwordConfirmation, String oldPassword) {
        request.setAttribute("newPasswordValue", password);
        request.setAttribute("passwordConfirmationValue", passwordConfirmation);
        request.setAttribute("oldPasswordValue", oldPassword);
    }

}
