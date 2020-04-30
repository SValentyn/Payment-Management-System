package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.UserService;
import com.system.utils.PasswordEncryptor;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandAdminUpdatePassword implements ICommand {

    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_PASSWORD);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_PASSWORD);

            // Set attributes obtained from the session
            setRequestAttributes(request);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_UPDATE_PASSWORD);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check
            if (user == null) {
                setSessionAttributes(request, ServerResponse.UNABLE_GET_USER);
                return pathRedirect;
            }

            // Data
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String passwordConfirmation = request.getParameter("passwordConfirmation");

            // Validation
            if (!validation(request, user, oldPassword, newPassword, passwordConfirmation)) {
                return pathRedirect;
            }

            // Set new password
            user.setPassword(encryptor.encode(newPassword));

            // Action
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                setSessionAttributes(request, oldPassword, newPassword, passwordConfirmation, ServerResponse.PASSWORD_UPDATED_ERROR);
            } else {
                setSessionAttributes(request, ServerResponse.PASSWORD_UPDATED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String oldPassword, String newPassword, String passwordConfirmation) throws SQLException {

        // Validation old password
        if (!checkOldPassword(user, oldPassword)) {
            setSessionAttributes(request, oldPassword, newPassword, passwordConfirmation, ServerResponse.OLD_PASSWORD_ERROR);
            return false;
        }

        // Validation new password
        if (!Validator.checkPassword(newPassword) || !Validator.checkPassword(passwordConfirmation) || !newPassword.equals(passwordConfirmation)) {
            setSessionAttributes(request, oldPassword, newPassword, passwordConfirmation, ServerResponse.NEW_PASSWORD_ERROR);
            return false;
        }

        return true;
    }

    /**
     * @return true, if the old password is not NULL and equal to the current user password
     */
    private boolean checkOldPassword(User user, String oldPassword) throws SQLException {
        if (!Validator.checkPassword(oldPassword)) return false;
        String correctPassword = UserService.getInstance().findUserById(user.getUserId()).getPassword();
        return correctPassword.equals(encryptor.encode(oldPassword));
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("oldPasswordValue", null);
        request.setAttribute("newPasswordValue", null);
        request.setAttribute("passwordConfirmationValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String oldPassword = (String) session.getAttribute("oldPassword");
        if (oldPassword != null) {
            request.setAttribute("oldPasswordValue", oldPassword);
            session.removeAttribute("oldPassword");
        }

        String newPassword = (String) session.getAttribute("newPassword");
        if (newPassword != null) {
            request.setAttribute("newPasswordValue", newPassword);
            session.removeAttribute("newPassword");
        }

        String passwordConfirmation = (String) session.getAttribute("passwordConfirmation");
        if (passwordConfirmation != null) {
            request.setAttribute("passwordConfirmationValue", passwordConfirmation);
            session.removeAttribute("passwordConfirmation");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setSessionAttributes(HttpServletRequest request, String oldPassword, String newPassword, String passwordConfirmation, ServerResponse serverResponse) {
        request.getSession().setAttribute("oldPassword", oldPassword);
        request.getSession().setAttribute("newPassword", newPassword);
        request.getSession().setAttribute("passwordConfirmation", passwordConfirmation);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
