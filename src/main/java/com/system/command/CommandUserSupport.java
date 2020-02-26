package com.system.command;

import com.system.entity.Letter;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserSupport implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_SUPPORT);

        request.setAttribute("sended", false);
        request.setAttribute("manyLettersError", false);
        request.setAttribute("sendLetterError", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String typeQuestion = new String(request.getParameter("typeQuestion").getBytes(), StandardCharsets.UTF_8);
            String description = new String(request.getParameter("description").getBytes(), StandardCharsets.UTF_8);

            // Data
            List<Letter> lettersByUserId = LetterService.getInstance().findLettersByUserId(user.getUserId());
            List<Letter> notProcessedLetters = new ArrayList<>();
            for (Letter letter : lettersByUserId) {
                if (!letter.getIsProcessed()) {
                    notProcessedLetters.add(letter);
                }
            }

            // Check
            if (notProcessedLetters.size() == 4) {
                setRequestAttributes(request, typeQuestion, description);
                request.setAttribute("manyLettersError", true);
                return page;
            }

            // Create
            int status = LetterService.getInstance().addNewLetter(user.getUserId(), typeQuestion, description);
            if (status == 0) {
                setRequestAttributes(request, typeQuestion, description);
                request.setAttribute("sendLetterError", true);
            } else {
                request.setAttribute("sended", true);
            }
        }

        return page;
    }

    private void setRequestAttributes(HttpServletRequest request, String typeQuestion, String description) {
        request.setAttribute("typeQuestionValue", typeQuestion);
        request.setAttribute("descriptionValue", description);
    }

}
