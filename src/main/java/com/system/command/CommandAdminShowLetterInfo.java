package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import com.system.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class CommandAdminShowLetterInfo implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_LETTER_INFO);

        request.setAttribute("processed", false);
        request.setAttribute("letterError", false);

        String letterId = request.getParameter("letterId");

        if (letterId == null) {
            request.setAttribute("letterError", true);
            return page;
        }

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {

            // Data
            Letter letter = LetterService.getInstance().findLetterByLetterId(Integer.parseInt(letterId));
            User user = UserService.getInstance().findUserById(letter.getUserId());

            // Check
            if (user != null) {
                request.setAttribute("letterId", letterId);
            } else {
                request.setAttribute("letterError", true);
                return page;
            }

            // Set attributes
            setRequestAttributes(request, user, letter);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Letter processed
            LetterService.getInstance().updateLetterByLetterId(Integer.parseInt(letterId));
            request.setAttribute("processed", true);
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, User user, Letter letter) {
        request.setAttribute("bioValue", user.getName() + " " + user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
        request.setAttribute("descriptionValue", letter.getDescription());
    }

}
