package com.system.command;

import com.system.entity.Letter;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;
import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommandAdminSupport implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String page = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SUPPORT);
        request.getSession().setAttribute("numberOfLetters", LetterService.getInstance().findUnprocessedLetters().size());

        List<Letter> letters = LetterService.getInstance().findAllLetters();
        List<Letter> notProcessedLetters = new ArrayList<>();

        for (Letter letter : letters) {
            if (!letter.getIsProcessed()) {
                notProcessedLetters.add(letter);
            }
        }

        if (notProcessedLetters.isEmpty()) {
            request.setAttribute("showLetters", false);
            return page;
        }

        request.setAttribute("letters", notProcessedLetters);
        request.setAttribute("showLetters", true);

        return page;
    }

}
