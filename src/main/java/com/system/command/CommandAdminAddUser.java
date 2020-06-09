package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;
import com.system.service.UserService;
import com.system.utils.Validator;
import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandAdminAddUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ADD_USER);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_ADD_USER);

            // Form Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = StringEscapeUtils.escapeJava(request.getParameter("email"));

            // Validation
            if (!validation(request, name, surname, phone, email)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to register a new user");
                return pathRedirect;
            }

            // Action (register new user)
            int userId = UserService.getInstance().registerUser(name, surname, phone, email);
            if (userId == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to register a new user");
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.ADD_USER_ERROR);
            } else {
                logging(currentUser.getUserId(), "REGISTERED: A new user has been successfully added to the system");
                setSessionAttributes(request, userId, ServerResponse.ADD_USER_SUCCESS);
            }
        } else {

            // Set attributes obtained from the session
            setRequestAttributes(request);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String name, String surname, String phone, String email) {

        // Validation name
        if (!Validator.checkName(name)) {
            setSessionAttributes(request, name, surname, phone, email, ServerResponse.ADD_USER_ERROR);
            return false;
        }

        // Validation surname
        if (!Validator.checkSurname(surname)) {
            setSessionAttributes(request, name, surname, phone, email, ServerResponse.ADD_USER_ERROR);
            return false;
        }

        // Validation phone
        if (!Validator.checkPhone(phone)) {
            setSessionAttributes(request, name, surname, phone, email, ServerResponse.PHONE_EXIST_ERROR);
            return false;
        }

        // Validation email
        if (!email.equals("")) {
            if (!Validator.checkEmail(email)) {
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.EMAIL_EXIST_ERROR);
                return false;
            }
        }

        return true;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String userId = (String) session.getAttribute("userId");
        if (userId != null) {
            request.setAttribute("userId", userId);
            session.removeAttribute("userId");
        }

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

    private void setSessionAttributes(HttpServletRequest request, String name, String surname, String phone, String email, ServerResponse serverResponse) {
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, Integer userId, ServerResponse serverResponse) {
        request.getSession().setAttribute("userId", String.valueOf(userId));
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
