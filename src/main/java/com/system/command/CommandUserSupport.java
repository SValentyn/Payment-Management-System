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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandUserSupport implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.USER_SUPPORT);

        request.setAttribute("sended", false);
        request.setAttribute("manyMessagesError", false);
        request.setAttribute("sendLetterError", false);

        User user = (User) request.getSession().getAttribute("currentUser");

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return page;
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {

            // Data
            String typeQuestion = request.getParameter("typeQuestion");
            String description = request.getParameter("description");

            // Check
            if (checkTypeQuestion(request, typeQuestion)) {
                setRequestAttributes(request, typeQuestion, description);
                return page;
            }

            List<Letter> lettersByUserId = LetterService.getInstance().findLettersByUserId(user.getUserId());
            List<Letter> notProcessedLetters = new ArrayList<>();

            for (Letter letter : lettersByUserId) {
                if (!letter.getIsProcessed()) {
                    notProcessedLetters.add(letter);
                }
            }

            if (notProcessedLetters.size() == 4) {
                request.setAttribute("manyMessagesError", true);
                return page;
            }

            // Create
            int status = LetterService.getInstance().addNewLetter(user.getUserId(), typeQuestion, description);
            if (status == 0) {
                request.setAttribute("sendLetterError", true);
                setRequestAttributes(request, typeQuestion, description);
            } else {
                request.setAttribute("sended", true);
            }
        }

        return page;
    }

    private boolean checkTypeQuestion(HttpServletRequest request, String typeQuestion) {
        if (typeQuestion == null || typeQuestion.isEmpty() || typeQuestion.equals("0")) {
            request.setAttribute("typeQuestionError", true);
            return true;
        }
        return false;
    }

    private void setRequestAttributes(HttpServletRequest request, String typeQuestion, String description) {
        request.setAttribute("typeQuestion", typeQuestion);
        request.setAttribute("descriptionValue", description);
    }

}
