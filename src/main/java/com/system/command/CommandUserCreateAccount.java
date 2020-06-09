package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.service.ActionLogService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;

public class CommandUserCreateAccount implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_CREATE_ACCOUNT);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_CREATE_ACCOUNT);

            // Form Data
            String number = request.getParameter("number");
            String currency = request.getParameter("currency");

            // Validation
            if (!validation(request, currentUser, number, currency)) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to create a new account");
                return pathRedirect;
            }

            // Action (create account)
            int status = AccountService.getInstance().addNewAccount(currentUser.getUserId(), number, currency);
            if (status == 0) {
                logging(currentUser.getUserId(), "ERROR: Unsuccessful attempt to create a new account");
                setSessionAttributes(request, ServerResponse.ACCOUNT_CREATED_ERROR);
            } else {
                logging(currentUser.getUserId(), "CREATED: Account [" + number + ", " + currency + "]");
                setSessionAttributes(request, ServerResponse.ACCOUNT_CREATED_SUCCESS);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_CREATE_ACCOUNT);

            // Set attributes obtained from the session
            setRequestAttributes(request);
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, User currentUser, String number, String currency) {

        // Validation account number
        if (!Validator.checkAccountNumber(number)) {
            setSessionAttributes(request, ServerResponse.ACCOUNT_CREATED_ERROR);
            return false;
        }

        // Validation currency
        if (!Validator.checkCurrency(currency)) {
            setSessionAttributes(request, ServerResponse.ACCOUNT_CREATED_ERROR);
            return false;
        }

        // Data
        int numberOfAccounts = 0;
        for (Account account : AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId())) {
            if (account.getCurrency().equals(currency)) numberOfAccounts++;
        }

        // Checking that a user cannot have more than 3 accounts with a certain currency
        if (numberOfAccounts >= 3) {
            setSessionAttributes(request, ServerResponse.MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR);
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

    private void setSessionAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void logging(Integer userId, String description) {
        ActionLogService.getInstance().addNewLogEntry(userId, description);
    }

}
