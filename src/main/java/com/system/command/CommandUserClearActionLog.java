package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandUserClearActionLog implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACTION_LOG);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACTION_LOG);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");

            // Validation
            if (!validation(request, currentUser)) {
                return pathRedirect;
            }

            // Action (delete profile)
            int status = ActionLogService.getInstance().clearActionLog(currentUser.getUserId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to clear the action log");
                setSessionAttributes(request, ServerResponse.CLEAR_ACTION_LOG_ERROR);
            } else {
                logging(currentUser.getUserId(), "ACTION_LOG_CLEARED");
                setSessionAttributes(request, ServerResponse.CLEAR_ACTION_LOG_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser) {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("response", "");
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) throws SQLException {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
