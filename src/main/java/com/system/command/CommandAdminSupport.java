package com.system.command;

import com.system.entity.Letter;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.LetterService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

            // Only not processed letters must be displayed on the site
            List<Letter> letters = LetterService.getInstance().findAllLetters();

            if (letters == null) {
                setRequestAttributes(request, null, false);
                request.setAttribute("response", ServerResponse.SHOW_LETTERS_ERROR.getResponse());
                return pathRedirect;
            }

            List<Letter> notProcessedLetters = new ArrayList<>();
            for (Letter letter : letters) {
                if (!letter.getIsProcessed()) {
                    notProcessedLetters.add(letter);
                }
            }

            // Set Attributes
            if (notProcessedLetters.isEmpty()) {
                setRequestAttributes(request, null, false);
            } else {
                setRequestAttributes(request, notProcessedLetters, true);
            }
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("letters", null);
        request.setAttribute("showLetters", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request, List<Letter> letters, boolean showLetters) {
        request.setAttribute("letters", letters);
        request.setAttribute("showLetters", showLetters);
    }

}
