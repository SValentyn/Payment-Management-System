package com.system.command;

import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandRecoveryPassword implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String pathRedirect;

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_RECOVERY);

            // Form Data
            String login = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")

            // Validation
            if (!validation(request, login)) {
                return pathRedirect;
            }

            // [There should be an implementation of sending a message with a password to the user]

            // Set attributes
            setSessionAttributes(request, ServerResponse.PASSWORD_SENT);
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.RECOVERY);

            // Set attributes obtained from the session
            setRequestAttributes(request);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String login) {

        // Validation
        if (!Validator.checkLogin(login)) {
            setSessionAttributes(request, login, ServerResponse.LOGIN_NOT_EXIST);
            return false;
        }

        return true;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String login = (String) session.getAttribute("login");
        if (login != null) {
            request.setAttribute("loginValue", login);
            session.removeAttribute("login");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setSessionAttributes(HttpServletRequest request, String login, ServerResponse serverResponse) {
        request.getSession().setAttribute("login", login);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
