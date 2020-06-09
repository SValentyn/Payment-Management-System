package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;
import com.system.service.LetterService;
import com.system.utils.Validator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class CommandUserSupport implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SUPPORT);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SUPPORT);

            // Form Data
            String typeQuestion = request.getParameter("typeQuestion");
            String description = request.getParameter("description");

            // Validation
            if (!validation(request, currentUser, typeQuestion, description)) {
                logging(currentUser.getUserId(), "Unsuccessful attempt to send a letter to Support");
                return pathRedirect;
            }

            // Action (send a letter)
            int status = LetterService.getInstance().addNewLetter(currentUser.getUserId(), Integer.valueOf(typeQuestion), description);
            if (status == 0) {
                logging(currentUser.getUserId(), "Unsuccessful attempt to send a letter to Support");
                setSessionAttributes(request, description, ServerResponse.LETTER_SENT_ERROR);
            } else {
                setSessionAttributes(request, ServerResponse.LETTER_SENT_SUCCESS);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SUPPORT);

            // Set attributes obtained from the session
            setRequestAttributes(request);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String typeQuestion, String description) {

        // Validation type question
        if (!Validator.checkTypeQuestion(typeQuestion)) {
            setSessionAttributes(request, description, ServerResponse.LETTER_SENT_ERROR);
            return false;
        }

        // Data
        int numberOfNotProcessedLetters = 0;
        for (Letter letter : LetterService.getInstance().findLettersByUserId(currentUser.getUserId())) {
            if (!letter.getIsProcessed()) numberOfNotProcessedLetters++;
        }

        // Checking that the user has sent in support of more than 3 letters that have not yet been processed
        if (numberOfNotProcessedLetters >= 4) {
            setSessionAttributes(request, description, ServerResponse.MANY_LETTERS_SENT_ERROR);
            return false;
        }

        return true;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String description = (String) session.getAttribute("description");
        if (description != null) {
            request.setAttribute("descriptionValue", description);
            session.removeAttribute("description");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setSessionAttributes(HttpServletRequest request, String description, ServerResponse serverResponse) {
        request.getSession().setAttribute("description", description);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
