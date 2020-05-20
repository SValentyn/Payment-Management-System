package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;
import com.system.service.UserService;
import com.system.utils.PasswordEncryptor;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandUserUpdatePersonalData implements ICommand {

    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_UPDATE_PERSONAL_DATA);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_UPDATE_PERSONAL_DATA);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");

            // Check and set attributes
            if (currentUser != null) {
                setRequestAttributes(request, currentUser);
            } else {
                request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            }

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_UPDATE_PERSONAL_DATA);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone");  // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validation
            if (!validation(request, currentUser, name, surname, phone, email, password)) {
                if (currentUser != null)
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to update personal data");
                return pathRedirect;
            }

            // Set new user properties
            currentUser.setName(name);
            currentUser.setSurname(surname);
            currentUser.setPhone(phone);
            currentUser.setEmail(email);
            currentUser.setPassword(encryptor.encode(password));

            // Action (update data)
            int status = UserService.getInstance().updateUser(currentUser);
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to update personal data");
                setSessionAttributes(request, ServerResponse.DATA_UPDATED_ERROR);
            } else {
                logging(currentUser.getUserId(), "UPDATED: Unsuccessful attempt to update personal data");
                setSessionAttributes(request, ServerResponse.DATA_UPDATED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String name, String surname, String phone, String email, String password) throws SQLException {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation password
        if (!checkPassword(currentUser, password)) {
            setSessionAttributes(request, name, surname, phone, email, password, ServerResponse.PASSWORD_NOT_MATCH_ERROR);
            return false;
        }

        // Validation name
        if (!Validator.checkName(name)) {
            setSessionAttributes(request, name, surname, phone, email, null, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation surname
        if (!Validator.checkSurname(surname)) {
            setSessionAttributes(request, name, surname, phone, email, null, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation if the phone has been changed
        if (!currentUser.getPhone().equals(phone)) {
            if (!Validator.checkPhone(phone)) {
                setSessionAttributes(request, name, surname, phone, email, null, ServerResponse.PHONE_EXIST_ERROR);
                return false;
            }
        }

        // Validation if the email has been changed
        if (!currentUser.getEmail().equals(email)) {
            if (!Validator.checkEmail(email)) {
                setSessionAttributes(request, name, surname, phone, email, null, ServerResponse.EMAIL_EXIST_ERROR);
                return false;
            }
        }

        return true;
    }

    /**
     * @return true, if the password is not NULL and equal to the current user password
     */
    private boolean checkPassword(User currentUser, String password) throws SQLException {
        if (!Validator.checkPassword(password)) return false;
        String correctPassword = UserService.getInstance().findUserById(currentUser.getUserId()).getPassword();
        return correctPassword.equals(encryptor.encode(password));
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("nameValue", null);
        request.setAttribute("surnameValue", null);
        request.setAttribute("phoneValue", null);
        request.setAttribute("emailValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, User currentUser) {
        request.setAttribute("nameValue", currentUser.getName());
        request.setAttribute("surnameValue", currentUser.getSurname());
        request.setAttribute("phoneValue", currentUser.getPhone());
        request.setAttribute("emailValue", currentUser.getEmail());

        HttpSession session = request.getSession();

        String name = (String) session.getAttribute("name");
        if (name != null) {
            request.setAttribute("nameValue", name);
            session.removeAttribute("name");
        }

        String surname = (String) session.getAttribute("surname");
        if (surname != null) {
            request.setAttribute("surnameValue", surname);
            session.removeAttribute("surname");
        }

        String phone = (String) session.getAttribute("phone");
        if (phone != null) {
            request.setAttribute("phoneValue", phone);
            session.removeAttribute("phone");
        }

        String email = (String) session.getAttribute("email");
        if (email != null) {
            request.setAttribute("emailValue", email);
            session.removeAttribute("email");
        }

        String password = (String) session.getAttribute("password");
        if (password != null) {
            request.setAttribute("passwordValue", password);
            session.removeAttribute("password");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setSessionAttributes(HttpServletRequest request, String name, String surname, String phone, String email, String password, ServerResponse serverResponse) {
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("password", password);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) throws SQLException {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
