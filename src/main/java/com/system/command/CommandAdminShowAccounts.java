package com.system.command;

import com.system.entity.Account;
import com.system.manager.HTTPMethod;
import com.system.manager.ResourceManager;
import com.system.manager.ServerResponse;
import com.system.service.AccountService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

public class CommandAdminShowAccounts implements ICommand {

    // Default path
    private String pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNTS);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        clearRequestAttributes(request);

        String method = request.getMethod();
        if (request.getMethod().equalsIgnoreCase(HTTPMethod.POST.name())) {
            return pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.COMMAND_ADMIN_SHOW_ACCOUNTS);
        } else if (method.equalsIgnoreCase(HTTPMethod.GET.name())) {
            pathRedirect = ResourceManager.getInstance().getProperty(ResourceManager.ADMIN_SHOW_ACCOUNTS);

            // Set attributes
            setRequestAttributes(request);
        }

        return pathRedirect;
    }

    private void clearRequestAttributes(HttpServletRequest request) {
        request.setAttribute("accountsEmpty", null);
        request.setAttribute("accounts", null);
        request.setAttribute("response", "");
    }

    private void setRequestAttributes(HttpServletRequest request) throws SQLException {
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

        if (request.getAttribute("accounts") == null) {
            accounts = AccountService.getInstance().findAllAccounts();
            if (accounts != null) {
                request.setAttribute("accountsEmpty", accounts.isEmpty());
                request.setAttribute("accounts", accounts);
            } else {
                request.setAttribute("response", ServerResponse.UNABLE_GET_DATA.getResponse());
            }
        }
    }

}
