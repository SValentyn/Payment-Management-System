package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.UserService;
import com.system.utils.PasswordEncryptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserUpdatePassword implements ICommand {

    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_UPDATE_PASSWORD);

        request.setAttribute("updated", false);
        request.setAttribute("passwordNotMatchError", false);
        request.setAttribute("passwordUpdateError", false);

        User user = (User) request.getSession().getAttribute("currentUser");
        request.getSession().setAttribute("currentUser", UserService.getInstance().findUserById(user.getUserId()));

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
            if (checkOldPassword(request, userId, oldPassword)) {
                setRequestAttributes(request, newPassword, passwordConfirmation, oldPassword);
                request.setAttribute("passwordNotMatchError", true);
                return page;
            }

            // Set new user property
            user.setPassword(encryptor.encode(newPassword));

            // Update
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                setRequestAttributes(request, newPassword, passwordConfirmation, oldPassword);
                request.setAttribute("passwordUpdateError", true);
            } else {
                request.setAttribute("updated", true);
            }
        }

        return page;
    }

    private boolean checkOldPassword(HttpServletRequest request, Integer userId, String oldPassword) throws SQLException {
        String correctPassword = UserService.getInstance().findUserById(userId).getPassword();
        if (!correctPassword.equals(encryptor.encode(oldPassword))) {
            request.setAttribute("passwordNotMatchError", true);
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
