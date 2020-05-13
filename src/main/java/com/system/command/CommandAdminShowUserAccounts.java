package com.system.command;

import com.system.entity.Account;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;
import com.system.utils.Validator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowUserAccounts implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_ACCOUNTS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_USER_ACCOUNTS);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_USER_ACCOUNTS);

            // Set attributes obtained from the session
            setRequestAttributes(request);

            // Data
            String userIdParam = request.getParameter("userId");

            // Validation
            if (!validation(request, userIdParam)) {
                return pathRedirect;
            }

            // Set attributes
            if (request.getAttribute("accounts") == null) {
                setRequestAttributes(request, Integer.valueOf(userIdParam));
            }
        }

        return pathRedirect;
    }

    private boolean validation(HttpServletRequest request, String userIdParam) throws SQLException {

        // Validation userId
        if (!Validator.checkUserId(userIdParam) || !Validator.checkUserIsAdmin(userIdParam)) {
            request.setAttribute("response", ServerResponse.UNABLE_GET_USER_ID.getResponse());
            return false;
        } else {
            request.setAttribute("userId", userIdParam);
        }

        return true;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("userId", null);
        request.setAttribute("accountsEmpty", null);
        request.setAttribute("accounts", null);
        request.setAttribute("numberValue", null);
        request.setAttribute("minValue", null);
        request.setAttribute("maxValue", null);
        request.setAttribute("currencyValue", null);
        request.setAttribute("response", "");
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

    private void setRequestAttributes(HttpServletRequest request, Integer userId) throws SQLException {
        List<Account> accounts = AccountService.getInstance().findAllAccountsByUserId(userId);
        if (accounts != null) {
            request.setAttribute("accountsEmpty", accounts.isEmpty());
            request.setAttribute("accounts", accounts);
        } else {
            request.setAttribute("response", ServerResponse.SHOW_USER_ACCOUNTS_ERROR.getResponse());
        }
    }

}
