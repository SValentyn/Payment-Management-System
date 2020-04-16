package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.LetterService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class CommandAdminShowLetterInfo implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_LETTER_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_LETTER_INFO);

            // Set attributes
            setRequestAttributes(request);

            // The "response" can already store the value obtained from another command
            if (request.getAttribute("response") != "") {
                return pathRedirect;
            }

            // Data
            String letterIdParam = request.getParameter("letterId");

            // Validation
            if (!Validator.checkLetterId(letterIdParam)) {
                request.setAttribute("response", ServerResponse.UNABLE_GET_LETTER_ID.getResponse());
                return pathRedirect;
            }

            // Data
            Letter letter = LetterService.getInstance().findLetterByLetterId(Integer.valueOf(letterIdParam));
            User user = UserService.getInstance().findUserById(letter.getUserId());

            // Check
            if (letter.getIsProcessed()) {
                request.setAttribute("response", ServerResponse.LETTER_WAS_PROCESSED.getResponse());
            }

            // Check
            if (user == null) {
                request.setAttribute("response", ServerResponse.SHOW_LETTER_ERROR.getResponse());
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, letter, user);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_LETTER_INFO);

            // Data
            String letterIdParam = request.getParameter("letterId");

            // Validation
            if (!Validator.checkLetterId(letterIdParam)) {
                return pathRedirect;
            }

            pathRedirect += "&letterId=" + letterIdParam;

            // Data
            Integer letterId = Integer.valueOf(letterIdParam);
            Letter letter = LetterService.getInstance().findLetterByLetterId(letterId);

            // Check
            if (letter.getIsProcessed()) {
                request.getSession().setAttribute("response", ServerResponse.LETTER_WAS_PROCESSED.getResponse());
                return pathRedirect;
            }

            // Action
            int status = LetterService.getInstance().updateLetterByLetterId(letterId);
            if (status == 0) {
                request.getSession().setAttribute("response", ServerResponse.LETTER_PROCESSED_ERROR.getResponse());
            } else {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_LETTER_INFO);
                request.getSession().setAttribute("response", ServerResponse.LETTER_PROCESSED_SUCCESS.getResponse());
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("letterId", null);
        request.setAttribute("bioValue", null);
        request.setAttribute("phoneValue", null);
        request.setAttribute("emailValue", null);
        request.setAttribute("typeQuestionValue", null);
        request.setAttribute("descriptionValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, Letter letter, User user) {
        request.setAttribute("letterId", letter.getLetterId());
        request.setAttribute("bioValue", user.getName() + " " + user.getSurname());
        request.setAttribute("phoneValue", user.getPhone());
        request.setAttribute("emailValue", user.getEmail());
        request.setAttribute("typeQuestionValue", letter.getTypeQuestion());
        request.setAttribute("descriptionValue", letter.getDescription());
    }

}
