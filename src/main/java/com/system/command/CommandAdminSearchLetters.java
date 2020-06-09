package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.LetterService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminSearchLetters implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SUPPORT);

            // Form Data
            String typeQuestion = request.getParameter("typeQuestion");
            String startDate = request.getParameter("start-date");
            String finalDate = request.getParameter("final-date");

            // Validation
            if (!validation(request, typeQuestion, startDate, finalDate)) {
                return pathRedirect;
            }

            List<Letter> letters;

            // Action (search letters)
            if (typeQuestion.equals("")) {
                letters = LetterService.getInstance().searchByCriteria(startDate, finalDate);
            } else {
                letters = LetterService.getInstance().searchByCriteria(typeQuestion, startDate, finalDate);
            }

            // Check and set attributes
            if (letters == null) {
                setSessionAttributes(request, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_ERROR);
            } else {
                if (letters.isEmpty()) {
                    setSessionAttributes(request, letters, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_WARNING);
                } else {
                    setSessionAttributes(request, letters, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_SUCCESS);
                }
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String typeQuestion, String startDate, String finalDate) {

        // Validation type question
        if (!typeQuestion.equals("")) {
            if (!Validator.checkTypeQuestion(typeQuestion)) {
                setSessionAttributes(request, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_ERROR);
                return false;
            }
        }

        // Validation start and final dates
        if (!startDate.equals("") && !finalDate.equals("")) {
            if (!Validator.checkDateRange(startDate, finalDate)) {
                setSessionAttributes(request, typeQuestion, ServerResponse.SEARCH_LETTERS_ERROR);
                return false;
            }
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, List<Letter> letters, String typeQuestion,
                                      String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("letters", letters);
        request.getSession().setAttribute("numberOfLetters", String.valueOf(letters.size()));
        request.getSession().setAttribute("typeQuestion", typeQuestion);
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String typeQuestion,
                                      String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("typeQuestion", typeQuestion);
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String typeQuestion, ServerResponse serverResponse) {
        request.getSession().setAttribute("typeQuestion", typeQuestion);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
