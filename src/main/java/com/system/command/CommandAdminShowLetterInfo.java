package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;
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

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_LETTER_INFO);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_LETTER_INFO);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // URL Data
            String letterIdParam = request.getParameter("letterId");

            // Validation
            if (!validation(request, letterIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, letterIdParam);

        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_LETTER_INFO);

            // Form Data
            String letterIdParam = request.getParameter("letterId");

            // Validation
            if (!validation(request, letterIdParam)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to process the letter");
                return pathRedirect;
            }

            // Action (letter processing)
            int status = LetterService.getInstance().updateLetterByLetterId(Integer.valueOf(letterIdParam));
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to process the letter");
                setSessionAttributes(request, ServerResponse.LETTER_PROCESSED_ERROR);
            } else {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_LETTER_INFO);
                logging(currentUser.getUserId(), "PROCESSED: Letter was successfully processed");
                setSessionAttributes(request, ServerResponse.LETTER_PROCESSED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String letterIdParam) {

        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {

            // The "response" can already store the value obtained from another command
            if (request.getAttribute("response") != ServerResponse.EMPTY.getResponse()) {
                return false;
            }

            // Validation letterId
            if (!Validator.checkLetterId(letterIdParam)) {
                setRequestAttributes(request, ServerResponse.UNABLE_GET_LETTER_ID);
                return false;
            }

            // Checking that the letter has been processed
            if (LetterService.getInstance().findLetterByLetterId(Integer.valueOf(letterIdParam)).getIsProcessed()) {
                setRequestAttributes(request, ServerResponse.LETTER_WAS_PROCESSED);
            }
        } else {

            // Validation letterId
            if (!Validator.checkLetterId(letterIdParam)) {
                setSessionAttributes(request, ServerResponse.UNABLE_GET_LETTER_ID);
                return false;
            }

            // Change redirect path
            pathRedirect += "&letterId=" + letterIdParam;

            // Checking that the letter has been processed
            if (LetterService.getInstance().findLetterByLetterId(Integer.valueOf(letterIdParam)).getIsProcessed()) {
                setSessionAttributes(request, ServerResponse.LETTER_WAS_PROCESSED);
                return false;
            }
        }

        return true;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, String letterIdParam) {
        Letter letter = LetterService.getInstance().findLetterByLetterId(Integer.valueOf(letterIdParam));
        User user = UserService.getInstance().findUserById(letter.getUserId());

        if (user != null) {
            request.setAttribute("letterId", letter.getLetterId());
            request.setAttribute("bioValue", user.getName() + " " + user.getSurname());
            request.setAttribute("phoneValue", user.getPhone());
            request.setAttribute("emailValue", user.getEmail());
            request.setAttribute("typeQuestionValue", letter.getTypeQuestion());
            request.setAttribute("descriptionValue", letter.getDescription());
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_LETTER_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
