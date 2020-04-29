package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.LetterService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class CommandUserSupport implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SUPPORT);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SUPPORT);

            // Set attributes obtained from the session
            setRequestAttributes(request);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SUPPORT);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check
            if (user == null) {
                setSessionAttributes(request, ServerResponse.UNABLE_GET_USER);
                return pathRedirect;
            }

            // Data
            String typeQuestion = request.getParameter("typeQuestion");
            String description = request.getParameter("description");

            // Validation
            if (!validation(request, user, typeQuestion, description)) {
                return pathRedirect;
            }

            // Action
            int status = LetterService.getInstance().addNewLetter(user.getUserId(), typeQuestion, description);
            if (status == 0) {
                setSessionAttributes(request, typeQuestion, description, ServerResponse.LETTER_SENT_ERROR);
            } else {
                setSessionAttributes(request, ServerResponse.LETTER_SENT_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User user, String typeQuestion, String description) throws SQLException {

        // Validation type question
        if (typeQuestion == null || typeQuestion.equals("")) {
            setSessionAttributes(request, ServerResponse.LETTER_SENT_ERROR);
            return false;
        }

        // Data
        int numberOfNotProcessedLetters = 0;
        for (Letter letter : LetterService.getInstance().findLettersByUserId(user.getUserId())) {
            if (!letter.getIsProcessed()) numberOfNotProcessedLetters++;
        }

        // Checking that the user has sent in support of more than 3 letters that have not yet been processed
        if (numberOfNotProcessedLetters == 4) {
            setSessionAttributes(request, typeQuestion, description, ServerResponse.MANY_LETTERS_SENT_ERROR);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("typeQuestionValue", null);
        request.setAttribute("descriptionValue", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String typeQuestion = (String) session.getAttribute("typeQuestion");
        if (typeQuestion != null) {
            request.setAttribute("typeQuestionValue", typeQuestion);
            session.removeAttribute("typeQuestion");
        }

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

    private void setSessionAttributes(HttpServletRequest request, String typeQuestion, String description, ServerResponse serverResponse) {
        request.getSession().setAttribute("typeQuestion", typeQuestion);
        request.getSession().setAttribute("description", description);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
