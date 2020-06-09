package com.system.command;

import com.system.entity.Account;
import com.system.entity.User;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandUserShowAccounts implements ICommand {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // Default path
        String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNTS);

        // Receiving the user from whom the request came
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            setRequestAttributes(request, ServerResponse.UNABLE_GET_DATA);
            return pathRedirect;
        }

        // Request processing depending on the HTTP method
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.USER_SHOW_ACCOUNTS);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Check and set attributes
            if (request.getAttribute("accounts") == null) {
                setRequestAttributes(request, currentUser);
            }
        } else {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_USER_SHOW_ACCOUNTS);
        }

        return pathRedirect;
    }

    private void setRequestAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession();

        List<Account> accounts = (List<Account>) session.getAttribute("accounts");
        if (accounts != null) {
            request.setAttribute("accountsEmpty", false);
            request.setAttribute("accounts", accounts);
            session.removeAttribute("accounts");
        }

        String numberOfAccounts = (String) session.getAttribute("numberOfAccounts");
        if (numberOfAccounts != null) {
            request.setAttribute("numberOfAccounts", numberOfAccounts);
            session.removeAttribute("numberOfAccounts");
        }

        String number = (String) session.getAttribute("number");
        if (number != null) {
            request.setAttribute("numberValue", number);
            session.removeAttribute("number");
        }

        String minValue = (String) session.getAttribute("minValue");
        if (minValue != null) {
            request.setAttribute("minValue", minValue);
            session.removeAttribute("minValue");
        }

        String maxValue = (String) session.getAttribute("maxValue");
        if (maxValue != null) {
            request.setAttribute("maxValue", maxValue);
            session.removeAttribute("maxValue");
        }

        String currency = (String) session.getAttribute("currency");
        if (currency != null) {
            request.setAttribute("currencyValue", currency);
            session.removeAttribute("currency");
        }

        String response = (String) session.getAttribute("response");
        if (response != null) {
            request.setAttribute("response", response);
            session.removeAttribute("response");
        }
    }

    private void setRequestAttributes(HttpServletRequest request, User currentUser) {
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(currentUser.getUserId());
        if (accounts != null) {
            request.setAttribute("accountsEmpty", accounts.isEmpty());
            request.setAttribute("accounts", accounts);
        } else {
            request.setAttribute("response", ServerResponse.SHOW_USER_ACCOUNTS_ERROR.getResponse());
        }
    }

    private void setRequestAttributes(HttpServletRequest request, ServerResponse serverResponse) {
        request.setAttribute("response", serverResponse.getResponse());
    }

}
