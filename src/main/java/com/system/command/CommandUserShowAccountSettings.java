package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandUserShowAccountSettings implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_SETTINGS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNT_SETTINGS);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // URL Data
            String accountIdParam = request.getParameter("accountId");

            // Validation
            if (!validation(request, currentUser, accountIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            setRequestAttributes(request, Integer.valueOf(accountIdParam));
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACCOUNT_SETTINGS);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String accountIdParam) {

        // Return from the command if the account was successfully deleted
        if (request.getAttribute("response").equals(ServerResponse.ACCOUNT_DELETED_SUCCESS.getResponse())) {
            return false;
        }

        // Validation accountId
        if (!Validator.checkAccountId(accountIdParam)) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_ACCOUNT_ID);
            return false;
        }

        // Data
        Account account = AccountService.getInstance().findAccountByAccountId(Integer.valueOf(accountIdParam));

        // Checking that the account belongs to the user
        if (!account.getUserId().equals(currentUser.getUserId())) {
            setRequestAttributes(request, ServerResponse.SHOW_ACCOUNT_ERROR);
            return false;
        }

        return true;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, Integer accountId) {
        Account viewableAccount = AccountService.getInstance().findAccountByAccountId(accountId);
        if (viewableAccount != null) {
            request.setAttribute("viewableAccount", viewableAccount);
        } else {
            setRequestAttributes(request, ServerResponse.SHOW_ACCOUNT_ERROR);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
