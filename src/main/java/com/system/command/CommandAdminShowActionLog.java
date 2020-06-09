package com.system.command;

import com.system.entity.LogEntry;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowActionLog implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACTION_LOG);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACTION_LOG);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Check and set attributes
            if (request.getAttribute("logEntries") == null) {
                setRequestAttributes(request, currentUser);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACTION_LOG);
        }

        return pathRedirect;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        List<LogEntry> logEntries = (List<LogEntry>) session.getAttribute("logEntries");
        if (logEntries != null) {
            request.setAttribute("logEntries", logEntries);
            session.removeAttribute("logEntries");
        }

        String numberOfLogEntries = (String) session.getAttribute("numberOfLogEntries");
        if (numberOfLogEntries != null) {
            request.setAttribute("numberOfLogEntries", numberOfLogEntries);
            session.removeAttribute("numberOfLogEntries");
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

    private void setRequestAttributes(HttpServletRequest request, User user) {
        List<LogEntry> logEntries = ActionLogService.getInstance().findLogEntriesByUserId(user.getUserId());
        if (logEntries != null) {
            request.setAttribute("logEntries", logEntries);
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_ACTION_LOG_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
