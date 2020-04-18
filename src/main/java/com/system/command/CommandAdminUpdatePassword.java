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

public class CommandAdminUpdatePassword implements ICommand {

    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_PASSWORD);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("oldPasswordError", false);
        request.setAttribute("newPasswordError", false);
        request.setAttribute("updatePasswordError", false);
        request.setAttribute("updated", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        if (user == null) {
            request.setAttribute("updatePasswordError", true);
            return page;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            Integer userId = user.getUserId();
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String passwordConfirmation = request.getParameter("passwordConfirmation");

            // Check
            if (checkOldPassword(userId, oldPassword)) {
                setRequestAttributes(request, oldPassword, newPassword, passwordConfirmation);
                request.setAttribute("oldPasswordError", true);
                return page;
            }

            // Validation
            if (!validation(newPassword, passwordConfirmation)) {
                setRequestAttributes(request, oldPassword, newPassword, passwordConfirmation);
                request.setAttribute("newPasswordError", true);
                return page;
            }

            // Set new user properties
            user.setPassword(encryptor.encode(newPassword));

            // Action
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                setRequestAttributes(request, oldPassword, newPassword, passwordConfirmation);
                request.setAttribute("updatePasswordError", true);
            } else {
                request.setAttribute("updated", true);
            }
        }

        return page;
    }

    private boolean checkOldPassword(Integer userId, String oldPassword) throws SQLException {
        String correctPassword = UserService.getInstance().findUserById(userId).getPassword();
        return !correctPassword.equals(encryptor.encode(oldPassword));
    }

    private boolean validation(String newPassword, String passwordConfirmation) {
        return Validator.checkPassword(newPassword) &&
                Validator.checkPassword(passwordConfirmation) &&
                newPassword.equals(passwordConfirmation);
    }

    private void setRequestAttributes(HttpServletRequest request, String oldPassword, String newPassword, String passwordConfirmation) {
        request.setAttribute("oldPasswordValue", oldPassword);
        request.setAttribute("newPasswordValue", newPassword);
        request.setAttribute("passwordConfirmationValue", passwordConfirmation);
    }

}
