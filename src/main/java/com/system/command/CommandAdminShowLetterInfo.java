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

        String page = ResourceManager.getInstance().getProperty(ResourceManager.LETTER_INFO);

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
            Integer userId = letter.getUserId();
            User user = UserService.getInstance().findUserById(userId);

            // Check
            if (user != null) {
                request.setAttribute("letterId", letterId);
            } else {
                request.setAttribute("letterError", true);
                return page;
            }

            // Set attributes
            request.setAttribute("description", letter.getDescription());
            request.setAttribute("bio", user.getName() + " " + user.getSurname());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("email", user.getEmail());

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            LetterService.getInstance().updateLetterByLetterId(Integer.parseInt(letterId));
            request.setAttribute("processed", true);
        }

        return page;
    }

}
