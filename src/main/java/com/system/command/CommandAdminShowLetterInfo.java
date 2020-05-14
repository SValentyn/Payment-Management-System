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

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_LETTER_INFO);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_LETTER_INFO);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            String letterIdParam = request.getParameter("letterId");

            // Validation
            if (!validation(request, letterIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, letterIdParam);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_LETTER_INFO);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String letterIdParam = request.getParameter("letterId");

            // Validation
            if (!validation(request, currentUser, letterIdParam)) {
                if (currentUser != null)
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to process the letter");
                return pathRedirect;
            }

            // Action (letter processing) and set attributes
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

    private boolean validation(HttpServletRequest request, String letterIdParam) throws SQLException {

        // The "response" can already store the value obtained from another command
        if (request.getAttribute("response") != "") {
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

        return true;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String letterIdParam) throws SQLException {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation letterId
        if (!Validator.checkLetterId(letterIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_LETTER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&letterId=" + letterIdParam;

        // Data
        Letter letter = LetterService.getInstance().findLetterByLetterId(Integer.valueOf(letterIdParam));

        // Checking that the letter has been processed
        if (letter.getIsProcessed()) {
            setSessionAttributes(request, ServerResponse.LETTER_WAS_PROCESSED);
            return false;
        }

        return true;
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

    private void setRequestAttributes(HttpServletRequest request, String letterIdParam) throws SQLException {
        Integer letterId = Integer.valueOf(letterIdParam);
        Letter letter = LetterService.getInstance().findLetterByLetterId(letterId);
        User user = UserService.getInstance().findUserById(letter.getUserId());

        if (user != null) {
            request.setAttribute("letterId", letterId);
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

    private void logging(Integer userId, String description) throws SQLException {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
