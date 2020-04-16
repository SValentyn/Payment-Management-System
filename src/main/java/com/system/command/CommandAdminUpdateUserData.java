package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandAdminUpdateUserData implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_USER_DATA);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_USER_DATA);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
                request.setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
                return pathRedirect;
            }

            // Data
            User user = UserService.getInstance().findUserById(Integer.valueOf(userIdParam));

            // Set Attributes
            setRequestAttributes(request, user);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_UPDATE_USER_DATA);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
                return pathRedirect;
            }

            pathRedirect += "&userId=" + userIdParam;

            // Data
            Integer userId = Integer.parseInt(userIdParam);
            User user = UserService.getInstance().findUserById(userId);
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");

            // Validation
            if (!validation(name, surname)) {
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.INVALID_DATA);
                return pathRedirect;
            }

            // Validation phone
            if (!user.getPhone().equals(phone)) {
                if (!Validator.checkPhone(phone)) {
                    setSessionAttributes(request, name, surname, phone, email, ServerResponse.PHONE_EXIST_ERROR);
                    return pathRedirect;
                }
            }

            // Validation email
            if (!user.getEmail().equals(email)) {
                if (!Validator.checkEmail(email)) {
                    setSessionAttributes(request, name, surname, phone, email, ServerResponse.EMAIL_EXIST_ERROR);
                    return pathRedirect;
                }
            }

            // Set new user properties
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);

            // Action
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                setSessionAttributes(request, name, surname, phone, email, ServerResponse.DATA_UPDATED_ERROR);
            } else {
                request.getSession().setAttribute("response", ServerResponse.DATA_UPDATED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private boolean validation(String name, String surname) {
        return Validator.checkName(name) &&
                Validator.checkSurname(surname);
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("nameValue", null);
        request.setAttribute("surnameValue", null);
        request.setAttribute("phoneValue", null);
        request.setAttribute("emailValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());

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

    private void setSessionAttributes(HttpServletRequest request, String name, String surname, String phone, String email, ServerResponse serverResponse) {
        request.getSession().setAttribute("name", name);
        request.getSession().setAttribute("surname", surname);
        request.getSession().setAttribute("phone", phone);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
