package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.service.UserService;
import com.system.utils.Validator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminDeleteUser implements ICommand {

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name()) || method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER);

            // URL Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!validation(request, userIdParam)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete a user from the system");
                return pathRedirect;
            }

            // Data
            User user = UserService.getInstance().findUserById(Integer.valueOf(userIdParam));

            // Action (delete user)
            int status = UserService.getInstance().deleteUserById(user.getUserId());
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to delete a user from the system. User [" + user.getName() + " " + user.getSurname() + "]");
                setSessionAttributes(request, ServerResponse.USER_DELETED_ERROR);
            } else {
                pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_INDEX);
                logging(currentUser.getUserId(), "DELETED: User [" + user.getName() + " " + user.getSurname() + "] has been successfully deleted from the system");
                setSessionAttributes(request, ServerResponse.USER_DELETED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            setSessionAttributes(request, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Data
        Integer userId = Integer.valueOf(userIdParam);
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);

        // Checking that there are no funds left in the user’s accounts
        for (Account account : accounts) {
            BigDecimal balance = account.getBalance();
            if (balance.compareTo(BigDecimal.ZERO) != 0) {
                setSessionAttributes(request, ServerResponse.USER_HAS_FUNDS_ERROR);
                return false;
            }
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
