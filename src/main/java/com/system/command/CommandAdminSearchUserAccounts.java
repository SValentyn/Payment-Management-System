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
import java.sql.SQLException;
import java.util.List;

public class CommandAdminSearchUserAccounts implements ICommand {

    private String pathRedirect;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_ACCOUNTS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER_ACCOUNTS);

            // Form Data
            String userIdParam = request.getParameter("userId");
            String number = request.getParameter("number");
            String min_value = request.getParameter("min-value");
            String max_value = request.getParameter("max-value");
            String currency = request.getParameter("currency");

            // Validation
            if (!validation(request, userIdParam, number, min_value, max_value, currency)) {
                return pathRedirect;
            }

            List<Account> accounts;

            // Action (determine the upper limit of the value of balances and search)
            if (max_value.equals("10000")) {
                accounts = AccountService.getInstance().searchByCriteria(Integer.valueOf(userIdParam), number, min_value, String.valueOf(Integer.MAX_VALUE), currency);
            } else {
                accounts = AccountService.getInstance().searchByCriteria(Integer.valueOf(userIdParam), number, min_value, max_value, currency);
            }

            // Check and set attributes
            if (accounts == null) {
                setSessionAttributes(request, number, min_value, max_value, currency, ServerResponse.SEARCH_ACCOUNTS_ERROR);
            } else {
                if (accounts.isEmpty()) {
                    setSessionAttributes(request, accounts, number, min_value, max_value, currency, ServerResponse.SEARCH_ACCOUNTS_WARNING);
                } else {
                    setSessionAttributes(request, accounts, number, min_value, max_value, currency, ServerResponse.SEARCH_ACCOUNTS_SUCCESS);
                }
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam, String number, String min_value, String max_value, String currency) {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            setSessionAttributes(request, number, min_value, max_value, currency, ServerResponse.UNABLE_GET_USER_ID);
            return false;
        }

        // Change redirect path
        pathRedirect += "&userId=" + userIdParam;

        // Validation min and max values
        if (Validator.isNegative(min_value) || Validator.isNegative(max_value) || Integer.parseInt(min_value) > Integer.parseInt(max_value)) {
            setSessionAttributes(request, number, "0", "10000", currency, ServerResponse.SEARCH_ACCOUNTS_ERROR);
            return false;
        }

        return true;
    }

    private void setSessionAttributes(HttpServletRequest request, List<Account> accounts, String number,
                                      String minValue, String maxValue, String currency, ServerResponse serverResponse) {
        request.getSession().setAttribute("accounts", accounts);
        request.getSession().setAttribute("numberOfAccounts", String.valueOf(accounts.size()));
        request.getSession().setAttribute("number", number);
        request.getSession().setAttribute("minValue", minValue);
        request.getSession().setAttribute("maxValue", maxValue);
        request.getSession().setAttribute("currency", currency);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

    private void setSessionAttributes(HttpServletRequest request, String number,
                                      String minValue, String maxValue, String currency, ServerResponse serverResponse) {
        request.getSession().setAttribute("number", number);
        request.getSession().setAttribute("minValue", minValue);
        request.getSession().setAttribute("maxValue", maxValue);
        request.getSession().setAttribute("currency", currency);
        request.getSession().setAttribute("response", serverResponse.getResponse());
    }

}
