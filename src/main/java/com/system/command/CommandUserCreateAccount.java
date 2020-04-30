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

public class CommandUserCreateAccount implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_CREATE_ACCOUNT);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_CREATE_ACCOUNT);

            // Set attributes obtained from the session
            setRequestAttributes(request);

        } else if (method.equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_CREATE_ACCOUNT);

            // Data
            User user = (User) request.getSession().getAttribute("currentUser");

            // Check
            if (user == null) {
                setSessionAttributes(request, ServerResponse.UNABLE_GET_USER);
                return pathRedirect;
            }

            // Data
            Integer userId = user.getUserId();
            String number = request.getParameter("number");
            String currency = request.getParameter("currency");

            // Validation
            if (!validation(request, userId, number, currency)) {
                return pathRedirect;
            }

            // Action (create account)
            int status = AccountService.getInstance().createAccount(userId, number, currency);
            if (status == 0) {
                setSessionAttributes(request, ServerResponse.ACCOUNT_CREATED_ERROR);
            } else {
                setSessionAttributes(request, ServerResponse.ACCOUNT_CREATED_SUCCESS);
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, Integer userId, String number, String currency) throws SQLException {

        // Validation number
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
        for (Account account : AccountService.getInstance().findAllAccountsByUserId(userId)) {
            if (account.getCurrency().equals(currency)) numberOfAccounts++;
        }

        // Checking that a user cannot have more than 3 accounts with a certain currency
        if (numberOfAccounts == 3) {
            setSessionAttributes(request, ServerResponse.MANY_ACCOUNT_WITH_THIS_CURRENCY_ERROR);
            return false;
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("numberValue", null);
        request.setAttribute("currencyValue", null);
        request.setAttribute("response", "");
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

}
