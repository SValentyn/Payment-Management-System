package com.system.command;

import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.ActionLogService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

public class CommandAdminClearActionLog implements ICommand {

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

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACTION_LOG);

            // Action (clear action log)
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

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
