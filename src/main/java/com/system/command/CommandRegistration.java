package com.system.command;

import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.UserService;
import com.system.utils.Validator;
import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandRegistration implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.REGISTRATION);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            setRequestAttributes(request);
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.REGISTRATION);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_REGISTRATION);

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = StringEscapeUtils.escapeJava(request.getParameter("email"));
            String password = request.getParameter("password");
            String passwordConfirmation = request.getParameter("passwordConfirmation");

            // Validation
            if (!validation(name, surname, password, passwordConfirmation)) {
                setSessionAttributes(request, name, surname, phone, email, password, passwordConfirmation, ServerResponse.INVALID_DATA);
                return pathRedirect;
            }

            // Validation phone
            if (!Validator.checkPhone(phone)) {
                setSessionAttributes(request, name, surname, phone, email, password, passwordConfirmation, ServerResponse.PHONE_EXIST_ERROR);
                return pathRedirect;
            }

            // Validation email
            if (!Validator.checkEmail(email)) {
                setSessionAttributes(request, name, surname, phone, email, password, passwordConfirmation, ServerResponse.EMAIL_EXIST_ERROR);
                return pathRedirect;
            }

            // Create
            int status = UserService.getInstance().registerUser(name, surname, phone, email, password);
            if (status == 0) {
                setSessionAttributes(request, name, surname, phone, email, password, passwordConfirmation, ServerResponse.REGISTRATION_ERROR);
            } else {
                setSessionAttributes(request, null, null, null, null, null, null, ServerResponse.REGISTRATION_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(String name, String surname, String password, String passwordConfirmation) {
        return Validator.checkName(name) &&
                Validator.checkSurname(surname) &&
                Validator.checkPassword(password) &&
                Validator.checkPassword(passwordConfirmation) &&
                password.equals(passwordConfirmation);
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("nameValue", null);
        request.setAttribute("surnameValue", null);
        request.setAttribute("phoneValue", null);
        request.setAttribute("emailValue", null);
        request.setAttribute("passwordValue", null);
        request.setAttribute("passwordConfirmationValue", null);
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

        String password = (String) session.getAttribute("password");
        if (password != null) {
            request.setAttribute("passwordValue", password);
            session.removeAttribute("password");
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

    private void setSessionAttributes(HttpServletRequest request, String name, String surname, String phone, String email, String password, String passwordConfirmation, ServerResponse serverResponse) {
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("password", password);
        request.getSession().setAttribute("passwordConfirmation", passwordConfirmation);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
