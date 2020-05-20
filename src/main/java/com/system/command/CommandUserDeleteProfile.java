package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

public class CommandUserDeleteProfile implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_UPDATE_PERSONAL_DATA);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_UPDATE_PERSONAL_DATA);

            // Data
            User currentUser = (User) request.getSession().getAttribute("currentUser");

            // Validation
            if (!validation(request, currentUser)) {
                if (currentUser != null)
                    logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete a profile");
                return pathRedirect;
            }

            // Action (delete profile)
            int status = UserService.getInstance().deleteUserById(currentUser.getUserId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete a profile");
                setSessionAttributes(request, ServerResponse.PROFILE_DELETED_ERROR);
            } else {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
                request.getSession().invalidate();
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser) throws SQLException {

        // Check
        if (currentUser == null) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return false;
        }

        // Checking that there are no funds left in the user’s accounts
        for (Account account : AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId())) {
            BigDecimal balance = account.getBalance();
            if (balance.compareTo(BigDecimal.ZERO) != 0) {
                setSessionAttributes(request, ServerResponse.USER_HAS_FUNDS_ERROR);
                return false;
            }
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
