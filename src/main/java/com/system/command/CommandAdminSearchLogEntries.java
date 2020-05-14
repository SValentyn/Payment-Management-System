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

public class CommandAdminSearchLogEntries implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACTION_LOG);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACTION_LOG);
        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACTION_LOG);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            String startDate = request.getParameter("start-date");
            String finalDate = request.getParameter("final-date");

            // Validation
            if (!validation(request, currentUser, startDate, finalDate)) {
                return pathRedirect;
            }

            // Action (search letters)
            List<LogEntry> logEntries = ActionLogService.getInstance().searchByCriteria(currentUser.getUserId(), startDate, finalDate);

            // Set attributes
            if (logEntries == null) {
                setSessionAttributes(request, startDate, finalDate, ServerResponse.SEARCH_LOG_ENTRIES_ERROR);
                return pathRedirect;
            }

            // Set attributes
            if (logEntries.size() == 0) {
                setSessionAttributes(request, logEntries, startDate, finalDate, ServerResponse.SEARCH_LOG_ENTRIES_WARNING);
            } else {
                setSessionAttributes(request, logEntries, startDate, finalDate, ServerResponse.SEARCH_LOG_ENTRIES_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String startDate, String finalDate) {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Validation start and final dates
        if (!startDate.equals("") && !finalDate.equals("")) {
            if (!Validator.checkDateRange(startDate, finalDate)) {
                setSessionAttributes(request, ServerResponse.SEARCH_LOG_ENTRIES_ERROR);
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
