package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;
import com.system.utils.PasswordEncryptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminUpdatePersonalData implements ICommand {

    private PasswordEncryptor encryptor = new PasswordEncryptor();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_UPDATE_DATA);

        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());
        request.setAttribute("updated", false);
        request.setAttribute("phoneExistError", false);
        request.setAttribute("updateDataError", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        // Set Attributes
        setRequestAttributes(request, user);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            Integer userId = user.getUserId();
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String phone = request.getParameter("full_phone"); // set in the validator file (hiddenInput: "full_phone")
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Check
            if (checkPassword(request, userId, password)) {
                setRequestAttributes(request, name, surname, phone, email, password);
                return page;
            }

            // Check
            if (!user.getPhone().equals(phone)) {
                List<User> users = UserService.getInstance().findAllUsers();
                for (User aUser : users) {
                    if (aUser.getPhone().equals(phone)) {
                        setRequestAttributes(request, name, surname, phone, email, password);
                        request.setAttribute("phoneExistError", true);
                        return page;
                    }
                }
            }

            // Set new user properties
            user.setName(name);
            user.setSurname(surname);
            user.setPhone(phone);
            user.setEmail(email);
            user.setPassword(encryptor.encode(password));

            // Update
            setRequestAttributes(request, name, surname, phone, email, password);
            int status = UserService.getInstance().updateUser(user);
            if (status == 0) {
                request.setAttribute("updateDataError", true);
            } else {
                request.setAttribute("updated", true);
            }
        }

        return page;
    }

    private boolean checkPassword(HttpServletRequest request, Integer userId, String password) throws SQLException {
        String correctPassword = UserService.getInstance().findUserById(userId).getPassword();
        if (!correctPassword.equals(encryptor.encode(password))) {
            request.setAttribute("passwordNotMatchError", true);
            return true;
        }
        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, User user) {
        request.setAttribute("nameValue", user.getName());
        request.setAttribute("surnameValue", user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
    }

    private void setRequestAttributes(HttpServletRequest request, String name, String surname, String phone, String email, String password) {
        request.setAttribute("nameValue", name);
        request.setAttribute("surnameValue", surname);
        request.setAttribute("phoneValue", phone);
        request.setAttribute("emailValue", email);
        request.setAttribute("passwordValue", password);
    }

}
