package com.system.command;

import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;
import com.system.utils.Validator;
import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminAddUser implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_ADD_USER);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("phoneExistError", false);
        request.setAttribute("emailExistError", false);
        request.setAttribute("addUserError", false);
        request.setAttribute("added", false);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = StringEscapeUtils.escapeJava(request.getParameter("email"));

            // Validation
            if (!validation(name, surname)) {
                request.setAttribute("addUserError", true);
                return page;
            }

            // Validation
            if (!Validator.checkPhone(phone)) {
                setRequestAttributes(request, name, surname, phone, email);
                request.setAttribute("phoneExistError", true);
                return page;
            }

            // Validation
            if (!Validator.checkEmail(email)) {
                setRequestAttributes(request, name, surname, phone, email);
                request.setAttribute("emailExistError", true);
                return page;
            }

            // Register new user
            int status = UserService.getInstance().registerUser(name, surname, phone, email);
            if (status == 0) {
                setRequestAttributes(request, name, surname, phone, email);
                request.setAttribute("addUserError", true);
            } else {
                request.setAttribute("added", true);
            }
        }

        return page;
    }

    private boolean validation(String name, String surname) {
        return Validator.checkName(name) &&
                Validator.checkSurname(surname);
    }

    private void setRequestAttributes(HttpServletRequest request, String name, String surname, String phone, String email) {
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
    }

}