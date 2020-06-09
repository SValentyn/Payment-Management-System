package com.system.command;

import com.system.entity.LogEntry;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

public class CommandUserSearchLogEntries implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACTION_LOG);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACTION_LOG);

            // Form Data
            String startDate = request.getParameter("start-date");
            String finalDate = request.getParameter("final-date");

            // Validation
            if (!validation(request, startDate, finalDate)) {
                return pathRedirect;
            }

            // Action (search log entries)
            List<LogEntry> logEntries = ActionLogService.getInstance().searchByCriteria(currentUser.getUserId(), startDate, finalDate);

            // Check and set attributes
            if (logEntries == null) {
                setSessionAttributes(request, startDate, finalDate, ServerResponse.SEARCH_LOG_ENTRIES_ERROR);
            } else {
                if (logEntries.isEmpty()) {
                    setSessionAttributes(request, logEntries, startDate, finalDate, ServerResponse.SEARCH_LOG_ENTRIES_WARNING);
                } else {
                    setSessionAttributes(request, logEntries, startDate, finalDate, ServerResponse.SEARCH_LOG_ENTRIES_SUCCESS);
                }
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACTION_LOG);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String startDate, String finalDate) {

        // Validation start and final dates
        if (!startDate.equals("") && !finalDate.equals("")) {
            if (!Validator.checkDateRange(startDate, finalDate)) {
                setSessionAttributes(request, ServerResponse.SEARCH_LOG_ENTRIES_ERROR);
                return false;
            }
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, List<LogEntry> logEntries, String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("logEntries", logEntries);
        request.getSession().setAttribute("numberOfLogEntries", String.valueOf(logEntries.size()));
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String startDate, String finalDate, ServerResponse serverResponse) {
        request.getSession().setAttribute("startDate", startDate);
        request.getSession().setAttribute("finalDate", finalDate);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
