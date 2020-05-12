package com.system.command;

import com.system.entity.Letter;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.LetterService;
import com.system.utils.Validator;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminSearchLetters implements ICommand {

    private static final Logger LOGGER = LogManager.getLogger(CommandAdminSearchLetters.class);

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SUPPORT);

            // Data
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

            // Set attributes
            if (letters == null) {
                setSessionAttributes(request, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_ERROR);
                LOGGER.error("3");
                return pathRedirect;
            }

            // Set attributes
            if (letters.size() == 0) {
                setSessionAttributes(request, letters, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_WARNING);
            } else {
                setSessionAttributes(request, letters, typeQuestion, startDate, finalDate, ServerResponse.SEARCH_LETTERS_SUCCESS);
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
                LOGGER.error("2");
                return false;
            }
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("letters", null);
        request.setAttribute("typeQuestionValue", null);
        request.setAttribute("startDateValue", null);
        request.setAttribute("finalDateValue", null);
        request.setAttribute("response", "");
    }

    private void setSessionAttributes(HttpServletRequest request, List<Letter> letters, String typeQuestion, String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("letters", letters);
        request.getSession().setAttribute("numberOfLetters", String.valueOf(letters.size()));
        request.getSession().setAttribute("typeQuestion", typeQuestion);
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String typeQuestion, String startDate, String finalDate, ServerResponse serverResponse) {
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
