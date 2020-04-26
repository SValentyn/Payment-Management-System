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

public class CommandAdminUpdatePersonalData implements ICommand {

    private final PasswordEncryptor encryptor = new PasswordEncryptor();

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_DATA);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_DATA);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check
            if (user == null) {
                request.setAttribute("response", ServerResponse.DATA_UPDATED_ERROR.getResponse());
                return pathRedirect;
            }

            // Set Attributes
            setRequestAttributes(request, user);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_UPDATE_DATA);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check
            if (user == null) {
                setSessionAttributes(request, ServerResponse.DATA_UPDATED_ERROR);
                return pathRedirect;
            }

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validation
            if (!validation(request, user, name, surname, phone, email, password)) {
                return pathRedirect;
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
                setSessionAttributes(request, ServerResponse.DATA_UPDATED_ERROR);
            } else {
                setSessionAttributes(request, ServerResponse.DATA_UPDATED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String name, String surname, String phone, String email, String password) throws SQLException {

        // Validation password
        if (!checkPassword(user, password)) {
            setSessionAttributes(request, name, surname, phone, email, ServerResponse.PASSWORD_NOT_MATCH_ERROR);
            return false;
        }

        // Validation name
        if (!Validator.checkName(name)) {
            setSessionAttributes(request, name, surname, phone, email, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation surname
        if (!Validator.checkSurname(surname)) {
            setSessionAttributes(request, name, surname, phone, email, ServerResponse.INVALID_DATA);
            return false;
        }

        // Validation if the phone has been changed
        if (!user.getPhone().equals(phone)) {
            if (!Validator.checkPhone(phone)) {
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.PHONE_EXIST_ERROR);
                return false;
            }
        }

        // Validation if the email has been changed
        if (!user.getEmail().equals(email)) {
            if (!Validator.checkEmail(email)) {
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.EMAIL_EXIST_ERROR);
                return false;
            }
        }

        return true;
    }

    /**
     * @return true, if the password is not NULL and equal to the current user password
     */
    private boolean checkPassword(User user, String password) throws SQLException {
        if (!Validator.checkPassword(password)) return false;
        String correctPassword = UserService.getInstance().findUserById(user.getUserId()).getPassword();
        return correctPassword.equals(encryptor.encode(password));
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("nameValue", null);
        request.setAttribute("surnameValue", null);
        request.setAttribute("phoneValue", null);
        request.setAttribute("emailValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
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

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
    }

    private void setSessionAttributes(HttpServletRequest request, String name, String surname, String phone, String email, ServerResponse serverResponse) {
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
