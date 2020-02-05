package com.system.command;

import com.system.entity.Letter;
import com.system.manager.ResourceManager;
import com.system.service.LetterService;

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

        List<Letter> allLetters = LetterService.getInstance().findAllLetters();
        List<Letter> notProcessedLetters = new ArrayList<>();

        for (Letter letter : allLetters) {
            if (!letter.getIsProcessed()) {
                notProcessedLetters.add(letter);
            }
        }

        if (notProcessedLetters.isEmpty()) {
            request.setAttribute("showLetters", false);
            return page;
        }

        request.setAttribute("showLetters", true);
        request.setAttribute("letters", notProcessedLetters);

        return page;
    }
}
