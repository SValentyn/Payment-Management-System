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
import java.util.ArrayList;
import java.util.List;

public class CommandAdminSupport implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Check and set attributes
            if (request.getAttribute("letters") == null) {

                // Only not processed letters must be displayed on the site
                List<Letter> letters = LetterService.getInstance().findAllLetters();
                List<Letter> notProcessedLetters = new ArrayList<>();

                if (letters != null) {
                    for (Letter letter : letters) {
                        if (!letter.getIsProcessed()) {
                            notProcessedLetters.add(letter);
                        }
                    }
                } else {
                    setRequestAttributes(request, ServerResponse.SHOW_LETTERS_ERROR);
                }

                // Set attributes
                setRequestAttributes(request, notProcessedLetters);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SUPPORT);
        }

        return pathRedirect;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        List<Letter> letters = (List<Letter>) session.getAttribute("letters");
        if (letters != null) {
            request.setAttribute("lettersEmpty", false);
            request.setAttribute("letters", letters);
            session.removeAttribute("letters");
        }

        String numberOfLetters = (String) session.getAttribute("numberOfLetters");
        if (numberOfLetters != null) {
            request.setAttribute("numberOfLetters", numberOfLetters);
            session.removeAttribute("numberOfLetters");
        }

        String typeQuestion = (String) session.getAttribute("typeQuestion");
        if (typeQuestion != null) {
            request.setAttribute("typeQuestionValue", typeQuestion);
            session.removeAttribute("typeQuestion");
        }

        String startDate = (String) session.getAttribute("startDate");
        if (startDate != null) {
            request.setAttribute("startDateValue", startDate);
            session.removeAttribute("startDate");
        }

        String finalDate = (String) session.getAttribute("finalDate");
        if (finalDate != null) {
            request.setAttribute("finalDateValue", finalDate);
            session.removeAttribute("finalDate");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, List<Letter> letters) {
        if (letters.isEmpty()) {
            request.setAttribute("lettersEmpty", true);
        } else {
            request.setAttribute("letters", letters);
            request.setAttribute("lettersEmpty", false);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
