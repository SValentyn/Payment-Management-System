package com.system.command;

import com.system.entity.Letter;
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

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SUPPORT);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Set attributes
            if (request.getAttribute("letters") == null) {

                // Only not processed letters must be displayed on the site
                List<Letter> letters = LetterService.getInstance().findAllLetters();

                // Check
                if (letters == null) {
                    setRequestAttributes(request, null);
                    request.setAttribute("response", ServerResponse.SHOW_LETTERS_ERROR.getResponse());
                    return pathRedirect;
                }

                // Data
                List<Letter> notProcessedLetters = new ArrayList<>();
                for (Letter letter : letters) {
                    if (!letter.getIsProcessed()) {
                        notProcessedLetters.add(letter);
                    }
                }

                // Set attributes
                if (notProcessedLetters.isEmpty()) {
                    setRequestAttributes(request, null);
                } else {
                    setRequestAttributes(request, notProcessedLetters);
                }
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("lettersEmpty", null);
        request.setAttribute("letters", null);
        request.setAttribute("typeQuestionValue", null);
        request.setAttribute("startDateValue", null);
        request.setAttribute("finalDateValue", null);
        request.setAttribute("response", "");
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
        request.setAttribute("letters", letters);
        request.setAttribute("lettersEmpty", letters.isEmpty());
    }

}
